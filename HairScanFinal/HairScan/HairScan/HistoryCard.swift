//
//  HistoryCard.swift
//  HairScan
//
//  Created by Daniele Mele on 29/10/25.
//

import SwiftUI

//Aggiunta struct
struct AnalysisResult: Identifiable, Codable {
    let id = UUID()
    let date: Date
    let healthStatus: String // Es: "Healty", "Damaged"
    let maskName: String     // Es: "Mask name"
}

struct HistoryCard: View {
    @Binding var result: AnalysisResult
    let onDelete: () -> Void
    var body: some View {
        HStack(spacing: 20) {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white.opacity(0.8))
                .frame(width: 80, height: 80)
                .overlay(
                    Text("Photo")
                        .font(.custom("SerifMedium", size: 18))
                        .foregroundColor(Color.themeText)
                )
            
            VStack(alignment: .leading, spacing: 5) {
                Text(result.healthStatus)
                    .font(.custom("SerifMedium", size: 22))
                    .foregroundColor(Color.themeText)
                
                Text(result.maskName)
                    .font(.custom("SerifMedium", size: 18))
                    .foregroundColor(Color.themeText)
            }
            
            Spacer()
            
            Button(action: {
                //print("Elimina elemento: \(result.maskName)")
                onDelete()
            }) {
                Image(systemName: "trash.fill")
                    .font(.title2)
                    .foregroundColor(.themeBrown)
            }
            .buttonStyle(.plain)
        }
        .padding(15)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.lightBackground)
        )
    }
}

// Preview della singola Card
/*#Preview {
    HistoryCard(result: .constant(
        AnalysisResult(
            date: Date(),
            healthStatus: "Healthy",
            maskName: "Yogurt & Flaxseed Shine Mask"
        )
    ))
}
*/
