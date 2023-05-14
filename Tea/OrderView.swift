//
//  OrderView.swift
//  Tea
//
//  Created by Yen Hung Cheng on 2023/5/14.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct OrderView: View {
    
    
    @EnvironmentObject var data: AllTea
    @State private var showAlert = false
    @State private var alertTitle = ""
    
    
        
    var body: some View {
        ZStack() {
            // 背景底色
            Color(red: 0, green: 62/255, blue: 82/255)
                .ignoresSafeArea()
            
            VStack {
                ScrollView {
                    VStack(spacing: 40) {
                        ForEach(data.orders.indices, id: \.self) { item in
                            OrderRowView(order: $data.orders[item], sugerDefault: $data.orders[item].suger, iceDefault: $data.orders[item].ice)
                        }
                    }
                }
                .background(.white)
                .cornerRadius(15)
                .padding()
                VStack {
                    Text("總金額 : \(data.total)$")
                        .font(.title)
                        .foregroundColor(.white)
                }
                // 訂單按鈕
                Button {
                    // 判斷是否有訂單存在
                    if data.orders.isEmpty {
                        alertTitle = "您的購物車是空的"
                    }
                    showAlert = true
                    // 新增訂單
                    for tea in data.orders {
                        createOrder(tea: tea)
                        alertTitle = "已完成下單，若要更改訂單請點選右下角 ..."
                    }
                    data.removeOrder()
                } label: {
                    Text("下單")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color(red: 188/255, green: 150/255, blue: 92/255))
                        .cornerRadius(20)
                }
                .alert(alertTitle, isPresented: $showAlert) {
                    Button("OK") {}
                } message: {
                    Text("")
                }
            }
        }
        
    }
    
    // 產生訂單到 firestore
    func createOrder(tea: Tea) {
        let db = Firestore.firestore()
        do {
            let documentReference = try db.collection("order").addDocument(from: tea)
                    print(documentReference.documentID)
        } catch {
            print(error)
        }
    }
    
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView()
            .environmentObject(AllTea())
    }
}
