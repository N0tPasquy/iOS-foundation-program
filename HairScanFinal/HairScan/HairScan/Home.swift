//
//  Home.swift
//  HairScan
//
//  Created by Pasquale Pagano & Daniele Mele on 22/10/25.
//

import SwiftUI

// MARK: - Colori personalizzati
extension Color {
    static let themeBrown = Color(red: 133/255.0, green: 74/255.0, blue: 20/255.0)
    static let themeText = Color(red: 179/255.0, green: 141/255.0, blue: 105/255.0)
    static let lightBackground = Color(red: 244/255.0, green: 232/255.0, blue: 219/255.0)
}

// MARK: - Home View
struct Home: View {
    @StateObject private var viewModel = WelcomeViewModel()
    @State private var showAdvices = false
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
                    
                    WelcomeView(viewModel: viewModel){
                        withAnimation{ showAdvices = true }
                    }
                    
                    // ----------------------------
                    // INIZIO SECONDO BLOCCO (Last scan + History)
                    
                    
                    LastScanView(viewModel: viewModel)
                    
                    
                }
                if showAdvices {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                        .onTapGesture{
                            withAnimation{
                                showAdvices = false
                            }
                        }
                    CameraAdvices{
                        withAnimation{ showAdvices = false }
                    }
                    .frame(maxWidth: 350)
                    .background(Color.lightBackground)
                    .cornerRadius(40)
                    .shadow(radius: 10)
                    .transition(.scale.combined(with: .opacity))
                    .zIndex(1)
                    .position(x: UIScreen.main.bounds.width / 2,
                              y: UIScreen.main.bounds.height / 2)
                }
            }
        }
    }
}

#Preview {
    Home()
}
