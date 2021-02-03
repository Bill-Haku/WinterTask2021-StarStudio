//
//  UserSetName.swift
//  WinterTask
//
//  Created by HakuBill on 2021/02/03.
//

import SwiftUI

struct UserSetName: View {
    @ObservedObject var userNameIn = userInfo
    var body: some View {
        List {
            VStack {
                TextField("Set name",text: $userNameIn.userName)
                Spacer()
            }
            .font(.title2)
        }
        .navigationBarTitle(Text("Set new name"))
        .navigationBarItems(trailing: Button(action: {
            userInfo.$userName = userNameIn.$userName
        }, label: {
            Text("Save")
        }))
        .padding()
    }
}

struct UserSetName_Previews: PreviewProvider {
    static var previews: some View {
        UserSetName()
    }
}
