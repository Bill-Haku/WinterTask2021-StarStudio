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
        VStack {
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
        }.padding()

    }
}

struct UserInfoDetail_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoDetail()
    }
}
