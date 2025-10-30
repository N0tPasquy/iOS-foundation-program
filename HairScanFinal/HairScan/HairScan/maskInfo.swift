import SwiftUI

struct MaskInfo: View {
    @Environment(\.dismiss) var dismiss
    
    let hairCondition: String
    let maskName: String
    
    // Trova la maschera corrispondente
    private var selectedMask: MaskList? {
        let allMasks = healthyHairMasks + damagedHairMask + veryDamagedHairMask
        return allMasks.first {
            $0.maskName.lowercased() == maskName.lowercased()
        }
    }
    
    var body: some View {
        ZStack {
            Color.lightBackground.ignoresSafeArea()
            
            VStack(alignment: .leading) {
                // HEADER
                HStack {
                    Text("HAIRSCAN")
                        .font(.custom("SerifMedium", size: 22))
                        .bold()
                        .foregroundColor(Color.themeText)
                    
                    Spacer()
                }
                .padding(.horizontal, 30)
                .padding(.top, 15)
                
                // CONTENUTO PRINCIPALE
                ScrollView {
                    if let mask = selectedMask {
                        VStack(alignment: .leading, spacing: 20) {
                            Text(mask.maskName)
                                .font(.custom("SerifMedium", size: 32))
                                .bold()
                                .foregroundColor(Color.themeText)
                                .padding(.bottom, 10)
                            
                            Group {
                                MaskInfoRow(title: "Hair Condition", value: mask.hairCondition)
                                MaskInfoRow(title: "Ingredients", value: mask.ingredients)
                                MaskInfoRow(title: "Benefit", value: mask.benefit)
                                MaskInfoRow(title: "Application Time", value: mask.applicationTime)
                                MaskInfoRow(title: "Frequency", value: mask.frequency)
                                MaskInfoRow(title: "Usage Note", value: mask.usageNote)
                            }
                        }
                        .padding(.horizontal, 30)
                        .padding(.vertical, 25)
                        .background(Color.white.opacity(0.81))
                        .cornerRadius(40)
                        .padding(.top, 10)
                        .padding(.horizontal, 10)
                    } else {
                        Text("No details found for this mask.")
                            .font(.custom("SerifMedium", size: 18))
                            .foregroundColor(.gray)
                            .italic()
                            .padding()
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    HStack(spacing: 4) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, weight: .medium))
                        Text("Back")
                            .font(.custom("SerifMedium", size: 18))
                    }
                    .foregroundColor(Color.themeText)
                }
            }
        }
    }
}

// MARK: - InfoRow Helper
struct MaskInfoRow: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.custom("SerifMedium", size: 18))
                .foregroundColor(Color.themeText)
                .bold()
            Text(value)
                .font(.custom("SerifMedium", size: 16))
                .foregroundColor(Color.themeText)
        }
    }
}

#Preview {
    MaskInfo(hairCondition: "Damaged hair", maskName: "Banana & Honey Moisture Mask")
}

