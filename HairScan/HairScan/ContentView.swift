//
//  ContentView.swift
//  HairScan
//
//  Created by Pasquale Pagano & Daniele Mele on 21/10/25.
//

import SwiftUI
import CoreML
import Vision
import UIKit // Aggiunto per l'uso di UIImagePickerController

struct ContentView: View {
    @State private var predictionText: String = "Premi 'Fotocamera' per iniziare."
    @State private var inputImage: UIImage? // Immagine scattata
    @State private var isShowingImagePicker = false // Stato del Picker
    
    // Per mostrare l'immagine dopo lo scatto
    @State private var lastImage: UIImage?

    var body: some View {
        VStack(spacing: 20) {
            Text("Hair Classifier Test")
                .font(.title)
                .padding()

            // 📸 Mostra l'immagine se disponibile
            if let lastImage = lastImage {
                Image(uiImage: lastImage)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            } else {
                Text("Nessuna immagine selezionata")
                    .foregroundColor(.secondary)
            }

            Text(predictionText)
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding()

            Button("Apri Fotocamera 📷") {
                // Attiva il picker
                self.isShowingImagePicker = true
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        // 🚨 Collega il Picker alla View
        .sheet(isPresented: $isShowingImagePicker, onDismiss: runClassification) {
            ImagePicker(image: self.$inputImage, sourceType: .camera)
        }
    }

    // MARK: - Funzione Principale di Classificazione
    // Modificata per accettare un'immagine in input
    func classifyImage(_ uiImage: UIImage) {
        print("Funzione di classificazione chiamata")
        predictionText = "Classificazione in corso..."

        // 🔄 Ridimensiona immagine esattamente come nel training (224x224)
        let targetSize = CGSize(width: 224, height: 224)
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        let resizedImage = renderer.image { _ in
            uiImage.draw(in: CGRect(origin: .zero, size: targetSize))
        }
        
        guard let ciImage = CIImage(image: resizedImage) else {
            predictionText = "❌ Errore: impossibile creare CIImage"
            return
        }
        print("✅ CIImage creata correttamente")

        // 2️⃣ Carica modello ML
        let mlModel: VNCoreMLModel
        do {
            mlModel = try VNCoreMLModel(for: HairScan().model)
            print("✅ Modello ML caricato correttamente")
        } catch {
            predictionText = "❌ Errore caricamento modello: \(error.localizedDescription)"
            return
        }

        // 3️⃣ Crea richiesta Vision
        let request = VNCoreMLRequest(model: mlModel) { request, error in
            // ... (Logica di gestione dei risultati: identica a prima) ...
            if let error = error {
                DispatchQueue.main.async {
                    self.predictionText = "❌ Errore richiesta Vision: \(error.localizedDescription)"
                }
                return
            }

            if let results = request.results as? [VNClassificationObservation],
               let topResult = results.first {

                print("🔍 Risultati completi:")
                for result in results.sorted(by: { $0.confidence > $1.confidence }) {
                    print("• \(result.identifier): \(String(format: "%.2f", result.confidence * 100))%")
                }

                DispatchQueue.main.async {
                    self.predictionText =
                    """
                    🧠 Predizione: \(topResult.identifier)
                    📊 Confidenza: \(String(format: "%.2f", topResult.confidence * 100))%
                    """
                }

            } else {
                DispatchQueue.main.async {
                    self.predictionText = "⚠️ Nessun risultato"
                }
            }
        }

        // 4️⃣ Esegui richiesta su thread separato
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                let handler = VNImageRequestHandler(ciImage: ciImage)
                try handler.perform([request])
                print("✅ Richiesta Vision eseguita")
            } catch {
                DispatchQueue.main.async {
                    self.predictionText = "❌ Errore esecuzione richiesta Vision: \(error.localizedDescription)"
                }
            }
        }
    }
    
    // Funzione chiamata quando il picker viene chiuso
    func runClassification() {
        guard let inputImage = inputImage else {
            predictionText = "Nessuna foto scattata."
            return
        }
        self.lastImage = inputImage // Visualizza l'immagine scattata
        classifyImage(inputImage)
    }
}

// MARK: - 2. ImagePicker (UIViewControllerRepresentable)

// Struttura che incapsula UIImagePickerController per usarlo in SwiftUI
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage? // Riceve l'immagine scattata
    @Environment(\.dismiss) var dismiss // Per chiudere il picker
    var sourceType: UIImagePickerController.SourceType = .camera // Imposta la sorgente su Fotocamera

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = sourceType // Imposta su .camera
        picker.allowsEditing = false
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // Non è necessaria alcuna azione qui
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    // Classe Coordinator per gestire i delegate del Picker
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            // Ottiene l'immagine originale scattata
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            // Chiude il picker (sheet)
            parent.dismiss()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            // Chiude il picker se l'utente annulla
            parent.dismiss()
        }
    }
}
