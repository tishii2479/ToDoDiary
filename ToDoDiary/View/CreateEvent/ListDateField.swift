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
    var title: String
    @Binding var time: Date
    
    var body: some View {
        ZStack {
            // 背景
            Rectangle()
                .fill(ColorManager.back)
                .frame(height: 200)
            
            // TODO: 間隔を変える
            // https://d1v1b.com/swiftui/datepicker
            DatePicker(title, selection: $time, displayedComponents: .hourAndMinute)
                .datePickerStyle(WheelDatePickerStyle())
                .labelsHidden()
                .padding(-10)   // paddingの打ち消し
        }
    }
}

fileprivate struct DateSelecter: View {
    @ObservedObject var dateSelecter: DateSelecterDirector
    @EnvironmentObject var createEvent: CreateEventViewModel
    
    var body: some View {
        ZStack {
            // 背景
            Rectangle()
                .fill(ColorManager.back)
                .frame(height: 300)
            
            HStack {
                Button(action: {
                    dateSelecter.prevMonth()
                }) {
                    Text("prev")
                }
            
                VStack {
                    // タイトル
                    Text(dateSelecter.title())
                        .foregroundColor(ColorManager.character)
                        .font(Font.custom(FontManager.japanese, size: 20))
                        .bold()
                    
                    // カレンダー
                    ForEach(0..<5) { y in
                        HStack {
                            ForEach(0..<7) { x in
                                // ボタン
                                Button(action: {
                                    dateSelecter.selectDate(index: index(x, y))
                                    dateSelecter.selectedIndexes[index(x, y)].toggle()
                                    createEvent.selectedDates = dateSelecter.selectedDates
                                }) {
                                    ZStack {
                                        // 枠線
                                        Circle()
                                            .fill(ColorManager.border)
                                            .frame(width: 32, height: 32)
                                        
                                        // 背景
                                        Circle()
                                            .fill(dateSelecter.selectedIndexes[index(x, y)] ? ColorManager.character : ColorManager.main)
                                            .frame(width: 30, height: 30)
                                            .padding(1)
                                        
                                        // 文字
                                        Text(dateSelecter.formatDay(date: dateSelecter.getDateForDateSelecter(index: index(x, y))))
                                            .foregroundColor(dateSelecter.selectedIndexes[index(x, y)] ? ColorManager.main : ColorManager.character)
                                            .font(Font.custom(FontManager.japanese, size: 12))
                                    }
                                }
                            }
                        }
                    }
                }
                
                Button(action: {
                    dateSelecter.nextMonth()
                }) {
                    Text("next")
                }
            }
            // TODO: 月が変わった時に都度呼び出す
            .onAppear {
                dateSelecter.update()
            }
        }
    }
    
    private func index(_ x: Int, _ y: Int) -> Int {
        return x + y * 7
    }
}

struct ListDateField: View {
    @EnvironmentObject var createEvent: CreateEventViewModel
    @ObservedObject var dateSelecter = DateSelecterDirector()
    @State var startTime: Date = Date()
    @State var endTime: Date = Date()
    
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
                        
                        // 値
                        ListCellValue(value: dateSelecter.formatSelectedDates())
                    }
                }
                
                // プルダウン
                if nowOpen == .date {
                    ListDivider()
                    
                    DateSelecter(dateSelecter: dateSelecter)
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
                            
                            // 値
                            ListCellValue(value: CalendarManager.shared.formatTime(date: startTime))
                        }
                    }
                    
                    // プルダウン
                    if nowOpen == .start {
                        ListDivider()
                        
                        TimeSelecter(title: "開始時刻", time: $startTime)
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
                            
                            // 値
                            ListCellValue(value: CalendarManager.shared.formatTime(date: endTime))
                        }
                    }
                    
                    // プルダウン
                    if nowOpen == .end {
                        ListDivider()
                        
                        TimeSelecter(title: "終了時刻", time: $endTime)
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
