// FILE : PhotosUtil.swift
// PROJECT : PROG2030-Assignment #3 - BookClub
// PROGRAMMER : Yujin Jeong, Yujung Park
// FIRST VERSION : 2024-11-28
// DESCRIPTION : handle photo-related operations such as saving images to the device's photo library.
//              It includes a singleton instance (shared) and a savePhotoToLibrary method, which
//              requests the user's authorization to access the photo library and saves the given UIImage.

import Foundation
import Photos
import UIKit

class PhotosUtil {
    static let shared = PhotosUtil()

    func savePhotoToLibrary(_ image: UIImage) {
        PHPhotoLibrary.requestAuthorization { status in
            guard status == .authorized else {
                print("Photo library access not authorized")
                return
            }
            
            PHPhotoLibrary.shared().performChanges({
                PHAssetChangeRequest.creationRequestForAsset(from: image)
            }) { success, error in
                if success {
                    print("Photo saved successfully!")
                } else {
                    print("Error saving photo: \(error?.localizedDescription ?? "Unknown error")")
                }
            }
        }
    }
    
    
}
