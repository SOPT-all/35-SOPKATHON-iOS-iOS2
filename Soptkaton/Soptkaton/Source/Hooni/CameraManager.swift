//
//  CameraManager.swift
//  Soptkaton
//
//  Created by 이지훈 on 11/24/24.
//

import Foundation
import UIKit

class CameraManager: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // Singleton 패턴으로 관리 (선택)
    static let shared = CameraManager()
    private override init() {}
    
    private var completion: ((UIImage?) -> Void)?
    
    func presentCamera(from viewController: UIViewController, completion: @escaping (UIImage?) -> Void) {
        self.completion = completion
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.sourceType = .camera
            imagePickerController.delegate = self
            imagePickerController.allowsEditing = true
            viewController.present(imagePickerController, animated: true)
        } else {
            let alert = UIAlertController(title: "알림", message: "카메라를 사용할 수 없습니다.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default))
            viewController.present(alert, animated: true)
        }
    }
    
    // MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let image = info[.editedImage] as? UIImage
        completion?(image)
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        completion?(nil)
        picker.dismiss(animated: true)
    }
}
