//
//  ReviseView.swift
//  Tea
//
//  Created by Yen Hung Cheng on 2023/5/14.
//

import SwiftUI

struct ReviseView: View {
    
    @EnvironmentObject var data: AllTea
    
    @State var order: Tea
    
    // 預設為 中杯尺寸
    @State var selectedSize = "M"
    let size = ["M", "L"]

    @State var sugerDefault = "正常糖"
    @State var iceDefault = "正常冰"

    //
    let 甜度 = [
        "無糖",
        "一分糖",
        "二分糖",
        "微糖",
        "半糖",
        "少糖",
        "正常糖"
    ]
    
    let 冰度 = [
        "熱",
        "溫",
        "常溫",
        "完全去冰",
        "去冰",
        "微冰",
        "少冰",
        "正常冰"
    ]
    
    
    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            Image("\(order.name)")
                .resizable()
                .scaledToFill()
                .frame(width: 150, height: 150)
                .clipped()
                .cornerRadius(10)
                .padding()
            
            VStack(alignment: .leading,spacing: 15) {
                Spacer()
                Text("\(order.name)")
                    .font(.title3)
                    .foregroundColor(.black)
                // 選單
                Menu {
                    ForEach(甜度, id: \.self) { option in
                        Button {
                            sugerDefault = option
                            order.suger = option
                            // 修改訂單
                            modify()
                        } label: {
                            Text(option)
                        }
                    }
                } label: {
                    Label {
                        Text("甜度：\(sugerDefault)")

                    } icon: {
                    }
                }
                .foregroundColor(.blue)

                Menu {
                    ForEach(冰度, id: \.self) { option in
                        Button {
                            iceDefault = option
                            order.ice = option
                            // 修改訂單
                            modify()
                        } label: {
                            Text(option)
                        }
                    }
                } label: {
                    Label {
                        Text("冰度：\(iceDefault)")
                    } icon: {
                    }
                }
                .foregroundColor(.blue)
                
                // 決定中杯大杯
                Picker(selection: $selectedSize) {
                                ForEach(size, id: \.self) { role in
                                    Text(role)
                                }
                    
                            } label: {
                                Text("")
                            }
                            .pickerStyle(.segmented)
                            .onChange(of: selectedSize) { newSize in
                                print("Selected size is now \(newSize)")
                                if newSize == "M" {
                                    order.price = order.Mprice
                                    order.size = "M"
                                }else {
                                    order.price = order.Lprice
                                    order.size = "L"
                                }
                                
                                // 修改 訂單
                                modify()
                            }
                
                
                Text("價錢：\(order.price)$")
                
                
            }
            .frame(height: 150)
            
            Spacer()

        }
        .onAppear {
            if order.price == order.Lprice {
                selectedSize = "L"
            }
        }
        
        
        
    }
    
    // 修改訂單
    func modify() {
        if let id = order.id {
            data.modifyOrder(tea: order, id: id)
        }else {
            print("error")
        }
    }
    
}

struct ReviseView_Previews: PreviewProvider {
    static var previews: some View {
        ReviseView(order: Tea(name: "熟成紅茶", description: "", Mprice: 50, Lprice: 50), sugerDefault: "正常糖", iceDefault: "正常冰")
            .environmentObject(AllTea())
        
    }
}
