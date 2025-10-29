//
//  Home.swift
//  HairScan
//
//  Created by Daniele Mele on 22/10/25.
//

import SwiftUI

// MARK: - Colori e font personalizzati
extension Color {
    static let themeBrown = Color(red: 133/255.0, green: 74/255.0, blue: 20/255.0)
    static let themeText = Color(red: 179/255.0, green: 141/255.0, blue: 105/255.0)
    static let lightBackground = Color(red: 244/255.0, green: 232/255.0, blue: 219/255.0)
    static let cardBackground = Color(red: 252/255.0, green: 246/255.0, blue: 241/255.0)
}

// MARK: - Home View
struct Home: View {
    var body: some View {
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
                // Usiamo uno Spacer in cima a questo blocco per spingerlo leggermente in giù
                // e separarlo dall'header, se necessario.
                // Basandomi sull'immagine, non serve, quindi lo lasciamo partire in alto
                 
                VStack{ // Contenitore per la card Welcome
                    VStack(alignment: .center){
                         
                        //VStack della scritta di benvenuto
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Welcome,")
                                .font(.custom("SerifMedium", size: 42))
                                .foregroundColor(Color.themeText)
                             
                            Text("Take care of your hair health, take a scan")
                                .font(.custom("SerifMedium", size: 19))
                                .foregroundColor(.themeText)
                        }
                        // Padding orizzontale solo per i testi di benvenuto
                        .padding(.horizontal, 40)
                        .padding(.bottom, 30)
                        .padding(.top, 20)
                        .frame(maxWidth: .infinity, alignment: .leading) // Assicura che i testi siano allineati a sinistra all'interno della card
                        
                        // Bottone con effetto Neumorphism (bolla)
                        VStack{
                            Button(action: {}){
                                Image(systemName:"camera.shutter.button.fill")
                                    .font(.system(size: 60))
                                    .foregroundColor(Color.themeText)
                            }
                        }
                        .padding(30)
                        .background(
                            RoundedRectangle(cornerRadius: 45)
                                .fill(Color.white)
                                .shadow(color: Color.gray.opacity(0.2), radius: 8, x: -5, y: -5)
                                .shadow(color: Color.black.opacity(0.3), radius: 8, x: 5, y: 5)
                        )
                         
                        Text("Add photo from camera or gallery")
                            .font(.custom("SF pro", size: 14))
                            .foregroundColor(Color.themeText.opacity(0.90))
                            .padding(.bottom, 30)
                            .padding(.top, 10)
                    }
                    // Rimuoviamo il padding orizzontale da questo VStack, in quanto gestiamo il padding internamente sopra
                    .background(Color.white.opacity(0.81))
                }
                .cornerRadius(40)
                .padding(.top, 10) // Aggiunge spazio tra l'header e la card
                .padding(.horizontal, 10)
                
                // ----------------------------
                // INIZIO SECONDO CONTENITORE
                
                VStack{
                    VStack(alignment: .leading, spacing: 5){
                        HStack{
                            Text("Last scan :")
                                .font(.custom("SerifMedium", size: 35))
                                .foregroundColor(Color.themeText)
                            
                            Spacer()
                            
                            Button(action: {}){
                                Text("+ Show all")
                                    .font(.custom("SF pro", size: 16))
                                    .foregroundColor(Color.themeText.opacity(80))
                            }
                        }
                        .padding(.horizontal, 40)
                        .padding(.top, 30)
                        
                        VStack{
                            Text("HEALTHY")
                                .font(.custom("SerifMedium", size: 20))
                                .foregroundColor(Color.themeBrown)
                                .bold()
                        }
                        .padding(.horizontal, 40)
                        .padding(.top, 10)
                        
                        //Here
                        VStack{
                            Text("Suggestion")
                                .font(.custom("SerifMedium", size: 24))
                                .foregroundColor(Color.themeText)
                        }
                        .padding(.horizontal, 40)
                        .padding(.top, 30)
                        
                        VStack{
                            Text("Quì andranno i suggerimenti ")
                                .font(.custom("SerifMedium", size: 20))
                                .foregroundColor(Color.themeBrown)
                                .bold()
                        }
                        .padding(.horizontal, 40)
                        .padding(.top, 10)
                        
                        Spacer()
                    }
                    .background(Color.white.opacity(0.81))
                }
                .cornerRadius(40)
                .padding(.top, 30) // Aggiunge spazio tra l'header e la card
                .padding(.horizontal, 10)
                

                Spacer() // <-- QUESTO SPACER SPINGE TUTTO IL CONTENUTO SOPRA DI ESSO IN ALTO
            }
        }
    }
}

#Preview {
    Home()
}
