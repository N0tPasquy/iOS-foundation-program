//
//  HistoryStore.swift
//  HairScan
//
//  Created by Pasquale Pagano on 30/10/25.
//
/*
import Foundation
import SwiftUI

// Questo gestore manterrà l'elenco di tutte le scansioni
class HistoryStore: ObservableObject {
    
    // @Published dice a SwiftUI: "Se questo array cambia, aggiorna la UI"
    @Published var historyItems: [ScanHistoryItem] = []
    
    // Questa è la funzione CHIAVE che chiami dopo lo scatto
    func addScanToHistory(image: UIImage, result: String) {
        
        // 1. Crea un nuovo oggetto cronologia
        let newItem = ScanHistoryItem(
            id: UUID(),
            date: Date(),
            scannedImage: image,
            scanResult: result
        )
        
        // 2. Aggiungilo all'array
        // Usiamo .insert(at: 0) per mostrare la più recente in cima
        historyItems.insert(newItem, at: 0)
        
        // 3. (Opzionale) Qui potresti salvare l'array su disco
        // saveData()
    }
    
    // Esempio di come potresti caricare/salvare (più avanzato)
    // func saveData() { ... }
    // func loadData() { ... }
}
*/
