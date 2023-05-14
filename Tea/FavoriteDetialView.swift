//
//  FavoriteDetialView.swift
//  Tea
//
//  Created by Yen Hung Cheng on 2023/5/14.
//

import SwiftUI

struct FavoriteDetialView: View {
    @EnvironmentObject var data: AllTea
    @State private var comment = ""
    
    @State var tea: Tea
    var body: some View {
        
        ZStack {
            // 背景底色
            Color(red: 0, green: 62/255, blue: 82/255)
                .ignoresSafeArea()
            
            VStack {
                Image("\(tea.name)")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 400, height: 300)
                    .clipped()
                
                Text("介紹")
                    .font(.title2)
                    .foregroundColor(Color(red: 188/255, green: 150/255, blue: 92/255))
                Text("\(tea.description)")
                    .padding()
                    .foregroundColor(.white)
                
                TextField("Comment", text: $comment)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                
                Button {
                    tea.comment = comment
                    modify(tea: tea)
                } label: {
                    Text("完成評論")
                        .foregroundColor(Color(red: 188/255, green: 150/255, blue: 92/255))
                }
                    
                Spacer()
            }
        }
        .navigationTitle("\(tea.name)")
        
        
        
        
    }
    
    // 更新資料庫中的 評價
    func modify(tea: Tea) {
        if let id = tea.id {
            data.modifyFavorite(tea: tea, id: id)
        }else {
            print("error")
        }
    }
    
}

struct FavoriteDetialView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteDetialView(tea: Tea(name: "冷露檸果", description: "將整顆新鮮檸檬的酸爽清香，浸入古法熬煮的冬瓜，以果香勾勒甘醇，沁入喉間之際，交織出別於以往的經典組合，令人一再回味。", Mprice: 55, Lprice: 65))
            .environmentObject(AllTea())
    }
}
