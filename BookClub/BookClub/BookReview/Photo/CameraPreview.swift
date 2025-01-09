// FILE : CameraPreview.swift
// PROJECT : PROG2030-Assignment #3 - BookClub
// PROGRAMMER : Yujin Jeong, Yujung Park
// FIRST VERSION : 2024-11-28
// DESCRIPTION : Defines the CameraPreview component, which integrates a UIKit-based
//              video preview into a SwiftUI view for displaying the live camera feed.


import SwiftUI
import AVFoundation

struct CameraPreview: UIViewRepresentable {
    class VideoPreviewView: UIView {
        override class var layerClass: AnyClass {
            AVCaptureVideoPreviewLayer.self
        }
        
        var previewLayer: AVCaptureVideoPreviewLayer {
            layer as! AVCaptureVideoPreviewLayer
        }
    }
    
    @ObservedObject var viewModel: CameraViewModel

    func makeUIView(context: Context) -> VideoPreviewView {
        let view = VideoPreviewView()
        view.previewLayer.session = viewModel.session
        view.previewLayer.videoGravity = .resizeAspectFill
        return view
    }
    

    func updateUIView(_ uiView: VideoPreviewView, context: Context) { }
}

