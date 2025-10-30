//
//  Home.swift
//  HairScan
//
//  Created by Daniele Mele & Pasquale Pagano on 22/10/25.
//

import SwiftUI

// MARK: - Colori e font personalizzati
extension Color {
    static let themeBrown = Color(red: 133/255.0, green: 74/255.0, blue: 20/255.0)
    static let themeText = Color(red: 179/255.0, green: 141/255.0, blue: 105/255.0)
    static let lightBackground = Color(red: 244/255.0, green: 232/255.0, blue: 219/255.0)
}

// MARK: - Home View
struct Home: View {
    var body: some View {
        NavigationView {
            // Usa ZStack per posizionare lo sfondo sotto il contenuto
            ZStack(alignment: .top) {
                // Sfondo
                Color.lightBackground.ignoresSafeArea(.all)
                
                VStack(alignment: .center) { // Contenitore verticale principale
                    
                    // ----------------------------------------------------
                    // 1. HEADER
                    HStack {
                        Text("HAIRSCAN")
                            .font(.custom("SerifMedium", size: 22))
                            .bold()
                            .foregroundColor(Color.themeText)
                        
                        Spacer() // Spinge la scritta HairScan a sinistra
                    }
                    .padding(.horizontal, 30)
                    .padding(.top, 15)
                    
                    // ----------------------------------------------------
                    // 2. PRIMO BLOCCO (Welcome + Scan)
                    
                    WelcomeView()
                    
                    // ----------------------------
                    // INIZIO SECONDO BLOCCO (Last scan + History)
                    
                    
                    LastScanView()
                    
                    
                    Spacer() // <-- QUESTO SPACER SPINGE TUTTO IL CONTENUTO SOPRA DI ESSO IN ALTO
                }
            }
        }
    }
}

#Preview {
    Home()
}
