//
//  ImagePicker.swift
//  Soptkaton
//
//  Created by 이지훈 on 11/24/24.
//

import UIKit
import SwiftUI
import AVFoundation


struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    var sourceType: UIImagePickerController.SourceType
    var completion: () -> Void
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        
        // 전체 화면으로 설정
        picker.modalPresentationStyle = .fullScreen
        
        // 카메라 UI 설정
        if sourceType == .camera {
            picker.cameraCaptureMode = .photo
            picker.cameraDevice = .rear
            picker.showsCameraControls = true
            
            // 카메라 오버레이 뷰를 설정하여 전체 화면을 채우도록 함
            if let cameraOverlayView = createCameraOverlayView() {
                picker.cameraOverlayView = cameraOverlayView
            }
        }
        
        return picker
    }
    
    private func createCameraOverlayView() -> UIView? {
        guard let window = UIApplication.shared.windows.first else { return nil }
        
        let overlayView = UIView(frame: window.frame)
        overlayView.backgroundColor = .clear
        
        // 카메라 프리뷰가 전체 화면을 채우도록 설정
        if let videoPreviewLayer = overlayView.layer as? AVCaptureVideoPreviewLayer {
            videoPreviewLayer.videoGravity = .resizeAspectFill
        }
        
        return overlayView
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.image = image
            }
            picker.dismiss(animated: true) {
                self.parent.completion()
            }
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }
}
