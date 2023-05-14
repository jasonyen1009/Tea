//
//  TeaApp.swift
//  Tea
//
//  Created by Yen Hung Cheng on 2023/5/14.
//

import SwiftUI
import Firebase
import FirebaseAuth

@main
struct TeaApp: App {
    
    @StateObject var data = AllTea()

    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            // 判斷是否已經登入過了
            // 判斷帳號是否登入過，登入過的話，就自動填寫 信箱欄位
            if Auth.auth().currentUser != nil  {
                AppView()
                    .environmentObject(data)
            }else {
                ContentView()
                    .environmentObject(data)
            }
        }
    }
}
