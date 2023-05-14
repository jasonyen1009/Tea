//
//  FavoriteRowView.swift
//  Tea
//
//  Created by Yen Hung Cheng on 2023/5/14.
//

import SwiftUI

struct FavoriteRowView: View {
    
    var tea: Tea
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            HStack(spacing: 20) {
                
                HStack(spacing: 20) {
                    Image("\(tea.name)")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 150)
                        .clipped()
                        .cornerRadius(10)
                    Spacer()
                    Text("\(tea.name)")
                        .font(.title2)
                        .foregroundColor(.black)
                    
                }
                .padding()

                Spacer()
            }
        }
        
        
    }
}

struct FavoriteRowView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteRowView(tea: Tea(name: "冷露檸果", description: "將整顆新鮮檸檬的酸爽清香，浸入古法熬煮的冬瓜，以果香勾勒甘醇，沁入喉間之際，交織出別於以往的經典組合，令人一再回味。", Mprice: 55, Lprice: 65))
    }
}
