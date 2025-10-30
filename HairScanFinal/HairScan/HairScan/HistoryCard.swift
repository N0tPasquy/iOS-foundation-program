//
//  HistoryCard.swift
//  HairScan
//
//  Created by Daniele Mele on 29/10/25.
//

import SwiftUI

//Aggiunta struct
struct AnalysisResult: Identifiable {
    let id = UUID()
    let healthStatus: String // Es: "Healty", "Damaged"
    let maskName: String     // Es: "Mask name"
}

struct HistoryCard: View { // NOME CORRETTO: HistoryCard
    @Binding var result: AnalysisResult // Richiede un dato da mostrare
    
    var body: some View {
        
        // 1. Avvolgiamo tutto il design in un Button
        Button(action: {
            // AZIONE DA ESEGUIRE AL CLICK DELLA CARD (es. Mostra Dettagli)
            print("Card History cliccata per: \(result.healthStatus)")
        }) {
            // 2. Contenuto visivo della Card
            HStack(spacing: 20) {
                
                // Blocco FOTO
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.white.opacity(0.8))
                    .frame(width: 80, height: 80)
                    .overlay(
                        // Invece che Text() va inserita l'immagine salvata localmente
                        Text("Photo")
                            .font(.custom("SerifMedium", size: 18))
                            .foregroundColor(Color.themeText)
                    )
                
                // Blocco TESTI
                VStack(alignment: .leading, spacing: 5) {
                    Text("\(result.healthStatus)")
                        .font(.custom("SerifMedium", size: 22))
                        .foregroundColor(Color.themeText)
                    
                    Text("\(result.maskName)")
                        .font(.custom("SerifMedium", size: 18))
                        .foregroundColor(Color.themeText)
                }
                
                Spacer() // Spinge il cestino all'estrema destra
                
                // Icona CESTINO (deve essere un Button separato se ha un'azione diversa)
                Button(action: {
                    // AZIONE DI ELIMINAZIONE
                    print("Elimina elemento: \(result.healthStatus)")
                }) {
                    Image(systemName: "trash.fill")
                        .font(.title2)
                        .foregroundColor(.themeBrown)
                }
                // Molto importante: usa .plain per il cestino, altrimenti l'azione del cestino
                // verrebbe annullata dal Button genitore.
                .buttonStyle(.plain)
            }
            .padding(15)
            .background(
                // 3. Il background scuro della card
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.lightBackground)
            )
        }
        // 4. Modificatore cruciale per la Card: annulla lo stile predefinito del Button
        .buttonStyle(.plain)
    }
}

// Preview della singola Card
#Preview {
    HistoryCard(result: .constant(AnalysisResult(healthStatus: "Healty", maskName: "Mask name")))
        .padding()
}
