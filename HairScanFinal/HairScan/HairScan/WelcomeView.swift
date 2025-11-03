//
//  WelcomeView.swift
//  HairScan
//
//  Created by Pasquale Pagano & Daniele Mele on 29/10/25.
//
// MARK: - File che implementa la parte superiore della homepage

import SwiftUI
import UIKit // Richiesto per UIImage

struct WelcomeView: View {
    
    /// 1. Aggiunto il ViewModel
    // @StateObject assicura che il ViewModel viva
    // per tutto il ciclo di vita della View.
    //@StateObject private var viewModel = WelcomeViewModel()
    @ObservedObject var viewModel: WelcomeViewModel
    /// 2. Aggiunte variabili di stato per gestire il flusso dell'Image Picker
    @State private var showImagePickerOptions = false
    @State private var showImagePicker = false
    @State private var pickerSourceType: UIImagePickerController.SourceType = .camera
    @State private var selectedImage: UIImage?
    @State private var showAdvices = false
    
    var body: some View {
        ZStack{
            VStack{ // Contenitore per la card Welcome
                VStack(alignment: .center){
                    
                    //VStack della scritta di benvenuto (identico a prima)
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Welcome,")
                            .font(.custom("SerifMedium", size: 42))
                            .foregroundColor(Color.themeText)
                        
                        Text("Take care of your hair health, take a scan")
                            .font(.custom("SerifMedium", size: 19))
                            .foregroundColor(.themeText)
                    }
                    .padding(.horizontal, 40)
                    .padding(.bottom, 30)
                    .padding(.top, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // Bottone con effetto Neumorphism (bolla)
                    HStack{
                        // Pulsante camera
                        VStack{
                            // 3. Azione del bottone modificata
                            Button(action: {
                                // Mostra il dialogo di scelta (Fotocamera / Galleria)
                                self.showImagePickerOptions = true
                            }){
                                Image(systemName:"camera.shutter.button.fill")
                                    .font(.system(size: 60))
                                    .foregroundColor(Color.themeText)
                            }
                            
                        }
                        .padding(30)
                        .background(
                            RoundedRectangle(cornerRadius: 45)
                                .fill(Color.white)
                                .shadow(color: Color.gray.opacity(0.2), radius: 8, x: -5, y: -5)
                                .shadow(color: Color.black.opacity(0.3), radius: 8, x: 5, y: 5)
                        )
                        
                        // Pulsante Info
                        Button(action:{
                            withAnimation(.spring()){
                                showAdvices = true
                            }
                        }){
                            Image(systemName:"info.circle.fill")
                                .font(.system(size: 22, weight: .medium))
                        }
                        .padding(.top, 10)
                    }
                    
                    Text("Add photo from camera or gallery")
                        .font(.custom("SF pro", size: 14))
                        .foregroundColor(Color.themeText.opacity(0.90))
                        .padding(.bottom, 30)
                        .padding(.top, 10)
                }
                .background(Color.white.opacity(0.81))
            }
            .cornerRadius(40)
            .padding(.top, 10)
            .padding(.horizontal, 10)
            
            // 4. Aggiunta la logica per mostrare le opzioni e l'Image Picker
            
            // Dialogo per scegliere la sorgente dell'immagine
            .confirmationDialog("Choose an option", isPresented: $showImagePickerOptions, titleVisibility: .visible) {
                Button("Camera") {
                    self.pickerSourceType = .camera
                    self.showImagePicker = true
                }
                
                Button("Gallery") {
                    self.pickerSourceType = .photoLibrary
                    self.showImagePicker = true
                }
                
                Button("Cancel", role: .cancel) { }
            }
            
            // Foglio (sheet) che presenta l'ImagePicker
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: $selectedImage, sourceType: pickerSourceType)
            }
            
            // 5. Trigger che avvia l'analisi quando un'immagine viene selezionata
            .onChange(of: selectedImage) { newImage in
                if let image = newImage {
                    // Chiama la funzione di elaborazione sul ViewModel
                    viewModel.processImage(image)
                }
            }
            
            // 6. Alert per mostrare i risultati (guidato dal ViewModel)
            .alert("Scan result", isPresented: $viewModel.showAlert) {
                Button("OK", role: .cancel) {
                    // Resetta l'immagine dopo che l'utente ha visto l'alert
                    self.selectedImage = nil
                }
            } message: {
                // Mostra il messaggio proveniente dal ViewModel
                Text(viewModel.alertMessage)
            }
            
            .sheet(isPresented: $showAdvices){
                CameraAdvices()
                    .presentationDetents([.medium,.large])
                    .presentationDragIndicator(.visible)
            }
        }
    }
}
#Preview {
    let vm = WelcomeViewModel()
    vm.risultatoFinale = "Healthy"
    vm.selectedMask = healthyHairMasks.first
    return WelcomeView(viewModel: vm)
}
