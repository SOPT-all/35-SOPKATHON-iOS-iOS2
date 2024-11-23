//
//  QuestDetailView.swift
//  Soptkaton
//
//  Created by HanJW on 11/24/24.
//

import SwiftUI

struct QuestDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var questData: QuestResponse?
    var onPhotoTaken: (() -> Void)?
    
    private let homeService = HomeService()
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color(.jungleGradientColor(.start)), Color(.jungleGradientColor(.end))], startPoint: .topLeading, endPoint: .bottomTrailing)

            VStack(spacing: 0) {
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color(.jungleSystemColor(.white)))
                            .font(.system(size: 18, weight: .semibold))
                    }
                    Spacer()
                }
                .padding(.horizontal, 16)
                .frame(height: 44)
                .padding(.top, getSafeArea().top)
                
                ZStack {
                    VStack{
                        Image("img_card")
                            .frame(width: 327, height: 505)
                            .padding([.bottom])
                    }
                    
                    VStack {
                        Text("체력 단련")
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(
                                Capsule()
                                    .fill(Color(.jungleMainColor(.main)))
                            )
                            .foregroundStyle(Color(.jungleSystemColor(.white)))
                            .font(.jungleBody(.body1b16))
                            .offset(y: -185)
                        
                        Text(questData?.quest_name ?? "")
                            .foregroundStyle(Color(.jungleSystemColor(.white)))
                            .font(.jungleHeading(.heading3b20))
                            .offset(y: -170)
                    }
                    
                    HStack{
                        ZStack {
                            Image("img_score_bg")
                            
                            HStack {
                                Text("경험치")
                                Text("|")
                                Text("+" + "\(questData?.quest_exp ?? 0)")
                            }
                        }
                        .foregroundStyle(Color(.jungleMainColor(.sub)))
                        .font(.jungleBody(.body2m14))
                        .rotationEffect(.degrees(12))
                        .offset(y: -2)
                        
                        ZStack {
                            Image("img_middle_shape")
                            
                            Text(questData?.quest_level ?? "")
                                .rotationEffect(.degrees(-12))
                        }
                        .foregroundStyle(Color(.jungleMainColor(.sub)))
                        .font(.jungleBody(.body1b16))
                        .offset(y: -30)
                    }
                    
                    Text(questData?.quest_description ?? "")
                        .font(.jungleBody(.body2m14))
                        .foregroundStyle(Color(.jungleSystemColor(.white)))
                        .frame(width: 279, height: 54)
                        .offset(y: 134)
                }
                
                Button(action: {
                    showImagePicker = true
                }, label: {
                    Text("도전하기")
                })
                .frame(width: 327, height: 56)
                .background(Color(.jungleMainColor(.main)))
                .foregroundStyle(Color(.jungleSystemColor(.white)))
                .font(.jungleBody(.body1b16))
                .cornerRadius(12)
                
                Spacer()
            }
        }
        .fullScreenCover(isPresented: $showImagePicker) {
            ImagePicker(image: $selectedImage, sourceType: .camera) {
                if selectedImage != nil {
                    dismiss()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        onPhotoTaken?()
                    }
                }
            }
            .edgesIgnoringSafeArea(.all)
            .navigationBarHidden(true)
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
        .task {
            do {
                questData = try await homeService.fetchQuestData()
            } catch {
                print("Failed to fetch quest data:", error)
            }
        }
    }
    
    func getSafeArea() -> UIEdgeInsets {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = screen.windows.first else {
            return .zero
        }
        return window.safeAreaInsets
    }
    
    private func showCustomAlert() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first,
           let rootViewController = window.rootViewController {
            let alertVC = CustomAlertViewController()
            alertVC.experienceText = questData?.quest_exp ?? 0
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            rootViewController.present(alertVC, animated: true)
        }
    }
}

#Preview {
    QuestDetailView()
}
