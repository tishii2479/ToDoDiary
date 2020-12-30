//
//  MonthlyView.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/16.
//

import SwiftUI

struct CalendarView: View {
    @EnvironmentObject var viewSwitcher: ViewSwitcher
    @EnvironmentObject var userSetting: UserSetting
    @ObservedObject var calendar: CalendarViewModel = CalendarViewModel.shared
    
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
                    ScrollView(showsIndicators: false) {
                        LazyVGrid(columns: Array(repeating: GridItem(.adaptive(minimum: 50, maximum: 300)), count: 7), spacing: 0) {
                            ForEach((0 ..< calendar.rowCount * 7), id: \.self) { index in
                                CalendarCell(date: calendar.getDateFromIndex(index: index), calendar: calendar).id(index)
                                    .onTapGesture(count: 1, perform: {
                                        calendar.selectIndex(index: index)
                                    })
                            }
                        }
                        .padding(.horizontal, 4)       // 表示がはみ出すのを防ぐ
                        
                        Color.clear
                            .frame(height: 200)         // TODO: 高さを計算する
                    }
                    
                    // 日時イベント詳細ウィンドウ
                    if calendar.isShowingDetail {
                        CalendarDateDetail(calendar: calendar)
                    }
                    
                    CreateEventButton()
                }
            }
            .gesture(
                DragGesture(minimumDistance: 100)
                    .onEnded { value in
                        if value.translation.width > 100 {
                            calendar.lastMonth()
                        }
                        else if value.translation.width < -100 {
                            calendar.nextMonth()
                        }
                    }
            )
            .onAppear {
                calendar.update()
            }
            .sheet(isPresented: $viewSwitcher.isShowingModal) {
                EventView()
                    .environmentObject(EventViewModel(content: .event))
                    .colorScheme(userSetting.colorTheme) // FIXME: これだけカラーが反映されない
            }
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
