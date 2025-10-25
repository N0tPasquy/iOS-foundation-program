//
//  ProductCard.swift
//  HairScan
//
//  Created by Pasquale Pagano on 25/10/25.
//

import SwiftUI

struct ProductCard: View {
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false){
            HStack(spacing: 20){
                ForEach(1..<100, id: \.self){index in
                    let imageName = "Image\(index)"
                    
                    if let _ = UIImage(named: imageName){
                        Image(imageName)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 180)
                            .clipped()
                            .background(Color.themeBrown.opacity(0.8))
                            .cornerRadius(20)
                    }
                }
            }
        }
    }
}

#Preview {
    VStack(alignment: .leading) {
            ProductCard()
        }
}
