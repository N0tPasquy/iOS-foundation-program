//
//  LastScanView.swift
//  HairScan
//
//  Created by Pasquale Pagano & Daniele Mele on 29/10/25.
//
// MARK: - File che implementa la parte inferiore della homepage

import SwiftUI

struct LastScanView: View {
    @ObservedObject var viewModel: WelcomeViewModel   // collegamento con il ViewModel
    
    private func formatted(date: Date) -> String {
        // You can adjust style/locale as needed
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 5) {
                
                // Header
                HStack {
                    Text("Last scan:")
                        .font(.custom("SerifMedium", size: 35))
                        .foregroundColor(Color.themeText)
                    
                    Spacer()
                    NavigationLink(destination: History(viewModel: viewModel)){
                        Text("Show all")
                            .fontWeight(.heavy)
                            .font(.custom("SF pro", size: 16))
                            .foregroundColor(Color.themeBrown)
                            .underline()
                    }
                }
                .padding(.horizontal, 40)
                .padding(.top, 30)
                
                // Risultato della scansione
                VStack {
                    Text(viewModel.risultatoFinale.isEmpty ? "No scan performed" : viewModel.risultatoFinale.uppercased())
                        .font(.custom("SF pro", size: 20))
                        .foregroundColor(Color.themeBrown)
                        .bold()
                }
                .padding(.horizontal, 40)
                .padding(.top, 10)
                
                Spacer()    // Spacer che lascia più spazio tra last scan e suggestion
                
                // Titolo sezione suggerimento
                VStack {
                    Text("Suggestion")
                        .font(.custom("SerifMedium", size: 24))
                        .foregroundColor(Color.themeText)
                }
                .padding(.horizontal, 40)
                .padding(.top, 30)
                
                // Dettagli della maschera consigliata
                if let mask = viewModel.selectedMask {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(mask.maskName)
                            .font(.custom("SF pro", size: 20))
                            .foregroundColor(Color.themeBrown)
                            .bold()
                    }
                    .padding(.horizontal, 40)
                    .padding(.top, 10)
                } else {
                    VStack {
                        Text("No suggestions available")
                            .font(.custom("SF pro", size: 18))
                            .foregroundColor(Color.themeBrown)
                            .bold()
                    }
                    .padding(.horizontal, 40)
                    .padding(.top, 10)
                }
                
                Spacer()    // Spacer che sposta la data dell'ultima scansione in basso al blocco
                
                // Data dell'ultima analisi (presa dalla history, non dalla maschera)
                if let lastDate = viewModel.historyResults.first?.date {
                    HStack() {
                        Spacer() // Spinge la data sul lato destro
                        Text(formatted(date: lastDate))
                            .font(.custom("SerifMedium", size: 14))
                            .foregroundColor(Color.themeText)
                    }
                    .padding(.horizontal, 40)
                    .padding(.top, 10)
                } else {
                    HStack {
                        Spacer() // Spinge la data sul lato destro
                        Text("No date available")
                            .font(.custom("SerifMedium", size: 14))
                            .foregroundColor(Color.themeText)
                    }
                    .padding(.horizontal, 40)
                    .padding(.top, 10)
                }
                
                Spacer()
            }
            .background(Color.white.opacity(0.81))
        }
        .cornerRadius(40)
        .padding(.top, 30)
        .padding(.horizontal, 10)
    }
}

#Preview {
    // Preview con un ViewModel fittizio
    let vm = WelcomeViewModel()
    vm.risultatoFinale = "Healthy"
    vm.selectedMask = healthyHairMasks.first
    return LastScanView(viewModel: vm)
}
