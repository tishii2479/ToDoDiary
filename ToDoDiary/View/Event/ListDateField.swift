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
    @EnvironmentObject var createEvent: EventViewModel
    
    var body: some View {
        ZStack {
            // 背景
            Rectangle()
                .fill(ColorManager.back)
            
            HStack {
                Button(action: {
                    createEvent.prevMonth()
                }) {
                    Text("prev")
                }
            
                VStack {
                    // タイトル
                    Text(createEvent.calendarTitle())
                        .foregroundColor(ColorManager.character)
                        .font(Font.custom(FontManager.japanese, size: 20))
                        .bold()
                 
                    // 曜日のバー
                    DayBar()
                    
                    // カレンダー
                    // TODO: 範囲を変更
                    ForEach(0..<6) { y in
                        HStack {
                            ForEach(0..<7) { x in
                                // 表示されている年月の範囲内であれば表示する
                                if createEvent.isTargetDate(date: createEvent.getDateForDateSelecter(index: index(x, y))) {
                                    // ボタン
                                    Button(action: {
                                        createEvent.selectDate(index: index(x, y))
                                        createEvent.selectedIndexes[index(x, y)].toggle()
                                    }) {
                                        ZStack {
                                            // 枠線
                                            Circle()
                                                .fill(ColorManager.border)
                                                .frame(minWidth: 32, minHeight: 32)
                                            
                                            // 背景
                                            Circle()
                                                // 選択されて入れば色を変える
                                                .fill(createEvent.selectedIndexes[index(x, y)] ? ColorManager.character : ColorManager.main)
                                                .frame(minWidth: 30, minHeight: 30)
                                                .padding(1)
                                            
                                            // 文字
                                            Text(DateFormatter.format(date: createEvent.getDateForDateSelecter(index: index(x, y)), format: "d"))
                                                .foregroundColor(createEvent.selectedIndexes[index(x, y)] ? ColorManager.main : ColorManager.character)
                                                .font(Font.custom(FontManager.japanese, size: 12))
                                        }
                                    }
                                } else {
                                    Circle()
                                        .fill(Color.clear)
                                        .frame(minWidth: 32, minHeight: 32)
                                }
                            }
                        }
                    }
                }
                
                Button(action: {
                    createEvent.nextMonth()
                }) {
                    Text("next")
                }
            }
            .padding(.vertical, 10)
            .onAppear {
                createEvent.offset = createEvent.getOffsetForDateSelecter()
            }
        }
    }
    
    private func index(_ x: Int, _ y: Int) -> Int {
        return x + y * 7
    }
}

struct ListDateField: View {
    @EnvironmentObject var createEvent: EventViewModel
    
    // どのプルダウンを見せているか
    @State fileprivate var nowOpen: DateFieldType = .none
    
    var body: some View {
        VStack(spacing: 0) {
            
            // 日にち
            Group {
                Button(action: {
                    toggleOpen(type: .date)
                }) {
                    ZStack {
                        // 背景
                        ListCellBackground()
                        
                        // タイトル
                        ListCellTitle(title: "日にち")
                        
                        // 値
                        ListCellValue(value: createEvent.formatSelectedDates())
                    }
                }
                
                // プルダウン            
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
                        toggleOpen(type: .start)
                    }) {
                        ZStack {
                            // 背景
                            ListCellBackground()
                            
                            // タイトル
                            ListCellTitle(title: "開始時刻")
                            
                            // 値
                            ListCellValue(value: DateFormatter.format(date: createEvent.startTime, format: "h:mm"))
                        }
                    }
                    
                    // プルダウン
                    if nowOpen == .start {
                        ListDivider()
                        
                        TimeSelecter(title: "開始時刻", time: $createEvent.rawStartTime)
                    }
                }
            }
            
            ListDivider()
            
            // 終了時刻
            Group {
                VStack(spacing: 0) {
                    Button(action: {
                        toggleOpen(type: .end)
                    }) {
                        ZStack {
                            // 背景
                            ListCellBackground()
                            
                            // タイトル
                            ListCellTitle(title: "終了時刻")
                            
                            // 値
                            ListCellValue(value: DateFormatter.format(date: createEvent.endTime, format: "h:mm"))
                        }
                    }
                    
                    // プルダウン
                    if nowOpen == .end {
                        ListDivider()
                        
                        TimeSelecter(title: "終了時刻", time: $createEvent.rawEndTime)
                    }
                }
            }
        }
    }
    
    private func toggleOpen(type: DateFieldType) {
        if nowOpen == type {
            nowOpen = .none
        } else {
            nowOpen = type
        }
    }
}

struct ListDateField_Previews: PreviewProvider {
    static var previews: some View {
        ListDateField()
            .colorScheme(.dark)
    }
}
