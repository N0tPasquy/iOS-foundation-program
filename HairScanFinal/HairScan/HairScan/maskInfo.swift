import SwiftUI

// Per far compilare il codice, aggiungo definizioni fittizie per i tuoi colori.
// Puoi rimuovere questa estensione se hai già definito i colori altrove.
struct maskInfo: View {
    @Environment(\.dismiss) var dismiss
    
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
                
                // --- INIZIO CODICE AGGIUNTO ---
                // Sostituiamo il VStack segnaposto con una ScrollView
                // per contenere tutti i dettagli delle maschere.
                ScrollView {
                    VStack(alignment: .leading, spacing: 25) {
                        
                        // --- Sezione: Capelli Sani ---
                        Text("Healthy Hair")
                            .font(.custom("SerifMedium", size: 26))
                            .bold()
                            .foregroundColor(Color.themeText)
                            .padding(.bottom, 5)

                        MaskDetailView(
                            name: "Yogurt & Flaxseed Shine Mask",
                            ingredients: "1 tbsp plain yogurt, 1 tsp flaxseed oil, 1 tsp honey",
                            benefits: "Adds shine, hydration, and smooth texture; maintains healthy scalp",
                            time: "15–20 min",
                            frequency: "Every 2 weeks",
                            notes: "Apply to wet hair; rinse well to avoid residue"
                        )

                        MaskDetailView(
                            name: "Green Tea & Honey Balance Mask",
                            ingredients: "2 tbsp brewed green tea (cooled), 1 tbsp honey, 1 tsp jojoba oil",
                            benefits: "Rich in antioxidants that protect hair from environmental damage; keeps scalp balanced and adds shine",
                            time: "15–20 min",
                            frequency: "Every 2–3 weeks",
                            notes: "Apply to clean; massage gently into scalp and lengths, rinse thoroughly with lukewarm water"
                        )

                        Divider().padding(.vertical, 10)

                        // --- Sezione: Capelli Danneggiati ---
                        Text("Damaged Hair")
                            .font(.custom("SerifMedium", size: 26))
                            .bold()
                            .foregroundColor(Color.themeText)
                            .padding(.bottom, 5)
                        
                        MaskDetailView(
                            name: "Banana & Honey Moisture Mask",
                            ingredients: "1 banana, 1 tbsp honey, 1 tsp coconut oil",
                            benefits: "Restores moisture balance, reduces frizz, and improves elasticity",
                            time: "25–30 min",
                            frequency: "1× per week",
                            notes: "Blend until smooth to avoid banana chunks; apply evenly to lengths"
                        )

                        MaskDetailView(
                            name: "Amla & Castor Oil Growth Mask",
                            ingredients: "1 tbsp amla oil, 1 tbsp castor oil, few drops rosemary essential oil (optional)",
                            benefits: "Promotes growth, strengthens roots, reduces breakage",
                            time: "30–45 min",
                            frequency: "Every 2 weeks",
                            notes: "Massage into scalp before washing; helps boost circulation"
                        )

                        Divider().padding(.vertical, 10)

                        // --- Sezione: Capelli Molto Danneggiati ---
                        Text("Very Damaged Hair")
                            .font(.custom("SerifMedium", size: 26))
                            .bold()
                            .foregroundColor(Color.themeText)
                            .padding(.bottom, 5)

                        MaskDetailView(
                            name: "Coconut & Aloe Rescue Mask",
                            ingredients: "2 tbsp coconut oil, 1 tbsp aloe vera gel, ½ banana (optional)",
                            benefits: "Reconstructs from within; hydrates and strengthens; adds softness and shine",
                            time: "30–40 min",
                            frequency: "Every 10–14 days",
                            notes: "Warm slightly before applying; avoid heat styling for 24h after use"
                        )
                        
                        MaskDetailView(
                            name: "Olive & Aloe Deep Repair Mask",
                            ingredients: "2 tbsp olive oil, 2 tbsp aloe vera gel, 1 tsp argan oil",
                            benefits: "Deep repair for over-processed hair; adds elasticity and protection",
                            time: "45–60 min",
                            frequency: "Every 2 weeks",
                            notes: "Cover with warm towel or cap; rinse thoroughly with mild shampoo"
                        )
                    }
                    .padding(.horizontal, 30) // Padding interno alla card
                    .padding(.vertical, 25)   // Padding interno alla card
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .background(Color.white.opacity(0.81))
                .cornerRadius(40)
                .padding(.top, 10) // Aggiunge spazio tra l'header e la card
                .padding(.horizontal, 10)
                // --- FINE CODICE AGGIUNTO ---
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss() // Azione per tornare indietro
                }) {
                    HStack(spacing: 4) { // Un Hstack per icona e testo
                        Image(systemName: "chevron.left")
                            // Regola la dimensione e il peso come preferisci
                            .font(.system(size: 18, weight: .medium))
                        Text("Back")
                            // Usa il tuo font personalizzato
                            .font(.custom("SerifMedium", size: 18))
                    }
                    .foregroundColor(Color.themeText) // Usa il tuo colore personalizzato
                }
            }
        }
    }
}

// --- VISTE HELPER AGGIUNTE ---

/// Una vista riutilizzabile per mostrare i dettagli di una singola maschera.
struct MaskDetailView: View {
    let name: String
    let ingredients: String
    let benefits: String
    let time: String
    let frequency: String
    let notes: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Nome della maschera
            Text(name)
                .font(.custom("SerifMedium", size: 20))
                .bold()
                .foregroundColor(Color.themeText)
                .padding(.bottom, 4)

            // Dettagli con elenco puntato
            BulletDetail(title: "Ingredients", value: ingredients)
            BulletDetail(title: "Key Benefits", value: benefits)
            BulletDetail(title: "Application Time", value: time)
            BulletDetail(title: "Recommended Frequency", value: frequency)
            BulletDetail(title: "Usage Notes", value: notes)
        }
    }
}

/// Una vista helper per creare una riga con un punto elenco e testo formattato.
struct BulletDetail: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Text("•")
                .font(.custom("SerifMedium", size: 16))
                .foregroundColor(Color.themeText)
            
            // Usiamo Text(.init("...")) per abilitare il parsing Markdown (per il grassetto)
            Text(.init("**\(title):** \(value)"))
                .font(.custom("SerifMedium", size: 16))
                .foregroundColor(Color.themeText)
                .lineSpacing(3) // Migliora la leggibilità
        }
    }
}

// --- ANTEPRIMA ---
struct maskInfo_Previews: PreviewProvider {
    static var previews: some View {
        // Includi la NavigationStack per vedere la barra di navigazione e il pulsante "Back"
        NavigationView {
            maskInfo()
        }
    }
}
