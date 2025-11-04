//
//  HistoryCard.swift
//  HairScan
//
//  Created by Pasquale Pagano & Daniele Mele on 29/10/25.
//
// MARK: - File che implementa una singola "card" della Hisotry
// viene richiamato tante volte quante scansioni sono state eseguite

import SwiftUI

//Aggiunta struct
struct AnalysisResult: Identifiable, Codable {
    var id = UUID()
    let date: Date
    let healthStatus: String // Es: "Healthy", "Damaged"
    let maskName: String     // Es: "Mask name"
    let imageData : Data?
    
    //convenienza per ottenere immagine SwiftUI
    
    var uiImage : UIImage? {
        guard let data = imageData else { return nil }
        return UIImage(data: data)
    }
}

struct HistoryCard: View {
    @Binding var result: AnalysisResult
    let onDelete: () -> Void
    
    // Funzione per formattare la data
    private func formatted(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    var body: some View {
        HStack(spacing: 10) {
            if let image = result.uiImage{
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 2)
            }else{
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.white.opacity(0.8))
                    .frame(width: 80, height: 80)
                    .overlay(
                        Text("Photo")// <- qua va la foto
                            .font(.custom("SerifMedium", size: 18))
                            .foregroundColor(Color.themeText)
                    )
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text(result.healthStatus)
                    .font(.custom("SerifMedium", size: 20))
                    .foregroundColor(Color.themeText)
                
                Text(result.maskName)
                    .font(.custom("SerifMedium", size: 16))
                    .foregroundColor(Color.themeText)
                
                Text(formatted(date: result.date))
                    .font(.custom("SerifMedium", size: 14))
                    .foregroundColor(Color.themeText.opacity(0.81))
            }
            
            Spacer()
            Button(action: {
                onDelete()
            }) {
                Image(systemName: "trash.fill")
                    .font(.title3)
                    .foregroundColor(.themeBrown)
            }
            .buttonStyle(.plain)
        }
        .padding(15)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.lightBackground)
        )
    }
}

// Preview della singola Card
/*
 #Preview {
 HistoryCard(
 result: .constant(
 AnalysisResult(
 date: Date(),
 healthStatus: "Healthy",
 maskName: "Yogurt & Flaxseed Shine Mask"
 )
 ),
 onDelete: { }
 )
 }
 */
