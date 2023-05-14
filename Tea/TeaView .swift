//
//  TeaView .swift
//  Tea
//
//  Created by Yen Hung Cheng on 2023/5/14.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct TeaView: View {
    
    // 愛心是否填滿
    @State var isFill = false
    @EnvironmentObject var data: AllTea
    @State var tea: Tea
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(tea.name)
                .resizable()
                .scaledToFill()
                .frame(width: 170, height: 160)
                .clipped()
                .cornerRadius(15)
            
            
            Text(tea.name)
                .font(.title2)
            
            HStack(spacing: 50) {
                Text("價格：\(tea.Mprice)$")
                
                // 下單一杯飲料
                Button {
                    // 將 price 設為 M 尺寸的價錢
                    tea.price = tea.Mprice
                    
                    // 加入到本地端的 tea 的 id 必須設為 nil
                    tea.id = nil
                    
                    data.orders.append(tea)
                    // 每次新增一筆訂單，就計算一次總金額
                    data.cal()
                    
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(Color(red: 188/255, green: 150/255, blue: 92/255))
                        .font(.title)
                }

            }
            
        }
        .overlay(alignment: .topLeading, content: {
            Button {
                isFill.toggle()
                tea.isFavorite.toggle()
                
                // 更新我的最愛
                modify(tea: tea)
            } label: {
                Image(systemName: isFill ? "heart.fill" : "heart")
                    .foregroundColor(.red)
                    .font(.title)
            }
        })
        
        
    }
    
    // 更新資料庫中的最愛名單
    func modify(tea: Tea) {
        if let id = tea.id {
            data.modifyFavorite(tea: tea, id: id)
        }else {
            print("error")
        }
    }

}

struct TeaView_Previews: PreviewProvider {
    static var previews: some View {
        TeaView(isFill: false, tea: Tea(name: "熟成紅茶", description: "木質帶熟果香調的風味，流露熟齡男子的沈穩氣息，低調而迷人。嚴選自斯里蘭卡產區之茶葉，帶有濃郁果香及醇厚桂圓香氣；與肉類料理一同品嚐，得以化解舌尖上所殘留的油膩感。", Mprice: 30, Lprice: 35))
            .environmentObject(AllTea())
    }
}
