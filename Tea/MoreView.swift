//
//  MoreView.swift
//  Tea
//
//  Created by Yen Hung Cheng on 2023/5/14.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

struct MoreView: View {
    
    @FirestoreQuery(collectionPath: "order") var teas: [Tea]
    @EnvironmentObject var data: AllTea
    @State var myorder : [Tea] = []
    
    @State var showLogin = false

    
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                // 背景底色
                // 確保底部的 TabView 背景顏色為 深色
                Color(red: 0, green: 62/255, blue: 82/255)
                    .ignoresSafeArea()
                    
                VStack {
                    // 確保在還沒抓取到資料時，背景顏色為 深色
                    if teas.isEmpty {
                        // 背景底色
                        Color(red: 0, green: 62/255, blue: 82/255)
                            .ignoresSafeArea()
                    }else {
                        List {
                            ForEach(teas) { tea in
                                NavigationLink {
                                    ReviseView(order: tea, sugerDefault: tea.suger, iceDefault: tea.ice)
                                } label: {
                                    HStack {
                                        Text(tea.size)
                                        Text(tea.name)
                                        Spacer()
                                        Text("\(tea.price)$")
                                    }
                                    .onAppear {
                                        myorder = teas
                                    }
                                }
                            }
                            .onDelete { indexSet in
                                myorder.remove(atOffsets: indexSet)
                                // 保存原本所有的 id
                                var or = [String]()
                                // 保存原本所有的 id
                                var ne = [String]()
                                
                                for i in teas.indices {
                                    or.append(teas[i].id!)
                                }
                                
                                for i in myorder.indices {
                                    ne.append(myorder[i].id!)
                                }

                                for i in miss(arrayA: or, arrayB: ne) {
                                    del(id: i)
                                }
                            }
                        }
                        .background(Color(red: 0, green: 62/255, blue: 82/255))
                        .scrollContentBackground(.hidden)
                    }
                    

                    // sign out button
                    Button {
                        do {
                            showLogin = true
                           try Auth.auth().signOut()
                        } catch {
                           print(error)
                        }
                    } label: {
                        Text("Sign out")
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color(red: 188/255, green: 150/255, blue: 92/255))
                    .cornerRadius(40)
                    .fullScreenCover(isPresented: $showLogin) {
                        ContentView()
                    }

                }

            }

        }
        
    }
    
    // 刪除資料
    func del(id: String) {
        let db = Firestore.firestore()
        let documentReference = db.collection("order").document(id)
        documentReference.delete()
    }
    
    // 找出被刪除的元素
    func miss(arrayA: [String], arrayB: [String]) -> Set<String> {
        let setA = Set(arrayA)
        let setB = Set(arrayB)
//        let missingElements = setA.subtracting(setB)
        return setA.subtracting(setB)
    }
    
    
}

struct MoreView_Previews: PreviewProvider {
    static var previews: some View {
        MoreView()
            .environmentObject(AllTea())

    }
}
