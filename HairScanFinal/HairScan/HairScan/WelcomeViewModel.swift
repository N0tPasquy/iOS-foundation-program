//
//  WelcomeViewModel.swift
//  HairScan
//
//  Created by Pasquale Pagano & Daniele Mele on 30/10/25.
//
// MARK: - File che contiene la logica più importante dell'app

import SwiftUI
import CoreML
import Vision
import UIKit
internal import Combine

class WelcomeViewModel: ObservableObject {
    @Published var alertMessage = ""
    @Published var showAlert = false
    @Published var risultatoFinale: String = ""
    @Published var selectedMask: MaskList?
    @Published var historyResults: [AnalysisResult] = [] // STORICO SCANSIONI
    private var historyKey: String { "HistoryResultsKey" }
     
    private let hairDetectionModel: VNCoreMLModel // RI-AGGIUNTO
    private let hairScanModel: VNCoreMLModel
     
    init() {
        do {
            let detectionConfig = MLModelConfiguration() // RI-AGGIUNTO
            hairDetectionModel = try VNCoreMLModel(for: HairDetection(configuration: detectionConfig).model) // RI-AGGIUNTO
             
            let scanConfig = MLModelConfiguration()
            hairScanModel = try VNCoreMLModel(for: HairScan(configuration: scanConfig).model)
        } catch {
            fatalError("Critical error: Failed to load Core ML models: \(error)")
        }
        loadHistory()
    }
     
    // MARK: - Elaborazione immagine
     
    // --- MODIFICHE QUI (Funzione interamente riscritta per gestire i 2 step) ---
    func processImage(_ image: UIImage) {
        print("ViewModel: Processing begins...")
         
        // STEP 1: Rileva se ci sono capelli
        self.detectHair(image: image) { [weak self] detectionResult in
            guard let self = self else { return }
             
            DispatchQueue.main.async {
                // Se vengono rilevati capelli, procedi con lo STEP 2
                if detectionResult == "Hair" {
                     
                    // STEP 2: Scansiona lo stato di salute
                    self.scanHair(image: image) { scanResult in
                        DispatchQueue.main.async {
                            print("ViewModel: Scan completed: \(scanResult)")
                             
                            self.risultatoFinale = scanResult
                            self.selectedMask = self.randomMask(for: scanResult)
                             
                            if let mask = self.selectedMask {
                                let imageData = image.jpegData(compressionQuality: 0.8) // conversione immagine
                                let newResult = AnalysisResult(
                                    date: Date(),
                                    healthStatus: scanResult,
                                    maskName: mask.maskName,
                                    imageData : imageData
                                )
                                 
                                // Inseriamo in cima alla history
                                self.historyResults.insert(newResult, at: 0)
                                 
                                // Salviamo subito su UserDefaults
                                self.saveHistory()
                                 
                                // Il messaggio di alert ora mostra solo il risultato della scansione
                                self.alertMessage = """
                                Condition: \(scanResult)
                                Recommended mask: \(mask.maskName)
                                """
                                 
                            } else {
                                self.alertMessage = "No mask found for \(scanResult)"
                            }
                            self.showAlert = true
                        }
                    }
                } else {
                    // Se non vengono rilevati capelli (o c'è un errore), mostra l'alert
                    print("ViewModel: Hair detection failed. Result: \(detectionResult)")
                    self.alertMessage = "Hair not detected. Try again with another photo."
                    self.showAlert = true
                }
            }
        }
    }
     
    // MARK: - Eliminazione elemento dalla history
    func deleteHistoryItem(_ item: AnalysisResult) {
        if let index = historyResults.firstIndex(where: { $0.id == item.id }) {
            historyResults.remove(at: index)
             
            //  Aggiornamento LastScanView
            if risultatoFinale == item.healthStatus {
                if let last = historyResults.first {
                    // Mostra la nuova ultima scansione
                    risultatoFinale = last.healthStatus
                    let allMasks = healthyHairMasks + damagedHairMask + veryDamagedHairMask
                    selectedMask = allMasks.first { $0.maskName == last.maskName }
                } else {
                    // Nessuna scansione rimasta → reset
                    risultatoFinale = ""
                    selectedMask = nil
                }
            }
        }
        saveHistory()
    }
     
