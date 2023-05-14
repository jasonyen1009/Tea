//
//  SignUpView.swift
//  Tea
//
//  Created by Yen Hung Cheng on 2023/5/14.
//

import SwiftUI
import FirebaseAuth

struct SignUpView: View {
    
    @State private var email = ""
    @State private var name = ""
    @State private var password = ""
    @State private var copassword = ""
    @State private var alertTitle = ""
    // 控制圖片放大縮小
    @State private var isEditing = false
    @State private var showAlert = false
    
    var body: some View {
        ZStack {
            // 背景底色
            Color(red: 0, green: 62/255, blue: 82/255)
                .ignoresSafeArea()
            VStack {
                Image("可不可註冊頁面")
                    .resizable()
                    .scaledToFill()
                    .frame(width: isEditing ? 100 : 300, height: isEditing ? 100 : 300)
                    .clipShape(Circle())
                    // 添加動畫效果
                    .animation(.easeInOut(duration: 0.3))
                    
                    
                Form {
                    Section("Email") {
                        TextField("", text: $email, onEditingChanged: { editing in
                            self.isEditing = editing
                        })
                            .background(.white)
                            .foregroundColor(.black)
                    }
                    Section("Username") {
                        TextField("", text: $name, onEditingChanged: { editing in
                            self.isEditing = editing
                        })
                            .background(.white)
                            .foregroundColor(.black)
                    }
                    Section("Password") {
                        TextField("", text: $password, onEditingChanged: { editing in
                            self.isEditing = editing
                        })
                            .background(.white)
                            .foregroundColor(.black)
                    }
                    Section("Confirm Password") {
                        TextField("", text: $copassword, onEditingChanged: { editing in
                            self.isEditing = editing
                        })
                            .background(.white)
                            .foregroundColor(.black)
                    }
                }
                .foregroundColor(.white)
                .scrollContentBackground(.hidden)

                Button {
                    allAlert()
                } label: {
                    Text("Register")
                        .padding()
                        .background(Color(red: 188/255, green: 150/255, blue: 92/255))
                        .foregroundColor(.white)
                        .font(.title3)
                        .frame(width: 150, height: 100)
                }
                .alert(alertTitle, isPresented: $showAlert) {
                    Button("OK") {}
                } message: {
                    Text("")
                }
            }
        }
    }
    
    // alert 的判斷式
    func allAlert() {
        if email.isEmpty {
            alertTitle = "信箱 不能為空白"
            showAlert = true
        }else if name.isEmpty {
            alertTitle = "用戶名 不能為空白"
            showAlert = true
        }else if password.isEmpty {
            alertTitle = "密碼 不能為空白"
            showAlert = true
        }else if copassword.isEmpty {
            alertTitle = "確認密碼 不能為空白"
            showAlert = true
        }else if password != copassword {
            alertTitle = "密碼與確認密碼 不符合"
            showAlert = true
        }else {
            // 若該有的都有後，即可建立密碼
            Auth.auth().createUser(withEmail: email, password: password) {result, error in
                guard let user = result?.user,
                    error == nil else {
                    // 讓錯誤訊息，顯示到 alert 上
                    if let message = error?.localizedDescription {
                        alertTitle = message
                        showAlert = true
                    }
                    return
                }
                alertTitle = "建立成功"
                showAlert = true
            }
        }
    }
    
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
