//
//  TabBar.swift
//  HairScan
//
//  Created by Pasquale Pagano on 23/10/25.
//

import SwiftUI

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

struct TabBar: View {
    var body: some View {
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
                            .fontWeight(.bold)
                    }
                    .foregroundColor(.themeBrown)
                }
                
                // CAMERA
                NavigationLink(destination: CameraView()) {
                    VStack {
                        Image(systemName: "camera.fill")
                            .resizable()
                            .frame(width: 40, height: 32)
                        Text("Camera")
                            .font(.caption2)
                            .fontWeight(.bold)
                    }
                    .foregroundColor(.themeBrown)
                }
                
                // HISTORY
                NavigationLink(destination: HistoryView()) {
                    VStack {
                        Image(systemName: "list.bullet")
                            .resizable()
                            .frame(width: 25, height: 20)
                        Text("History")
                            .font(.caption2)
                            .fontWeight(.bold)
                    }
                    .foregroundColor(.themeBrown)
                }
            }
            .padding(.horizontal, 30)
            .padding(.vertical, 10)
            .background(Color.lightBackground)
            .opacity(80)
            .cornerRadius(30)
            .shadow(radius: 10)
            .padding(.horizontal, 20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
    }
}

#Preview {
    TabBar()
}
