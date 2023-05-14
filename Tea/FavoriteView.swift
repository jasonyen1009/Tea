//
//  FavoriteView.swift
//  Tea
//
//  Created by Yen Hung Cheng on 2023/5/14.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift


struct FavoriteView: View {
    
    @FirestoreQuery(collectionPath: "tea") var teas: [Tea]

    var body: some View {
        
        NavigationStack {
            ZStack {
                // 背景底色
                Color(red: 0, green: 62/255, blue: 82/255)
                    .ignoresSafeArea()

                ScrollView {
                    ForEach(teas) { tea in
                        // 判斷 tea 是否為最愛
                        if tea.isFavorite {
                            NavigationLink {
                                FavoriteDetialView(tea: tea)
                            } label: {
                                FavoriteRowView(tea: tea)
                            }
                        }
                    }
                }
                .background(.white)
                .cornerRadius(15)
                .padding()

            }
        }

        
    }
    
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
