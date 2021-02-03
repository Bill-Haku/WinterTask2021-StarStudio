//
//  UserInfoDetail.swift
//  WinterTask
//
//  Created by HakuBill on 2021/01/29.
//

import SwiftUI

struct UserInfoDetail: View {
    @ObservedObject var userNameIn = userInfo
    var body: some View {
        /*VStack {
            HStack {
                Text("Your name:").font(.title)
                Spacer()
            }
            TextField("Your Name", text: $userNameIn.userName)
                .font(.title)
                .foregroundColor(.blue)
            Spacer()
            Button(action: {
                    /*userName = userNameIn
                    print(userName)*/
                userInfo.$userName = userNameIn.$userName
            }, label: {
                Text("Save")
            })
        }.padding()*/
        List {
            HStack {
                Text("Profile Photo")
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
