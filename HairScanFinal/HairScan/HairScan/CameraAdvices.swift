//
//  CameraAdvices.swift
//  HairScan
//
//  Created by Daniele Mele & Pasquale Pagano  on 03/11/25.
//

import SwiftUI

struct CameraAdvices: View {
    //@Environment(\.dismiss) private var dismiss
    var onClose: (() -> Void)? = nil
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack(){
                Text("HOW TO TAKE THE BEST SCAN")
                    .font(.custom("SerifMedium", size: 20))
                    .bold()
                    .foregroundColor(Color.themeText)
                    .padding(.bottom, 15)
                
                Spacer()
                
                Button(action:{ onClose?()}){
                    Image(systemName:"xmark.circle.fill")
                        .font(.system(size: 22, weight: .medium))
                }
                .padding(.bottom, 15)
                
            }
            .foregroundColor(Color.themeBrown)
            
            
            Group {
                HStack(spacing: 4) {
                    Image(systemName:"sparkle.magnifyingglass")
                    Text("Capture the full hairstyle")
                        .font(.custom("SF pro", size: 16))
                }
                .foregroundColor(Color.themeBrown)
                Divider().opacity(0.5)
                
                HStack(spacing: 4) {
                    Image(systemName: "photo.fill.on.rectangle.fill")
                        .font(.system(size: 18, weight: .medium))
                    Text("Use a simple background")
                        .font(.custom("SF pro", size: 16))
                }
                .foregroundColor(Color.themeBrown)
                Divider().opacity(0.5)
                
                HStack(spacing: 4) {
                    Image(systemName: "lightbulb.max.fill")
                        .font(.system(size: 18, weight: .medium))
                    Text("Take the photo in natural light")
                        .font(.custom("SF pro", size: 16))
                }
                .foregroundColor(Color.themeBrown)
                Divider().opacity(0.5)
                
             }
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 25)
        .background(Color.lightBackground)
        .cornerRadius(40)
        .padding(.top, 10)
        .padding(.horizontal, 10)
    }
}

#Preview {
    CameraAdvices()
}
