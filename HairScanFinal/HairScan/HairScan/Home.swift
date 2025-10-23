//
//  Home.swift
//  HairScan
//
//  Created by Daniele Mele on 22/10/25.
//

import SwiftUI

// MARK: - Colori Personalizzati
extension Color {
    static let themePurple = Color(red: 0.65, green: 0.6, blue: 0.75)
    static let lightBackground = Color(red: 0.95, green: 0.9, blue: 0.98)
    static let cardBackground = Color.white
}

// MARK: - Componente Card Suggerimento (TipCard)
struct TipCard: View {
    let icon: String
    let title: String
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.themePurple)
            
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(Color.black.opacity(0.8))
            
            Spacer()
        }
        .padding(.vertical, 10)
    }
}

// MARK: - Home View STATICA con Spaziatura Aggiornata
struct Home: View {
    
    var body: some View {
        
        ZStack(alignment: .top) {
            
            // Sfondo principale uniforme
            Color.lightBackground.ignoresSafeArea(.all)
            
            // VStack principale che gestisce tutta la distribuzione dello spazio verticale
            // AZIONE CHIAVE: Spacing aumentato tra i blocchi (15 punti)
            VStack(spacing: 30) {
                
                // ----------------------------------------------------
                // 1. BLOCCO SUPERIORE (Header)
                VStack(spacing: 0) {
                    HStack {
                        Text("HAIRSCAN")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(Color.themePurple)
                        
                        Spacer()
                        
                        Button(action: {/* CODICE AZIONE BOTTNE QUI DENTRO */}) {
                            Image(systemName: "gearshape.fill")
                                .font(.title2)
                                .foregroundColor(Color.themePurple)
                        }
                    }
                    .padding(.horizontal, 25)
                    .padding(.top, 0)
                    .padding(.bottom, 0)
                }
                .frame(maxWidth: .infinity, alignment: .top)
                .ignoresSafeArea(.all, edges: .top)
                
                // ----------------------------------------------------
                // 2. BLOCCO CENTRALE (Welcome + Last Scan)
                VStack(alignment: .leading, spacing: 20) {
                    
                    // Area Welcome
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Welcome,")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(Color.black.opacity(0.85))
                        
                        Text("Take care of your hair health,\nperform a scan")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .lineLimit(2)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    
                    // Riquadro "LAST SCAN"
                    VStack {
                        Text("LAST SCAN :")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.horizontal, 15)
                            .padding(.vertical, 5)
                            .background(Capsule().fill(Color.themePurple).opacity(0.8))
                        
                        Spacer()
                        
                        VStack(spacing: 10) {
                            Image(systemName: "camera")
                                .font(.system(size: 60))
                                .foregroundColor(.white)
                            
                            Text("No scan found")
                                .font(.title3)
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                        }
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 220)
                    .background(RoundedRectangle(cornerRadius: 20).fill(Color.themePurple.opacity(0.8)))
                }
                .padding(.horizontal, 25)
                .padding(.vertical, 25)
                .frame(maxHeight: 350)
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color.cardBackground)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 3)
                )
                .padding(.horizontal, 20)
    
                // Ho rimosso il padding(.bottom) qui perché il Vstack spacing gestisce la separazione
                
                // ----------------------------------------------------
                // 3. BLOCCO INFERIORE (Consigli)
                VStack(alignment: .leading, spacing: 10) {
                    TipCard(icon: "magnifyingglass.circle.fill", title: "Capture the full hairstyle")
                    Divider()
                    TipCard(icon: "photo.on.rectangle", title: "Use a simple background")
                    Divider()
                    TipCard(icon: "lightbulb.fill", title: "Take the photo in natural light")
                }
                .padding(.horizontal, 25)
                .padding(.vertical, 15)
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color.cardBackground)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 3)
                )
                .padding(.horizontal, 20)
                
                // Spacer per creare spazio tra Blocco 3 e la Tab Bar
                Spacer()
            }
            // Padding superiore mantenuto per la posizione
            .padding(.top, 20)
            
            // TAB BAR INFERIORE (Replicazione - Sovrapposta)
            VStack {
                HStack(spacing: 40) {
                    VStack { Image(systemName: "rectangle.3.group"); Text("Dashboard").font(.caption2) }.foregroundColor(Color.themePurple)
                    Button(action: {}) { Image(systemName: "camera.fill").font(.system(size: 30)).padding(15).background(Circle().fill(Color.themePurple)).foregroundColor(.white).shadow(radius: 5) }
                        .offset(y: -15)
                    VStack { Image(systemName: "list.bullet"); Text("History").font(.caption2) }.foregroundColor(.gray)
                }
                .padding(.horizontal, 30)
                .padding(.vertical, 10)
                .background(Color.white)
                .cornerRadius(30)
                .shadow(radius: 10)
                .padding(.horizontal, 20)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        }
    }
}

#Preview {
    Home()
}
