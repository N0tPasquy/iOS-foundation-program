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

/* MARK: - TipCard (Consiglio fotografico)
struct TipCard: View {
    let icon: String
    let title: String
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.themeBrown)
            
            Text(title)
                .font(.custom("SerifMedium", size: 20))
                .fontWeight(.medium)
                .foregroundColor(Color.themeBrown)
            
            Spacer()
        }
        .padding(.vertical, 10)
    }
} */

// MARK: - Home View
struct Home: View {
    @State private var selectedTab: String = "Dashboard"
    
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
                            .fontWeight(.bold)
                            .foregroundColor(Color.themeText)
                        
                        Spacer()
                        
                        Button(action: {
                            print("⚙️ Impostazioni aperte")
                        }) {
                            Image(systemName: "gearshape.fill")
                                .font(.title2)
                                .foregroundColor(Color.themeBrown)
                        }
                    }
                    .padding(.horizontal, 25)
                    .padding(.top, 20)
                    
                    // ----------------------------------------------------
                    // 2. BLOCCO PRINCIPALE (Welcome + Last Scan)
                    VStack(alignment: .leading, spacing: 20) {
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Welcome,")
                                .font(.custom("SerifMedium", size: 42))
                                .foregroundColor(Color.themeText)
                            
                            Text("Take care of your hair health,\nperform a scan")
                                .font(.custom("SerifMedium", size: 20))
                                .foregroundColor(.themeText)
                        }
                        
                        VStack {
                            Text("LAST SCAN")
                                .font(.custom("SerifMedium", size: 22))
                                .foregroundColor(.white)
                                .padding(.horizontal, 15)
                                .padding(.vertical, 5)
                                .background(Capsule().fill(Color.lightBackground).opacity(0.57))
                            
                            Spacer()
                            
                            VStack(spacing: 10) {
                                /*Image(systemName: "camera.shutter.button")
                                    .font(.system(size: 60))
                                    .foregroundColor(.themeBrown)*/
                                
                                Text("No scan found")
                                    .font(.custom("SerifMedium", size: 22))
                                    .foregroundColor(.lightBackground)
                            }
                            Spacer()
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 150)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.themeBrown.opacity(0.61))
                        )
                        
                        
                        // ----------------------------------------------------
                        // 3. PULSANTE "TAKE A PICTURE"
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
                            
                            //Spacer alla fine, spinge il pulsante a sinistra "bilanciandolo" al centro
                            Spacer()
                        }
                        
                        
                        // ----------------------------------------------------
                        // 4. SEZIONE "PRODOTTI RACCOMANDATI"
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
                        
                        // ----------------------------------------------------
                        // 5. PANNELLO "HISTORY" CHE SI ALZA
                        
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
    }
}

#Preview {
    Home()
}

