//
//  AppView.swift
//  Tea
//
//  Created by Yen Hung Cheng on 2023/5/14.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct AppView: View {
    
    @EnvironmentObject var data: AllTea

    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("", systemImage: "house")
                }
            FavoriteView()
                .tabItem {
                    Label("", systemImage: "heart")
                }
            OrderView()
                .tabItem {
                    Label("", systemImage: "bag")
                }
            MoreView()
                .tabItem {
                    Label("", systemImage: "ellipsis")
                }
        }
        .tabViewStyle(DefaultTabViewStyle())
        .accentColor(Color(red: 188/255, green: 150/255, blue: 92/255))
        .environmentObject(data)
        
        
        
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
            .environmentObject(AllTea())
    }
}
