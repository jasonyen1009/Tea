//
//  OrderRowView.swift
//  Tea
//
//  Created by Yen Hung Cheng on 2023/5/14.
//

import SwiftUI

struct OrderRowView: View {
    
    @EnvironmentObject var data: AllTea
    
    @Binding var order: Tea
    
    @State var selectedSize = "M"
    
    
    let size = ["M", "L"]
    
    @Binding var sugerDefault: String
    @Binding var iceDefault: String

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
                        } label: {
                            Text(option)
                        }
                    }
                } label: {
                    Label {
                        Text("甜度：\(sugerDefault)")
                    } icon: {}
                }
                .foregroundColor(.blue)

                Menu {
                    ForEach(冰度, id: \.self) { option in
                        Button {
                            iceDefault = option
                            order.ice = option
                        } label: {
                            Text(option)
                        }
                    }
                } label: {
                    Label {
                        Text("冰度：\(iceDefault)")
                    } icon: {}
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
                                // 必須呼叫 cal 不然總金額會無法更新
                                data.cal()

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
    
}

struct OrderRowView_Previews: PreviewProvider {
    static var previews: some View {
        OrderRowView(order: .constant(Tea(name: "熟成紅茶", description: "", Mprice: 50, Lprice: 50)), sugerDefault: .constant("正常糖"), iceDefault: .constant("正常冰"))
            .environmentObject(AllTea())
        
    }
}
