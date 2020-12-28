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
                .padding(.vertical, -10)   // paddingの打ち消し
        }
    }
}

fileprivate struct DateSelecter: View {
    @EnvironmentObject var createEvent: EventViewModel
    
    // TODO: 初期値
    @State var year: Int = 2020
    @State var month: Int = 12
    @State var offset: Int = 0
    @State var selectedIndexes: [Bool] = [Bool](repeating: false, count: 50)
    
    var body: some View {
        ZStack {
            // 背景
            Rectangle()
                .fill(ColorManager.back)
            
            HStack {
                Button(action: {
                    prevMonth()
                }) {
                    Text("prev")
                }
            
                VStack {
                    // タイトル
                    Text(calendarTitle())
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
                                if isTargetDate(date: getDateForDateSelecter(index: index(x, y))) {
                                    // ボタン
                                    Button(action: {
                                        selectDate(index: index(x, y))
                                        selectedIndexes[index(x, y)].toggle()
                                    }) {
                                        ZStack {
                                            // 枠線
                                            Circle()
                                                .fill(ColorManager.border)
                                                .frame(minWidth: 32, minHeight: 32)
                                            
                                            // 背景
                                            Circle()
                                                // 選択されて入れば色を変える
                                                .fill(selectedIndexes[index(x, y)] ? ColorManager.character : ColorManager.main)
                                                .frame(minWidth: 30, minHeight: 30)
                                                .padding(1)
                                            
                                            // 文字
                                            Text(DateFormatter.format(date: getDateForDateSelecter(index: index(x, y)), format: "d"))
                                                .foregroundColor(selectedIndexes[index(x, y)] ? ColorManager.main : ColorManager.character)
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
                    nextMonth()
                }) {
                    Text("next")
                }
            }
            .padding(.vertical, 10)
            .onAppear {
                offset = getOffsetForDateSelecter()
                update()
            }
        }
    }
    
    private func index(_ x: Int, _ y: Int) -> Int {
        return x + y * 7
    }
    
    // year and date
    private func calendarTitle() -> String {
        let components = DateComponents(calendar: Calendar(identifier: .gregorian), year: year, month: month)
        guard let date = components.date else {
            print("[Error] GetDateFromIndex Failed")
            return ""
        }
        
        return DateFormatter.format(date: date, format: "y/M")
    }
    
    // 日にち選択用に月の最初の曜日を取得する
    private func getOffsetForDateSelecter() -> Int {
        let components = DateComponents(calendar: Calendar(identifier: .gregorian), year: year, month: month, day: 0)
        guard let date = components.date else {
            print("[Error] GetDayOffset Failed")
            return 0
        }
        
        let comp = Calendar(identifier: .gregorian).dateComponents([.weekday], from: date)
        
        guard let offset: Int = comp.weekday else {
            print("[Error] GetDayOffset Failed")
            return 0
        }
        
        return (offset % 7) - 1
    }
    
    // 日にち選択用の日付取得
    private func getDateForDateSelecter(index: Int) -> Date {
        let components = DateComponents(calendar: Calendar(identifier: .gregorian), year: year, month: month, day: index - offset)
        guard let date = components.date else {
            print("[Error] GetDateFromIndex Failed")
            return Date()
        }
        
        return date
    }
    
    // 日付からindexを取得する
    private func getIndexForDateSelecter(date: Date) -> Int {
        let comp = Calendar(identifier: .gregorian).dateComponents([.day], from: date)
        
        guard let day = comp.day else {
            print("[error] component earn failed")
            return 0
        }
        
        return day + offset
    }
    
    // 日付を選択した時に呼ばれる
    // selectedDatesに日付を追加する
    // すでに含まれていたら削除する
    private func selectDate(index: Int) {
        let selectedDate: Date = getDateForDateSelecter(index: index)
        if createEvent.selectedDates.contains(selectedDate) {
            createEvent.selectedDates.remove(value: selectedDate)
        } else {
            createEvent.selectedDates.append(selectedDate)
        }
        
        // 選択された日付を昇順にソート
        // ISSUE: selectedDatesが増えてくると重いかも
        createEvent.selectedDates = createEvent.selectedDates.sorted(by: <)
    }
    
    // 選択している年、月が変わった時に呼ばれる
    private func update() {
        offset = getOffsetForDateSelecter()
        selectedIndexes = [Bool](repeating: false, count: 50)
        
        // 選択されている日は選択済みにする
        // ISSUE: selectedDatesが増えてくると重いかも
        for date in createEvent.selectedDates {
            let comp = Calendar(identifier: .gregorian).dateComponents([.year, .month], from: date)
            
            guard let _year = comp.year, let _month = comp.month else {
                print("[error] earn components failed")
                continue
            }
            
            if year == _year && month == _month {
                selectedIndexes[getIndexForDateSelecter(date: date)] = true
            }
        }
    }
    
    // 前の月
    private func prevMonth() {
        month -= 1
    
        if month == 0 {
            // 去年へ
            year -= 1
            month = 12
        }
        update()
    }
    
    // 次の月
    private func nextMonth() {
        month += 1
        if month == 13 {
            // 来年へ
            year += 1
            month = 1
        }
        
        update()
    }
    
    // ISSUE: 重いかも
    // 対象の日付が表示すべきかを返す
    private func isTargetDate(date: Date) -> Bool {
        let comp = Calendar(identifier: .gregorian).dateComponents([.year, .month], from: date)
        guard let _year = comp.year, let _month = comp.month else {
            print("[error] earn components failed")
            return false
        }
        
        if year == _year && month == _month {
            return true
        } else {
            return false
        }
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
    }
}
