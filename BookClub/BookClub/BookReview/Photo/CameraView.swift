// FILE : CameraView.swift
// PROJECT : PROG2030-Assignment #3 - BookClub
// PROGRAMMER : Yujin Jeong, Yujung Park
// FIRST VERSION : 2024-11-28
// DESCRIPTION : SwiftUI interface for capturing photos using the device's camera.
//              If a photo is captured, it is displayed on the screen with options
//              to either confirm (OK) or cancel (Cancel) the photo.


import SwiftUI
import AVFoundation

struct CameraView: View {
    @StateObject private var cameraViewModel = CameraViewModel()
    @State private var showCapturePhotoAlert = false
    @Binding var capturedImage: UIImage?
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            ZStack {
                if let capturedImage = cameraViewModel.capturedImage {
                    Image(uiImage: capturedImage)
                        .resizable()
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    VStack {
                        Spacer()
                        HStack {
                            Button("Cancel") {
                                cameraViewModel.capturedImage = nil
                                dismiss()
                            }
                            .frame(width: 100, height: 50)
                            .background(Color.white.opacity(0.8))
                            .clipShape(Capsule())

                            Button("OK") {
                                self.capturedImage = cameraViewModel.capturedImage
                                dismiss()
                            }
                            .frame(width: 100, height: 50)
                            .background(Color.white.opacity(0.8))
                            .clipShape(Capsule())
                        }
                        .padding(.bottom, 30)
                    }
                } else {
                    CameraPreview(viewModel: cameraViewModel)
                        .ignoresSafeArea()
                        .onAppear {
                            cameraViewModel.session.startRunning()
                        }
                }
                
                VStack {
                    Spacer()
                    if cameraViewModel.capturedImage == nil {
                        Button(action: {
                            cameraViewModel.capturePhoto()
                            capturedImage = cameraViewModel.capturedImage
                        }) {
                            Color.white
                                .frame(width: 70, height: 70) 
                                .clipShape(Circle())
                        }
                    }
                }
            }
        }
    }
}

