//
//  UserInfoDetail.swift
//  WinterTask
//
//  Created by HakuBill on 2021/01/29.
//

import SwiftUI

struct UserInfoDetail: View {
    @ObservedObject var usr = userInfo
    @State private var showImagePicker = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var image: Image? = nil
    
    var body: some View {
        List {
            HStack {
                Text("Profile Photo")
                    .font(.title2)
                Spacer()
                if image != nil {
                    image?
                        .resizable()
                        .frame(width: 76, height: 80, alignment: .center)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .shadow(radius: 5)
                }
                else {
                    Image("GirlInside")
                        .resizable()
                        .frame(width: 76, height: 80, alignment: .center)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .shadow(radius: 5)
                }
            }
            NavigationLink(destination: UserSetName()) {
                HStack {
                    Text("Name")
                    Spacer()
                    Text(usr.userName)
                }
            }
            Menu("Change your profile photo") {
                Button {
                    self.sourceType = .photoLibrary
                    self.showImagePicker.toggle()
                } label: {
                    Text("Choose from photo library")
                }
                Button {
                    self.sourceType = .camera
                    self.showImagePicker.toggle()
                } label: {
                    Text("Choose from camera")
                }
            }
        }
        .navigationBarTitle(Text("Personal Infomation"), displayMode: .inline)
        .padding()
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(sourceType: self.sourceType) {image in
                self.image = Image(uiImage: image)
                usr.userPhoto = Image(uiImage: image)
            }
        }
    }
}

struct UserInfoDetail_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoDetail()
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode)
    private var presentationMode
    
    let sourceType: UIImagePickerController.SourceType
    let onImagePicked: (UIImage) -> Void
    
    final class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        @Binding
        private var presentationMode: PresentationMode
        private let sourceType: UIImagePickerController.SourceType
        private let onImagePicked: (UIImage) -> Void
        init(presentationMode: Binding<PresentationMode>, sourceType: UIImagePickerController.SourceType, onImagePicked: @escaping(UIImage) -> Void) {
            _presentationMode = presentationMode
            self.sourceType = sourceType
            self.onImagePicked = onImagePicked
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            let uiImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            onImagePicked(uiImage)
            presentationMode.dismiss()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            presentationMode.dismiss()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(presentationMode: presentationMode, sourceType: sourceType, onImagePicked: onImagePicked)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
}
