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
    @Published var historyResults: [AnalysisResult] = [] // 👈 STORICO SCANSIONI
    
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
    }
    
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
                                // ✅ Creiamo un nuovo elemento History
                                let newResult = AnalysisResult(
                                    date: Date(),
                                    healthStatus: scanResult,
                                    maskName: mask.maskName
                                )
                                self.historyResults.insert(newResult, at: 0) // lo mettiamo in cima
                                
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
}
