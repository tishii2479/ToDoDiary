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
            DayBar()
            
            ScrollViewReader { (proxy: ScrollViewProxy) in
                ZStack {
                    ColorManager.calendarBorder
                    
                ScrollView {
                    LazyVGrid(columns: Array(repeating: GridItem(.adaptive(minimum: 50, maximum: 300)), count: 7), spacing: 0) {
//                        LazyVGrid(columns: Array(repeating: GridItem(.adaptive(minimum: 50, maximum: 300)), count: 7), spacing: 1) {
                            ForEach((calendarViewModel.firstIndex...calendarViewModel.lastIndex), id: \.self) { index in
                                CalendarCell(index: index).id(index)
                            }
                        }
                    }
                    .background(GeometryReader {
                        Color.clear.preference(key: ViewOffsetKey.self,
                        value: -$0.frame(in: .named("scroll")).origin.y)
                    })
                    .onPreferenceChange(ViewOffsetKey.self) {
                        calendarViewModel.checkOffset(offset: $0)
                    }
                }
                .coordinateSpace(name: "scroll")
                .onAppear {
                    proxy.scrollTo(0, anchor: .top)
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
