//
//  WelcomeView.swift
//  HairScan
//
//  Created by Pasquale Pagano on 29/10/25.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack{ // Contenitore per la card Welcome
            VStack(alignment: .center){
                 
                //VStack della scritta di benvenuto
                VStack(alignment: .leading, spacing: 5) {
                    Text("Welcome,")
                        .font(.custom("SerifMedium", size: 42))
                        .foregroundColor(Color.themeText)
                     
                    Text("Take care of your hair health, take a scan")
                        .font(.custom("SerifMedium", size: 19))
                        .foregroundColor(.themeText)
                }
                // Padding orizzontale solo per i testi di benvenuto
                .padding(.horizontal, 40)
                .padding(.bottom, 30)
                .padding(.top, 20)
                .frame(maxWidth: .infinity, alignment: .leading) // Assicura che i testi siano allineati a sinistra all'interno della card
                
                // Bottone con effetto Neumorphism (bolla)
                VStack{
                    Button(action: {}){
                        Image(systemName:"camera.shutter.button.fill")
                            .font(.system(size: 60))
                            .foregroundColor(Color.themeText)
                    }
                }
                .padding(30)
                .background(
                    RoundedRectangle(cornerRadius: 45)
                        .fill(Color.white)
                        .shadow(color: Color.gray.opacity(0.2), radius: 8, x: -5, y: -5)
                        .shadow(color: Color.black.opacity(0.3), radius: 8, x: 5, y: 5)
                )
                 
                Text("Add photo from camera or gallery")
                    .font(.custom("SF pro", size: 14))
                    .foregroundColor(Color.themeText.opacity(0.90))
                    .padding(.bottom, 30)
                    .padding(.top, 10)
            }
            .background(Color.white.opacity(0.81))
        }
        .cornerRadius(40)
        .padding(.top, 10) // Aggiunge spazio tra l'header e la card
        .padding(.horizontal, 10)

    }
}

#Preview {
    WelcomeView()
}
