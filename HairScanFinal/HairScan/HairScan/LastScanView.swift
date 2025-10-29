//
//  VStack.swift
//  HairScan
//
//  Created by Pasquale Pagano on 29/10/25.
//


import SwiftUI

struct LastScanView: View {
    
    var body: some View {
        
            VStack{
                VStack(alignment: .leading, spacing: 5){
                    HStack{
                        Text("Last scan:")
                            .font(.custom("SerifMedium", size: 35))
                            .foregroundColor(Color.themeText)
                        
                        Spacer()
                        NavigationLink(destination: History()){
                            Text("Show all")
                                .fontWeight(.heavy)
                                .font(.custom("SF pro", size: 16))
                                .foregroundColor(Color.themeBrown)
                                .underline()
                        }
                        
                    }
                    .padding(.horizontal, 40)
                    .padding(.top, 30)
                    
                    VStack{
                        Text("HEALTHY")
                            .font(.custom("SF pro", size: 20))
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
                            .font(.custom("SF pro", size: 20))
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
        }
    
}

#Preview {
    LastScanView()
}
