//
//  ProductCard.swift
//  HairScan
//
//  Created by Pasquale Pagano on 25/10/25.
//

import SwiftUI

struct ProductCard: View {
    
    // 1. Questa variabile 'mask' viene INIETTATA dalla History View
    let mask: MaskList
    
    var body: some View {
        ZStack {
            Color.lightBackground.ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    Text(mask.maskName)
                        .font(.custom("SerifMedium", size: 36))
                        .foregroundColor(Color.themeText)
                    
                    InfoRow(title: "Hair Condition", value: mask.hairCondition)
                    InfoRow(title: "Key Benefits", value: mask.benefit)
                    InfoRow(title: "Ingredients", value: mask.ingredients)
                    InfoRow(title: "Application Time", value: mask.applicationTime)
                    InfoRow(title: "Frequency", value: mask.frequency)
                    InfoRow(title: "Usage Notes", value: mask.usageNote)
                    
                    Spacer()
                }
                .padding(30)
            }
        }
        .navigationTitle("Mask Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// Una piccola vista di supporto per mostrare le righe
struct InfoRow: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.custom("SerifMedium", size: 18))
                .foregroundColor(Color.themeBrown) // Esempio di colore
            Text(value)
                .font(.custom("SerifMedium", size: 16))
                .foregroundColor(Color.themeText)
        }
    }
}

// #Preview {
//    // Puoi creare una maschera di esempio per l'anteprima
//    let previewMask = MaskList(hairCondition: "Damaged hair", maskName: "Banana & Honey Moisture Mask", ingredients: "1 banana, 1 tbsp honey", benefit: "Restores moisture", applicationTime: "25-30 min", frequency: "1x per week", usageNote: "Blend well")
//    return ProductCard(mask: previewMask)
// }
