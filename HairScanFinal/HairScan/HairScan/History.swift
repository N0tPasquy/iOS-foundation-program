//
//  History.swift
//  HairScan
//
//  Created by Pasquale Pagano on 26/10/25.
//

import SwiftUI

struct History: View {
    var HistoryArray = [AnalysisResult(healthStatus: "Healty", maskName: "Mask name"),
                        AnalysisResult(healthStatus: "Damaged", maskName: "Mask name"),
                        AnalysisResult(healthStatus: "Damaged", maskName: "Mask name"),
                        AnalysisResult(healthStatus: "Very damaged", maskName: "Mask name"),
                        AnalysisResult(healthStatus: "Very damaged", maskName: "Mask name")]
    
    var body: some View {
        @State var result = AnalysisResult(healthStatus: "Healty", maskName: "Mask name")
      
        NavigationView {
            ZStack{
                Color.lightBackground.ignoresSafeArea(.all)
                VStack(alignment: .leading){
                    HStack {
                        Text("HAIRSCAN")
                            .font(.custom("SerifMedium", size: 22))
                            .bold()
                            .foregroundColor(Color.themeText)
                        
                        Spacer() // Spinge la scritta HairScan a sinistra
                    }
                    .padding(.horizontal, 30)
                    .padding(.top, 15)
                    
                    VStack{
                        VStack(alignment: .center){
                            VStack(alignment: .leading, spacing: 5){
                                Text("Analysis history: ")
                                    .font(.custom("SerifMedium", size: 42))
                                    .foregroundColor(Color.themeText)
                            }
                            .padding(.horizontal, 40)
                            .padding(.bottom, 30)
                            .padding(.top, 20)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            List(HistoryArray) { result in
                                NavigationLink(destination: ProductCard()){ // Modificare ProductCard in modo che contenga le informazioni della maschera. Tutto in modo dinamico
                                    HistoryCard(result: $result)
                                }
                                .listRowBackground(Color.clear) // Rende lo sfondo della RIGA trasparente
                                .listRowSeparator(.hidden) // Nasconde le linee separatore
                           }
                            .scrollContentBackground(.hidden) // Rende lo sfondo della LISTA trasparente
                            .listStyle(.plain) // Assicura lo stile più semplice
                            .padding(.horizontal, 20)
                        }
                        .background(Color.white.opacity(0.81))
                    }
                    .cornerRadius(40)
                    .padding(.top, 10) // Aggiunge spazio tra l'header e la card
                    .padding(.horizontal, 10)
                }
            }
        }
    }
}


#Preview {
    History()
      
}

