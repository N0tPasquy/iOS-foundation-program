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
    @State private var isHistorySheetPresented: Bool = true
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                
                // Sfondo
                Color.lightBackground.ignoresSafeArea(.all)
                
                VStack(spacing: 30) {
                    
                    // ----------------------------------------------------
                    // 1. HEADER
                    HStack {
                        Text("HAIRSCAN")
                            .font(.custom("SerifMedium", size: 32))
                            .bold()
                            .foregroundColor(Color.themeText)
                        
                        Spacer()
                        
                        Button(action: {
                            print("Prova pulsante impostazioni")
                        }) {
                            Image(systemName: "gearshape.fill")
                                .foregroundColor(Color.themeBrown)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 25)
                    
                    // ----------------------------------------------------
                    // 2. PRIMO BLOCCO (Welcome + Last Scan
                    
                    // VStack principale che contiene gli altri VStack
                    VStack(alignment: .leading, spacing: 20) {
                        
                        //VStack della scritta di benvenuto
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Welcome,")
                                .font(.custom("SerifMedium", size: 42))
                                .foregroundColor(Color.themeText)
                            
                            Text("Take care of your hair health,\ntake a scan")
                                .font(.custom("SerifMedium", size: 20))
                                .foregroundColor(.themeText)
                        }
                        
                        //VStack usato per creare il blocco chiaro "Last scan"
                        VStack {
                            Text("LAST SCAN")
                                .font(.custom("SerifMedium", size: 22))
                                .foregroundColor(.white)
                                .padding(.horizontal, 13)
                                .padding(.vertical, 5)
                                .background(Capsule().fill(Color.lightBackground).opacity(0.57)) //Capsule() serve per rendere il blocco arrotondato. I padding per le dimensioni
                            
                            //Spacer che spinge in alto il blocco chiaro
                            Spacer()
                            
                            VStack(spacing: 10) {
                                Text("No scan found")
                                    .font(.custom("SerifMedium", size: 22))
                                    .foregroundColor(.lightBackground)
                            }
                            //Spacer che spinge il testo al centro del blocco
                            Spacer()
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 150)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.themeBrown.opacity(0.61))
                            // frame indica la dimensione del blocco rispetto allo schermo
                        )
                        
                        
                        // ----------------------------------------------------
                        // 3. PULSANTE "TAKE A PICTURE"
                        // Utilizzo un HStack per allineare il pulsante al cenrtro dello schermo
                        HStack{
                            //Spacer all'inizio, spinge il pulsante a destra
                            Spacer()
                            
                            Button(action: {}){
                                Text("Take a picture")
                                    .font(.custom("SerifMedium", size: 24))
                                    .foregroundColor(Color.lightBackground)
                            }
                            .frame(maxWidth: 200)
                            .frame(height: 40)
                            .background(
                                Capsule()
                                    .fill(Color.themeText)
                                    .shadow(color: Color.themeBrown, radius: 8, x: 5, y: 5)
                                    .shadow(color: Color.lightBackground, radius: 8, x: -5, y: -5)
                            )
                            // Nel pulsante aggiungo delle ombre per dargli un effetto di profondità
                            
                            //Spacer alla fine, spinge il pulsante a sinistra "bilanciandolo" al centro
                            Spacer()
                        }
                        
                        
                        // ----------------------------------------------------
                        // 4. SEZIONE "PRODOTTI RACCOMANDATI"
                        // All'interno del VStack ci sono due elementi, il primo testo e la lista di prodotti
                        VStack(alignment: .leading){
                            Text("Recommended products")
                                .font(.custom("SerifMedium", size: 24))
                                .foregroundColor(Color.themeText)
                            
                            // Richiamo la lista di prodotti all'interno di un HStack
                            HStack(){
                                ProductCard()
                            }
                            .background(Color.themeText)
                            .cornerRadius(20)
                        }
                    }
                    .padding(.horizontal, 25)
                    .padding(.vertical, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 30)
                            .fill(Color.cardBackground)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 3)
                    )
                    .padding(.horizontal, 20)
                
                    Spacer()
                    
                }
                .padding(.top, 0)
                
            }
        }
        
        // ----------------------------------------------------
        // 5. SLIDER "HISTORY"
        // Aggiunto alla fine di NavigationStack per farlo apparire in basso allo schermo
        .sheet(isPresented: $isHistorySheetPresented){
            History()
                .presentationDetents([.fraction(0.1), .fraction(0.9)])
                // Rende la maniglia visibile
                .presentationDragIndicator(.visible)
                // Evita che lo slider scompaia del tutto quando trascinato in basso
                .interactiveDismissDisabled(true)
                // Evita che lo slider si metta in primo piano e lascia interagire anche con la schermata Home
                .presentationBackgroundInteraction(.enabled)
        }
    }
}

#Preview {
    Home()
}
