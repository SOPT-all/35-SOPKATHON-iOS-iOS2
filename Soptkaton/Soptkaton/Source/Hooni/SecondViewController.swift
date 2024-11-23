//
//  SecondViewController.swift
//  Soptkaton
//
//  Created by 최주리 on 11/23/24.
//

import UIKit
import SnapKit
import Then

class SecondViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - Properties
    private lazy var cameraButton = UIButton().then {
        $0.setTitle("카메라", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.backgroundColor = .systemGray5
        $0.layer.cornerRadius = 8
    }
    
    private lazy var imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .systemGray6
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
        setAddTarget()
    }
    
    // MARK: - UI
    private func setLayout() {
        view.backgroundColor = .white
        
        [imageView, cameraButton].forEach {
            view.addSubview($0)
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(imageView.snp.width)
        }
        
        cameraButton.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(100)
            $0.height.equalTo(44)
        }
    }
    
    private func setAddTarget() {
        cameraButton.addTarget(self, action: #selector(cameraButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Methods
    @objc private func cameraButtonTapped() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePickerController = UIImagePickerController().then {
                $0.sourceType = .camera
                $0.delegate = self
                $0.allowsEditing = true
            }
            present(imagePickerController, animated: true)
        } else {
            showAlert(message: "카메라를 사용할 수 없습니다.")
        }
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert).then {
            let okAction = UIAlertAction(title: "확인", style: .default)
            $0.addAction(okAction)
        }
        present(alert, animated: true)
    }
    
    // MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            imageView.image = image
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
}


