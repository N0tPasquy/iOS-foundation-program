//
//  ContentView.swift
//  Main
//
//  Created by Pasquale Pagano on 17/10/25.
//

import SwiftUI

struct ContentView: View {
    // 1. Variabile di Stato:
    // Questa variabile booleana controlla se l'immagine deve essere mostrata.
    // L'attributo @State rende la vista reattiva ai cambiamenti di questa variabile.
    @State private var mostraImmagine: Bool = false
    
    var body: some View {
        VStack(spacing: 50) { // Aggiunto spacing per separare gli elementi
            
            // 2. Il Cuore Cliccabile (Button):
            Button {
                // Azione del pulsante: inverte lo stato di 'mostraImmagine'
                mostraImmagine.toggle()
            } label: {
                Image(systemName: "heart.fill") // Icona del cuore pieno da SF Symbols
                    .resizable() // Permette di ridimensionare
                    .frame(width: 100, height: 100) // Imposta le dimensioni
                    .foregroundStyle(.blue) // Imposta il colore a blu
            }
            
            // 3. Logica Condizionale:
            // Mostra l'immagine solo se 'mostraImmagine' è true
            if mostraImmagine {
                // Sostituisci "nome_della_tua_immagine" con il nome dell'asset
                // che aggiungerai al tuo progetto (es. "capelli-scansionati")
                Image("totti")
                    .resizable()
                    .aspectRatio(contentMode: .fit) // Mantiene le proporzioni
                    .frame(width: 200, height: 200) // Dimensioni dell'immagine visualizzata
                    .border(.gray) // Aggiunto un bordo per evidenziare (opzionale)
            } else {
                Text("Clicca sul cuore!") // Messaggio quando l'immagine è nascosta
                    .foregroundColor(.gray)
            }
            
            // Puoi rimuovere o lasciare l'originale "Hello, world!"
            // Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
// TEST
