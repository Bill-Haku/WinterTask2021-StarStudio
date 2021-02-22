//
//  UserInfoDetail.swift
//  WinterTask
//
//  Created by HakuBill on 2021/01/29.
//

import SwiftUI

struct UserInfoDetail: View {
    @ObservedObject var usr = userInfo
    @State private var isImagePickerDisplay = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedImage: UIImage?
    
    var body: some View {
        List {
            HStack {
                Text("Profile Photo")
                    .font(.title2)
                Spacer()
                if selectedImage != nil {
                    Image(uiImage: usr.userPhoto!)
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
                    self.isImagePickerDisplay.toggle()
                    usr.userPhoto = self.selectedImage
                    if self.selectedImage != nil {
                        print("OK")
                    } else {
                        print("NOT OK")
                    }
                } label: {
                    Text("Choose from photo library")
                }
                Button {
                    self.sourceType = .camera
                    self.isImagePickerDisplay.toggle()
                } label: {
                    Text("Choose from camera")
                }
            }
        }
        .navigationBarTitle(Text("Personal Infomation"), displayMode: .inline)
        .padding()
        .sheet(isPresented: self.$isImagePickerDisplay) {
            ImagePickerView(selectedImage: self.$selectedImage, sourceType: self.sourceType)
        }
    }
}

struct UserInfoDetail_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoDetail()
    }
}

//MARK: - UIImagePicker
struct ImagePickerView: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) var isPresented
    var sourceType: UIImagePickerController.SourceType
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = self.sourceType
        return imagePicker
    }
    
    class Coordinator: NSObject,UINavigationControllerDelegate,UIImagePickerControllerDelegate {
        var picker: ImagePickerView
        
        init(picker: ImagePickerView) {
            self.picker = picker
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let selectedImage = info[.originalImage] as? UIImage else { return }
            self.picker.selectedImage = selectedImage
            self.picker.isPresented.wrappedValue.dismiss()
        }
    }
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(picker: self)
    }
}
