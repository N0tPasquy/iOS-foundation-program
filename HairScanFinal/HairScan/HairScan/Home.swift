//
//  Home.swift
//  HairScan
//
//  Created by Daniele Mele on 22/10/25.
//

import SwiftUI

struct Home: View {
    var body: some View {
        VStack(spacing: 0) {
            // HEADER
            HStack {
                Text("HairScan")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Spacer()
                
                Button(action: {
                    print("Pulsante impostazioni premuto")
                }) {
                    Image(systemName: "gearshape.fill")
                        .font(.title2)
                        .foregroundColor(.primary)
                }
            }
            .padding(.horizontal)
            .padding(.top, 10)
            .background(Color(.systemGroupedBackground))
            
            Spacer(minLength: 10)
            

            VStack(alignment: .leading, spacing: 12) {
                Text("Welcome,")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text("Take care of your hair health, perform a scan")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.systemGray5))
                        .shadow(radius: 1)
                    
                    VStack(spacing: 8) {
                        Text("Last Scan:")
                            .font(.caption)
                            .fontWeight(.medium)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 4)
                            .background(Capsule().fill(Color(.systemGray6)))
                            .foregroundColor(.secondary)
                        
                        Image(systemName: "camera")
                            .font(.system(size: 55))
                            .foregroundColor(.secondary)
                        
                        Text("No Scan found")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                }
                .frame(height: 160)
                
                
                
                
                VStack(spacing: 8) {
                    TipCardCompact(
                        icon: "magnifyingglass.circle.fill",
                        color: .blue,
                        title: "Capture the full hairstyle",
                    )
                    
                    TipCardCompact(
                        icon: "photo.on.rectangle",
                        color: .green,
                        title: "Use a simple background",
                    )
                    
                    TipCardCompact(
                        icon: "lightbulb.fill",
                        color: .orange,
                        title: "Take the photo in natural light",
                    )
                }
            }
            .padding(.horizontal)
            
            Spacer(minLength: 15)
        }
        .background(Color(.systemBackground))
        .ignoresSafeArea(edges: .top)
    }

}


struct TipCardCompact: View {
    let icon: String
    let color: Color
    let title: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            ZStack {
                Circle()
                    .fill(color.opacity(0.2))
                    .frame(width: 35, height: 35)
                Image(systemName: icon)
                    .foregroundColor(color)
                    .font(.system(size: 16))
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
            }
            
            Spacer()
        }
        .padding(8)
        .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)))
        .shadow(radius: 0.5)
    }
}

#Preview {
    Home()
}

