//
//  WelcomeViewModel.swift
//  HairScan
//
//  Created by Pasquale Pagano on 30/10/25.
//

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
    
    private let hairDetectionModel: VNCoreMLModel
    private let hairScanModel: VNCoreMLModel
    
    init() {
        do {
            let detectionConfig = MLModelConfiguration()
            hairDetectionModel = try VNCoreMLModel(for: HairDetection(configuration: detectionConfig).model)
            
            let scanConfig = MLModelConfiguration()
            hairScanModel = try VNCoreMLModel(for: HairScan(configuration: scanConfig).model)
        } catch {
            fatalError("Errore critico: impossibile caricare i modelli Core ML: \(error)")
        }
        loadHistory()
    }
    
    // MARK: - Elaborazione immagine
    func processImage(_ image: UIImage) {
        print("ViewModel: Inizio elaborazione...")
        
        detectHair(image: image) { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                if result == "Hair" {
                    self.scanHair(image: image) { scanResult in
                        DispatchQueue.main.async {
                            print("ViewModel: Scansione completata: \(scanResult)")
                            
                            self.risultatoFinale = scanResult
                            self.selectedMask = self.randomMask(for: scanResult)
                            
                            if let mask = self.selectedMask {
                                let newResult = AnalysisResult(
                                    date: Date(),
                                    healthStatus: scanResult,
                                    maskName: mask.maskName
                                )
                                
                                // Inseriamo in cima alla history
                                self.historyResults.insert(newResult, at: 0)
                                
                                // Salviamo subito su UserDefaults
                                self.saveHistory()
                                
                                self.alertMessage = """
                                Condizione: \(scanResult)
                                Maschera consigliata: \(mask.maskName)
                                """
                                
                            } else {
                                self.alertMessage = "Nessuna maschera trovata per \(scanResult)"
                            }
                            
                            self.showAlert = true
                        }
                    }
                } else {
                    self.alertMessage = "Capelli non rilevati. Riprova con un’altra foto."
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
            maskName: mask.maskName
        )
        historyResults.insert(newResult, at: 0)
        risultatoFinale = healthStatus
        selectedMask = mask
        // If you need the date later, you can access `newResult.date`
    }
    
    // MARK: - Funzioni interne ML simulate
    private func detectHair(image: UIImage, completion: @escaping (String) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            completion(Bool.random() ? "Hair" : "NoHair")
        }
    }
    
    private func scanHair(image: UIImage, completion: @escaping (String) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.5) {
            let results = ["Healthy", "Damaged", "Extreme damaged"]
            completion(results.randomElement()!)
        }
    }
    
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

