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

// 1. La classe è un ObservableObject per "pubblicare" cambiamenti alla View
class WelcomeViewModel: ObservableObject {
    
    // 2. Questi @Published aggiorneranno automaticamente la View
    @Published var alertMessage = ""
    @Published var showAlert = false
    
    // 3. Carichiamo i modelli UNA SOLA volta quando la classe viene creata
    //    Questo è molto più efficiente che caricarli ad ogni tap.
    private let hairDetectionModel: VNCoreMLModel
    private let hairScanModel: VNCoreMLModel
    
    init() {
        do {
            // Assicurati di aver importato le classi dei modelli (es. HairDetection)
            // Sostituisci "HairDetection" e "HairScan" con i nomi
            // delle classi generate da Xcode per i tuoi .mlmodel
            let detectionConfig = MLModelConfiguration()
            hairDetectionModel = try VNCoreMLModel(for: HairDetection(configuration: detectionConfig).model)
            
            let scanConfig = MLModelConfiguration()
            hairScanModel = try VNCoreMLModel(for: HairScan(configuration: scanConfig).model)
            
        } catch {
            // Se i modelli non si caricano, l'app non può funzionare.
            fatalError("Errore critico: impossibile caricare i modelli Core ML: \(error)")
        }
    }
    
    // 4. Questa è la funzione pubblica che la View chiamerà
    func processImage(_ image: UIImage) {
        print("ViewModel: Inizio elaborazione...")
        
        detectHair(image: image) { [weak self] result in
            // [weak self] evita "retain cycles" (problemi di memoria)
            guard let self = self else { return }
            
            // 5. Tutta la logica di "cosa fare dopo" vive qui
            DispatchQueue.main.async {
                if result == "Hair" {
                    print("ViewModel: Capelli rilevati. Avvio scansione...")
                    self.scanHair(image: image) { scanResult in
                        DispatchQueue.main.async {
                            print("ViewModel: Scansione completata: \(scanResult)")
                            self.alertMessage = "Risultato: \(scanResult)"
                            self.showAlert = true
                            // Paritre da qui
                        }
                    }
                } else {
                    print("ViewModel: Capelli non rilevati.")
                    self.alertMessage = "Capelli non rilevati. Per favore, scatta un'altra foto o scegline una dalla galleria."
                    self.showAlert = true
                }
            }
        }
    }
    
    // 6. Le funzioni ML ora sono private, la View non ha bisogno di vederle
    private func detectHair(image: UIImage, completion: @escaping (String) -> Void) {
        // --- QUI VA LA TUA LOGICA CORE ML REALE ---
        // (Usa `hairDetectionModel`, VNCoreMLRequest, VNImageRequestHandler)
        
        // Simulo un ritardo e un risultato
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            completion(Bool.random() ? "Hair" : "NoHair")
        }
    }
    
    private func scanHair(image: UIImage, completion: @escaping (String) -> Void) {
        // --- QUI VA LA TUA LOGICA CORE ML REALE ---
        // (Usa `hairScanModel`, VNCoreMLRequest, VNImageRequestHandler)

        // Simulo un ritardo e un risultato
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.5) {
            let results = ["Healthy", "Damaged", "Extreme damaged"]
            completion(results.randomElement()!)
        }
    }
}
