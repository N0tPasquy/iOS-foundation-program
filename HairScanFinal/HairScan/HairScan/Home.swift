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

// MARK: - TipCard (Consiglio fotografico)
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
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(Color.themePurple)
                        
                        Spacer()
                        
                        Button(action: {
                            print("⚙️ Impostazioni aperte")
                        }) {
                            Image(systemName: "gearshape.fill")
                                .font(.title2)
                                .foregroundColor(Color.themePurple)
                        }
                    }
                    .padding(.horizontal, 25)
                    .padding(.top, 20)
                    
                    // ----------------------------------------------------
                    // 2. BLOCCO PRINCIPALE (Welcome + Last Scan)
                    VStack(alignment: .leading, spacing: 20) {
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Welcome,")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(Color.black.opacity(0.85))
                            
                            Text("Take care of your hair health,\nperform a scan")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        
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
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.themePurple.opacity(0.8))
                        )
                    }
                    .padding(.horizontal, 25)
                    .padding(.vertical, 25)
                    .background(
                        RoundedRectangle(cornerRadius: 30)
                            .fill(Color.cardBackground)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 3)
                    )
                    .padding(.horizontal, 20)
                    
                    // ----------------------------------------------------
                    // 3. CONSIGLI (Tips)
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
                    
                    Spacer()
                }
                .padding(.top, 20)
                
                // ----------------------------------------------------
                // 4. TAB BAR INFERIORE
                VStack {
                    HStack(spacing: 40) {
                        
                        // DASHBOARD
                        NavigationLink(destination: DashboardView()) {
                            VStack {
                                Image("logo_dashboard")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .cornerRadius(70)
                                Text("Dashboard")
                                    .font(.caption2)
                            }
                            .foregroundColor(.themePurple)
                        }
                        
                        // CAMERA
                        NavigationLink(destination: CameraView()) {
                            VStack {
                                Image(systemName: "camera.fill")
                                    .resizable()
                                    .frame(width: 40, height: 32)
                                Text("Camera")
                                    .font(.caption2)
                            }
                            .foregroundColor(.themePurple)
                        }
                        
                        // HISTORY
                        NavigationLink(destination: HistoryView()) {
                            VStack {
                                Image(systemName: "list.bullet")
                                    .resizable()
                                    .frame(width: 25, height: 20)
                                Text("History")
                                    .font(.caption2)
                            }
                            .foregroundColor(.themePurple)
                        }
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
}

// MARK: - Schermate di destinazione (placeholder)
struct DashboardView: View {
    var body: some View {
        VStack {
            Text("📊 Dashboard")
                .font(.largeTitle)
                .fontWeight(.bold)
            Text("Qui verranno mostrate le statistiche e i risultati delle analisi.")
                .foregroundColor(.gray)
                .padding()
        }
    }
}

struct CameraView: View {
    var body: some View {
        VStack {
            Text("📷 Camera")
                .font(.largeTitle)
                .fontWeight(.bold)
            Text("Qui potrai scattare e analizzare le foto dei capelli.")
                .foregroundColor(.gray)
                .padding()
        }
    }
}

struct HistoryView: View {
    var body: some View {
        VStack {
            Text("🕘 History")
                .font(.largeTitle)
                .fontWeight(.bold)
            Text("Qui troverai lo storico delle scansioni effettuate.")
                .foregroundColor(.gray)
                .padding()
        }
    }
}

#Preview {
    Home()
}

