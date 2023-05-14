//
//  Tea.swift
//  Tea
//
//  Created by Yen Hung Cheng on 2023/5/14.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class AllTea: ObservableObject {
    
    // 所有的品項
    @Published var allTea = [Tea]()
    
    // 我的訂單
    @Published var orders = [Tea]()
    // firebase 上的訂單
    @Published var firebaseOrders = [Tea]()

    // 用來計算 orders 中的訂單金額
    @Published var total = 0
    
    // 計算訂單中的所有金額
    func cal() {
        total = 0
        for i in orders.indices {
            total += orders[i].price
        }
    }
    
    // 清除下單的訂單
    func removeOrder() {
        orders.removeAll()
        total = 0
    }
    
    // 更新所有 tea 的資料
    func createTea(tea: Tea) {
        let db = Firestore.firestore()
        do {
            try db.collection("tea").document("\(tea.name)").setData(from: tea)
        } catch {
            print(error)
        }
    }
    
    // 更新我的最愛 tea 資料
    func updateFavoriate() {
        for tea in allTea {
            createTea(tea: tea)
        }
    }
    
    // 修改 order 的資料
    func modifyOrder(tea: Tea, id: String) {
        let db = Firestore.firestore()
        do {
            try db.collection("order").document(id).setData(from: tea)
            print("success")
        } catch {
            print(error)
        }
    }
    
    // 修改 favorite 的資料
    func modifyFavorite(tea: Tea, id: String) {
        let db = Firestore.firestore()
        do {
            try db.collection("tea").document(id).setData(from: tea)
            print("success")
        } catch {
            print(error)
        }
    }
    
    
    // 將遠端資料與本地資料進行同步
    func updateLocalData(localData: inout [Tea], remoteData: [Tea]) {
        for remoteTea in remoteData {
            if let index = localData.firstIndex(where: { $0.name == remoteTea.name }) {
                localData[index].isFavorite = remoteTea.isFavorite
            }
        }
    }
    
    
}

// 對應資料庫飲料的格式
struct Tea: Codable, Identifiable {
    let name: String
    let description: String
    var Mprice: Int
    var Lprice: Int
    var isFavorite: Bool = false
    var comment: String = ""
    @DocumentID var id: String?
    
    // 飲料細項
    var size: String = "M"
    var ice: String = "正常冰"
    var suger: String = "正常糖"
    var price: Int = 0
    
}

// 對應期間限定的資料格式
struct Drink: Codable, Identifiable {
    @DocumentID var id: String?
    var image: String
}
