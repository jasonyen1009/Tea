//
//  HomeView.swift
//  Tea
//
//  Created by Yen Hung Cheng on 2023/5/14.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct HomeView: View {
    
//    @EnvironmentObject var data: AllTea
    @FirestoreQuery(collectionPath: "tea") var teas: [Tea]
    @FirestoreQuery(collectionPath: "drink") var images: [Drink]
    
    
    var body: some View {
        let columns = Array(repeating: GridItem(), count: 2)
        ZStack {
            // 背景底色
            Color(red: 0, green: 62/255, blue: 82/255)
                .ignoresSafeArea()
            VStack {
                Text("期間限定")
                    .font(.title3)
                    .foregroundColor(.white)
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(images) { image in
                            AsyncImage(url: URL(string: image.image)) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 180)
                            } placeholder: {}
                        }
                    }
                }
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(teas) { tea in
                            TeaView(isFill: tea.isFavorite,tea: tea)
                                .background(Color(red: 249/255, green: 249/255, blue: 249/255))
                                .cornerRadius(15)
                        }
                    }
                }
                // 加上 padding() 後，就不會反白
                .padding()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(AllTea())
    }
}
