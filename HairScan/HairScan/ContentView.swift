//
//  ContentView.swift
//  HairScan
//
//  Created by Pasquale Pagano & Daniele Mele on 21/10/25.
//

import SwiftUI
import CoreML
import Vision
import UIKit

struct ContentView: View {
    @State private var predictionText: String = "Premi 'Fotocamera' per iniziare."
    @State private var inputImage: UIImage?          // Immagine scattata
    @State private var isShowingImagePicker = false  // Stato del Picker
    @State private var lastImage: UIImage?           // Ultima immagine scattata
    @State private var isProcessing = false          // Mostra spinner durante analisi
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Hair Classifier Test")
                .font(.title)
                .padding()

            // Mostra l'immagine scattata
            if let lastImage = lastImage {
                Image(uiImage: lastImage)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 250)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 5)
            } else {
                Text("Nessuna immagine selezionata")
                    .foregroundColor(.secondary)
            }

            // Mostra testo o spinner
            if isProcessing {
                ProgressView("Analisi in corso...")
                    .progressViewStyle(CircularProgressViewStyle())
            } else {
                Text(predictionText)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding()
            }

            // Pulsante fotocamera
            Button("Apri Fotocamera 📷") {
                self.isShowingImagePicker = true
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .sheet(isPresented: $isShowingImagePicker, onDismiss: runClassification) {
            ImagePicker(image: self.$inputImage, sourceType: .camera)
        }
    }

    // MARK: - Funzione principale di classificazione
    func classifyImage(_ uiImage: UIImage) {
        print("📸 Foto acquisita, avvio rilevamento capelli...")
        isProcessing = true
        predictionText = "Analisi in corso..."

        // Ridimensiona immagine per uniformarla
        let targetSize = CGSize(width: 224, height: 224)
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        let resizedImage = renderer.image { _ in
            uiImage.draw(in: CGRect(origin: .zero, size: targetSize))
        }

        guard let ciImage = CIImage(image: resizedImage) else {
            predictionText = "❌ Errore: impossibile creare CIImage"
            isProcessing = false
            return
        }

        // 1️⃣ Controlla se ci sono capelli
        detectHair(in: ciImage) { hasHair in
            if hasHair {
                print("✅ Capelli rilevati — procedo con la classificazione dello stato di salute")
                self.classifyHairCondition(ciImage)
            } else {
                print("⚠️ Nessun capello rilevato — chiedo nuova foto")
                DispatchQueue.main.async {
                    self.isProcessing = false
                    self.predictionText = "⚠️ Nessun capello rilevato.\nRifai la foto avvicinandoti ai capelli."
                }
            }
        }
    }

    // MARK: - FASE 1: Rilevamento capelli
    func detectHair(in ciImage: CIImage, completion: @escaping (Bool) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                let hairDetectionModel = try VNCoreMLModel(for: HairDetection().model)

                let request = VNCoreMLRequest(model: hairDetectionModel) { request, _ in
                    guard let results = request.results as? [VNClassificationObservation],
                          let topResult = results.first else {
                        completion(false)
                        return
                    }

                    print("🔍 Rilevamento capelli: \(topResult.identifier) - \(String(format: "%.2f", topResult.confidence * 100))%")

                    // Consideriamo "Hair" valido solo se la confidenza è > 70%
                    let hasHair = (topResult.identifier == "Hair" && topResult.confidence > 0.7)

                    DispatchQueue.main.async {
                        completion(hasHair)
                    }
                }

                let handler = VNImageRequestHandler(ciImage: ciImage)
                try handler.perform([request])

            } catch {
                print("❌ Errore nel rilevamento capelli: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(false)
                }
            }
        }
    }

    // MARK: - FASE 2: Classificazione dello stato di salute
    func classifyHairCondition(_ ciImage: CIImage) {
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                let hairScanModel = try VNCoreMLModel(for: HairScan().model)

                let request = VNCoreMLRequest(model: hairScanModel) { request, error in
                    DispatchQueue.main.async {
                        self.isProcessing = false
                    }

                    if let error = error {
                        DispatchQueue.main.async {
                            self.predictionText = "❌ Errore richiesta Vision: \(error.localizedDescription)"
                        }
                        return
                    }

                    if let results = request.results as? [VNClassificationObservation],
                       let topResult = results.first {

                        print("🔍 Stato capelli:")
                        for result in results.sorted(by: { $0.confidence > $1.confidence }) {
                            print("• \(result.identifier): \(String(format: "%.2f", result.confidence * 100))%")
                        }

                        DispatchQueue.main.async {
                            self.predictionText =
                            """
                            🧠 Stato capelli: \(topResult.identifier)
                            📊 Confidenza: \(String(format: "%.2f", topResult.confidence * 100))%
                            """
                        }

                    } else {
                        DispatchQueue.main.async {
                            self.predictionText = "⚠️ Nessun risultato per lo stato dei capelli."
                        }
                    }
                }

                let handler = VNImageRequestHandler(ciImage: ciImage)
                try handler.perform([request])

            } catch {
                DispatchQueue.main.async {
                    self.isProcessing = false
                    self.predictionText = "❌ Errore esecuzione modello HairScan: \(error.localizedDescription)"
                }
            }
        }
    }

    // MARK: - Gestione del picker
    func runClassification() {
        guard let inputImage = inputImage else {
            predictionText = "Nessuna foto scattata."
            return
        }
        self.lastImage = inputImage
        classifyImage(inputImage)
    }
}

// MARK: - ImagePicker
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.dismiss) var dismiss
    var sourceType: UIImagePickerController.SourceType = .camera

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = sourceType
        picker.allowsEditing = false
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            parent.dismiss()
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.dismiss()
        }
    }
}

