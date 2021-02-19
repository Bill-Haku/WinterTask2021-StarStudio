//
//  UserInfoView.swift
//  WinterTask
//
//  Created by HakuBill on 2021/01/23.
//

import SwiftUI

struct UserInfoView: View {
    @ObservedObject var usr = userInfo
    var body: some View {
        return NavigationView {
            List {
                Section {
                    HStack {
                        if userInfo.userPhoto != nil {
                            Image(uiImage: userInfo.userPhoto!)
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
                        
                        Divider()
                        Text(usr.userName)
                            .font(.title)
                    }
                    .frame(height: 90)
                }
                Section(header: Text(" ")){
                    NavigationLink(destination: UserInfoDetail()) {
                        Text("Edit your profile")
                    }
                    Button(action: {
                        cleanCache()
                    }, label: {
                        Text("Clean cache")
                    })
                }
            }
            .navigationBarTitle(Text("User"),displayMode: .large)
        }
    }
}

struct UserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoView()
    }
}
