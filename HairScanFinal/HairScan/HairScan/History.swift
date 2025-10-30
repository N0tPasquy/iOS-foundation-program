//
//  History.swift
//  HairScan
//
//  Created by Pasquale Pagano on 26/10/25.
//

import SwiftUI

struct History: View {
    @ObservedObject var viewModel: WelcomeViewModel   // 👈 collegamento con il ViewModel condiviso
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.lightBackground.ignoresSafeArea(.all)
            
            VStack(alignment: .leading) {
                
                // HEADER
                HStack {
                    Text("HAIRSCAN")
                        .font(.custom("SerifMedium", size: 22))
                        .bold()
                        .foregroundColor(Color.themeText)
                    
                    Spacer()
                }
                .padding(.horizontal, 30)
                .padding(.top, 15)
                
                // CONTENUTO PRINCIPALE
                VStack {
                    VStack(alignment: .center) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Analysis history:")
                                .font(.custom("SerifMedium", size: 42))
                                .foregroundColor(Color.themeText)
                        }
                        .padding(.horizontal, 40)
                        .padding(.bottom, 30)
                        .padding(.top, 20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        // 🔹 LISTA DELLA STORIA
                        if viewModel.historyResults.isEmpty {
                            Text("Nessuna analisi ancora effettuata.")
                                .font(.custom("SF pro", size: 18))
                                .foregroundColor(.gray)
                                .padding(.top, 50)
                        } else {
                            List($viewModel.historyResults) { $result in
                                NavigationLink(destination: maskInfo()) { // 🔸 Modifica futura: passa info maschera
                                    HistoryCard(result: $result)
                                }
                                .listRowBackground(Color.clear)
                                .listRowSeparator(.hidden)
                            }
                            .scrollContentBackground(.hidden)
                            .listStyle(.plain)
                            .padding(.horizontal, 10)
                        }
                    }
                    .background(Color.white.opacity(0.81))
                }
                .cornerRadius(40)
                .padding(.top, 10)
                .padding(.horizontal, 10)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    HStack(spacing: 4) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, weight: .medium))
                        Text("Back")
                            .font(.custom("SerifMedium", size: 18))
                    }
                    .foregroundColor(Color.themeText)
                }
            }
        }
    }
}

#Preview {
    let vm = WelcomeViewModel()
    vm.historyResults = [
        AnalysisResult(date: Date(), healthStatus: "Healthy", maskName: "Yogurt & Flaxseed Shine Mask"),
        AnalysisResult(date: Date(), healthStatus: "Damaged", maskName: "Banana & Honey Moisture Mask"),
        AnalysisResult(date: Date(), healthStatus: "Very damaged", maskName: "Coconut & Aloe Rescue Mask")
    ]
    return History(viewModel: vm)
}

