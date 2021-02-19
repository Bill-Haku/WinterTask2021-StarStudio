//
//  UserInfoDetail.swift
//  WinterTask
//
//  Created by HakuBill on 2021/01/29.
//

import SwiftUI

struct UserInfoDetail: View {
    @ObservedObject var userNameIn = userInfo
    @State var showImagePicker = false
    @State var image: Image? = nil
    
    var body: some View {
        List {
            HStack {
                Text("Profile Photo")
                    .font(.title2)
                Spacer()
                Image("GirlInside")
                    .resizable()
                    .frame(width: 76, height: 80, alignment: .center)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 5)
            }
            NavigationLink(destination: UserSetName()) {
                HStack {
                    Text("Name")
                    Spacer()
                    Text(userInfo.userName)
                }
            }
            Button(action: {
                
            }, label: {
                Text("Change your profile photo")
            })
        }
        .navigationBarTitle(Text("Personal Infomation"), displayMode: .inline)
        .padding()

    }
}

struct UserInfoDetail_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoDetail()
    }
}
