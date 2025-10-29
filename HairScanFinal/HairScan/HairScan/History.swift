//
//  History.swift
//  HairScan
//
//  Created by Pasquale Pagano on 26/10/25.
//

import SwiftUI

struct History: View {
    
    var body: some View {
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
                        ScrollView{
                            //qui vanno tutte le card
                        }
                        HStack{
                            Button(action: {
                    
                            }){
                                Image(systemName:"arrowshape.turn.up.left.fill")
                                    .font(.system(size: 25))
                                    .foregroundColor(Color.white)
                            }
                        }
                        .padding(12)
                        .background(
                            RoundedRectangle(cornerRadius: 45)
                                .fill(Color.themeText)
                                .shadow(color: Color.gray.opacity(0.2), radius: 8, x: -5, y: -5)
                                .shadow(color: Color.black.opacity(0.3), radius: 8, x: 5, y: 5)
                        )
                        .padding(.bottom, 15)
                        Spacer()
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


#Preview {
    History()
      
}

