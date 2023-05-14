//
//  ContentView.swift
//  Tea
//
//  Created by Yen Hung Cheng on 2023/5/14.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var alertTitle = ""
    @State private var showAlert = false
    @State var showBool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // 背景底色
                Color(red: 0, green: 62/255, blue: 82/255)
                    .ignoresSafeArea()
                VStack(spacing: 20) {
                    Spacer()
                    Image("可不可封面")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 400, height: 400)
                    TextField("Email", text: $email, prompt: Text("Email"))
                        .textFieldStyle(.roundedBorder)
                        .padding()
                    SecureField("Password", text: $password)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                    Spacer()
                    
                    HStack {
                        
                        Spacer()
                        
                        Button {
                            // 登入功能
                            login()
                        } label: {
                            Text(" Log in ")
                                .foregroundColor(.white)
                                .font(.title2)
                                .padding()
                                .border(Color(red: 188/255, green: 150/255, blue: 92/255), width: 4)
                                .frame(width: 150, height: 100)
                        }
                        .fullScreenCover(isPresented: $showBool) {
                            AppView()
                        }
                        .alert(alertTitle, isPresented: $showAlert) {
                            Button("OK") {}
                        } message: {
                            Text("")
                        }

                        

                        Spacer()
                        
                        NavigationLink {
                            SignUpView()
                        } label: {
                            Text("Sign Up")
                                .padding()
                                .background(Color(red: 188/255, green: 150/255, blue: 92/255))
                                .foregroundColor(.white)
                                .font(.title2)
                                .frame(width: 150, height: 100)
                        }
                        Spacer()
                    }
                }
            }
        }
    }
    // 判斷是否登入成功
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) {result, error in
            guard error == nil else {
                if let message = error?.localizedDescription {
                    alertTitle = message
                }
                showAlert = true
                return
            }
            alertTitle = "success"
            showBool = true
        }
    }
    
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
