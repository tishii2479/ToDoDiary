//
//  MonthlyView.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/16.
//

import SwiftUI

struct CalendarView: View {
    
    @ObservedObject var calendarViewModel: CalendarViewModel = CalendarViewModel()
    
    var body: some View {
        VStack {
            
            // 曜日表示のバー
            DayBar()
            
            // カレンダー
            ScrollViewReader { (proxy: ScrollViewProxy) in
                ZStack {
                    // 背景色
                    ColorManager.calendarBorder
                    
                    // カレンダーコンテンツ
                    ScrollView {
                        LazyVGrid(columns: Array(repeating: GridItem(.adaptive(minimum: 50, maximum: 300)), count: 7), spacing: 0) {
                            ForEach((-98 ... 97), id: \.self) { index in
                                Button(action: {
                                    calendarViewModel.selectIndex(index: index)
                                }) {
                                    CalendarCell(index: index).id(index)
                                }
                            }
                        }
                        .padding(.horizontal, 4)       // 表示がはみ出すのを防ぐ
                    }
                    
                    // 日時イベント詳細ウィンドウ
                    if calendarViewModel.isShowingDetail {
                        CalendarDateDetail(calendarViewModel: calendarViewModel)
                    }
                    
                    Button("To today") {
                        withAnimation {
                            proxy.scrollTo(0, anchor: .top)
                        }
                    }
                    
                    CreateEventButton()
                }
            }
        }
    }
}

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
