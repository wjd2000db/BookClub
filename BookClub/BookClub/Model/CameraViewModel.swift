//
//  CameraViewModel.swift
//  BookClub
//
//  Created by Yujin on 11/23/24.
//

import Foundation
import AVFoundation
import UIKit
import CoreData

class CameraViewModel: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate {
    @Published var session: AVCaptureSession
    @Published var isPhotoTaken = false
    @Published var capturedImage: UIImage? = nil 
    
    private let photoOutput = AVCapturePhotoOutput()
    
    override init() {

        self.session = AVCaptureSession()
        super.init()
        configure()
    }
    
    func configure() {
        session.beginConfiguration()
        
        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back),
              let input = try? AVCaptureDeviceInput(device: device) else {
            print("Camera device not available.")
            return
        }
        
        if session.canAddInput(input) {
            session.addInput(input)
        }
        
        if session.canAddOutput(photoOutput) {
            session.addOutput(photoOutput)
        }
        
        session.commitConfiguration()
    }
    
    func capturePhoto() {
        let settings = AVCapturePhotoSettings()
        photoOutput.capturePhoto(with: settings, delegate: self)
    }
    

    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {

        guard let imageData = photo.fileDataRepresentation() else { return }
        self.capturedImage = UIImage(data: imageData)
        self.isPhotoTaken = true
    }
    
}
