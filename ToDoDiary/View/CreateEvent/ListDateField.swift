//
//  ListDateField.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/23.
//

import SwiftUI

fileprivate enum DateFieldType {
    case none
    case date
    case start
    case end
}

fileprivate struct TimeSelecter: View {
    @State private var departureDate = Date()
    
    var body: some View {
        ZStack {
            // 背景
            Rectangle()
                .fill(ColorManager.back)
                .frame(height: 200)
            
            DatePicker("出国日時", selection: $departureDate, displayedComponents: .hourAndMinute)
                .datePickerStyle(WheelDatePickerStyle())
                .labelsHidden()
                .padding(-10)   // paddingの打ち消し
        }
    }
}

fileprivate struct DateSelecter: View {
    var body: some View {
        ZStack {
            // 背景
            Rectangle()
                .fill(ColorManager.back)
                .frame(height: 300)
            
            VStack {
                Text("2020/1")
                    .foregroundColor(ColorManager.character)
                    .font(Font.custom(FontManager.japanese, size: 20))
                    .bold()
                
                ForEach(0..<5) { y in
                    HStack {
                        ForEach(0..<7) { x in
                            ZStack {
                                Circle()
                                    .fill(ColorManager.main)
                                    .frame(width: 40, height: 40)
                                    
                                Text("\(y * 7 + x)")
                                    .foregroundColor(ColorManager.character)
                                    .font(Font.custom(FontManager.japanese, size: 12))
                            }
                        }
                    }
                }
            }
        }
    }
}

struct ListDateField: View {
    @State var startDate: Date = Date()
    
    // どのプルダウンを見せているか
    @State fileprivate var nowOpen: DateFieldType = .none
    
    var body: some View {
        VStack(spacing: 0) {
            
            // 日にち
            Group {
                Button(action: {
                    nowOpen = .date
                }) {
                    ZStack {
                        // 背景
                        ListCellBackground()
                        
                        // タイトル
                        ListCellTitle(title: "日にち")
                    }
                }
                
                if nowOpen == .date {
                    ListDivider()
                    
                    DateSelecter()
                }
            }
            
            ListDivider()
            
            // 開始時刻
            Group {
                VStack(spacing: 0) {
                    Button(action: {
                        nowOpen = .start
                    }) {
                        ZStack {
                            // 背景
                            ListCellBackground()
                            
                            // タイトル
                            ListCellTitle(title: "開始時刻")
                        }
                    }
                    
                    if nowOpen == .start {
                        ListDivider()
                        
                        TimeSelecter()
                    }
                }
            }
            
            ListDivider()
            
            // 終了時刻
            Group {
                VStack(spacing: 0) {
                    Button(action: {
                        nowOpen = .end
                    }) {
                        ZStack {
                            // 背景
                            ListCellBackground()
                            
                            // タイトル
                            ListCellTitle(title: "終了時刻")
                        }
                    }
                 
                    if nowOpen == .end {
                        ListDivider()
                        
                        TimeSelecter()
                    }
                }
            }
        }
    }
}

struct ListDateField_Previews: PreviewProvider {
    static var previews: some View {
        ListDateField()
            .colorScheme(.dark)
    }
}
