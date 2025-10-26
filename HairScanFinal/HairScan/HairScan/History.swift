//
//  History.swift
//  HairScan
//
//  Created by Pasquale Pagano on 26/10/25.
//

import SwiftUI

// Rinomina la struct per chiarezza (non chiamarla History se non è la schermata principale)
struct History: View {
    
    var body: some View {
        // La tua VISTA INIZIALE MARRONE che appare dal basso
        VStack {
            // Se vuoi che il titolo "History" appaia solo quando è basso:
            Text("History")
                .font(.title)
                .foregroundColor(.lightBackground)
                .padding(.top, 20)
            
            // ------------------------------------
            // Qui va inserita la list scrolalbile delle scansioni precedenti
            
            Spacer() // Spinge il testo in alto
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) // Si espande per la sheet
        // Puoi usare un colore di fallback qui, ma il colore della maniglia sarà gestito dalla Home
        .background(Color.themeBrown.opacity(0.61))
    }
}

// Rimuovi la Preview se la userai solo nella Home, altrimenti usa:

#Preview {
    History()
        .frame(height: 200) // Simula l'altezza iniziale
}