    // MARK: - Funzione di aggiunta nuovo risultato
    func addHistoryItem(healthStatus: String, mask: MaskList) {
        let newResult = AnalysisResult(
            date: Date(),
            healthStatus: healthStatus,
            maskName: mask.maskName,
            imageData: nil
        )
        historyResults.insert(newResult, at: 0)
        risultatoFinale = healthStatus
        selectedMask = mask
    }
     
    // MARK: - Funzione di RILEVAMENTO REALE (Hair/NoHair)
    private func detectHair(image: UIImage, completion: @escaping (String) -> Void) {
        print("CoreML: Starting REAL detection (Hair/NoHair)...")
         
        guard let ciImage = CIImage(image: image) else {
            print("Error: Failed to convert UIImage to CIImage.")
            completion("Detection Error")
            return
        }
         
        //Crea la richiesta per il modello HairDetection
        let request = VNCoreMLRequest(model: hairDetectionModel) { (request, error) in
             
            //Gestisci il risultato (o l'errore)
            if let error = error {
                print("Error: Vision request failed (detectHair): \(error.localizedDescription)")
                completion("Detection Error")
                return
            }
             
            //Estrae i risultati della classificazione
            guard let results = request.results as? [VNClassificationObservation] else {
                print("Error: Model did not return VNClassificationObservation (detectHair).")
                completion("Detection Error")
                return
            }
             
            //trova il risultato migliore
            if let bestResult = results.first {
                let identifier = bestResult.identifier // "Hair" or "NoHair"
                let confidence = bestResult.confidence
                print("CoreML: Detection complete. Best result: \(identifier) (Confidence: \(confidence))")
                
                completion(identifier)
                 
            } else {
                print("Error: No classification results found (detectHair).")
                completion("Detection Error")
            }
        }
         
        //Esegu la richiesta
        let handler = VNImageRequestHandler(ciImage: ciImage)
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                try handler.perform([request])
            } catch {
                print("Error: Failed to perform Vision request (detectHair): \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion("Detection Error")
                }
            }
        }
    }
     
    // MARK: - Funzione di scansione REALE
    private func scanHair(image: UIImage, completion: @escaping (String) -> Void) {
        print("CoreML: Starting REAL scan...")
         
        // Check sul formato dell'immagine
        guard let ciImage = CIImage(image: image) else {
            print("Error: Failed to convert UIImage to CIImage.")
            completion("Scan Error")
            return
        }
         
        //richiesta per il modello HairScan
        let request = VNCoreMLRequest(model: hairScanModel) { (request, error) in
             
            //Gestisce il risultato
            if let error = error {
                print("Error: Vision request failed: \(error.localizedDescription)")
                completion("Scan Error")
                return
            }
             
            //Estrae i risultati della classificazione
            guard let results = request.results as? [VNClassificationObservation] else {
                print("Error: Model did not return VNClassificationObservation.")
                completion("Scan Error")
                return
            }
             
            //Trova il risultato con la confidenza più alta
            if let bestResult = results.first {
                let identifier = bestResult.identifier
                let confidence = bestResult.confidence
                 
                completion(identifier)
                 
            } else {
                print("Error: nessuna classificazione trovata")
                completion("Scan Error")
            }
        }
         
        //Esegue la richiesta
        let handler = VNImageRequestHandler(ciImage: ciImage)
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                try handler.perform([request])
            } catch {
                print("Error: Failed to perform Vision request: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion("Scan Error")
                }
            }
        }
    }
     
    // MARK: - Selezione randomica della mask rispetto allo stato dei capelli
    private func randomMask(for condition: String) -> MaskList? {
        switch condition {
        case "Healthy":
            return healthyHairMasks.randomElement()
        case "Damaged":
            return damagedHairMask.randomElement()
        case "Extreme damaged":
            return veryDamagedHairMask.randomElement()
        default:
            return nil
        }
    }
     
    // MARK: - Funzioni per salvare e visualizzare le scansioni fatte in precedenza
    func saveHistory() {
        if let encoded = try? JSONEncoder().encode(historyResults) {
            UserDefaults.standard.set(encoded, forKey: historyKey)
        }
    }
     
    func loadHistory() {
        if let data = UserDefaults.standard.data(forKey: historyKey),
           let decoded = try? JSONDecoder().decode([AnalysisResult].self, from: data) {
            self.historyResults = decoded
            // Aggiorna la last scan se c'è almeno un elemento
            if let last = decoded.first {
                self.risultatoFinale = last.healthStatus
                self.selectedMask = randomMask(for: last.healthStatus)
            }
        }
    }
     
}
