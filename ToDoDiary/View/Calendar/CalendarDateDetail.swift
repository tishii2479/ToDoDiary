//
//  CalendarDateDetail.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/20.
//

import SwiftUI

fileprivate struct DetailEventLabel: View {
    var event: Event
    
    var body: some View {
        HStack(spacing: 0) {
            Text(event.formatTime())
                .foregroundColor(ColorManager.character)
                .font(Font.custom(FontManager.number, size: 14))
                .frame(minWidth: 100, alignment: .trailing)
            
            event.color.color.frame(width: 1)
                .padding(.horizontal, 10)
            
            Text(event.title)
                .foregroundColor(ColorManager.character)
                .font(Font.custom(FontManager.japanese, size: 14))
            
            Spacer()
        }
        .padding(.vertical, 5)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 50, maxHeight: 50)
    }
}

struct CalendarDateDetail: View {
    @EnvironmentObject var viewSwitcher: ViewSwitcher
    @ObservedObject var calendar: CalendarViewModel
    let height: CGFloat = 150
    
    var body: some View {
        if calendar.isShowingDetail {
            VStack(spacing: 0) {
                Spacer()
                
                HStack {
                    Text(CalendarManager.shared.formatFullDate(date: CalendarManager.shared.getDateFromIndex(index: calendar.selectedIndex)))
                        .foregroundColor(ColorManager.character)
                        .font(Font.custom(FontManager.number, size: 14))
                    Spacer()
                    
                    Button("作成") {
                        // 選択状態のリセット
                        viewSwitcher.targetEvent = nil
                        viewSwitcher.selectedDate = CalendarManager.shared.getDateFromIndex(index: calendar.selectedIndex)
                        viewSwitcher.isShowingModal = true
                    }
                    
                    Button("閉じる") {
                        calendar.isShowingDetail = false
                    }
                }
                .padding(.horizontal, 10)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 40)
                .background(ColorManager.main)
                
                ScrollView {
                    VStack (spacing: 0) {
                        if calendar.selectedEventArray.count > 0 {
                            ForEach(0 ..< calendar.selectedEventArray.count, id: \.self) { index in
                                Button(action: {
                                    // Set target event to selected event
                                    viewSwitcher.targetEvent = calendar.selectedEventArray[index]
                                    viewSwitcher.selectedDate = nil
                                    viewSwitcher.isShowingModal = true
                                }) {
                                    DetailEventLabel(event: calendar.selectedEventArray[index])
                                }
                            }
                            
                            Spacer().frame(height: 20)
                        } else {
                            Text("まだ予定はありません")
                                .foregroundColor(ColorManager.character)
                                .font(Font.custom(FontManager.number, size: 14))
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: height, maxHeight: height)
                        }
                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: height, maxHeight: height)
                .background(ColorManager.back)
            }
        } else {
            EmptyView()
        }
    }
}

struct CalendarDateDetail_Previews: PreviewProvider {
    static var previews: some View {
        CalendarDateDetail(calendar: CalendarViewModel())
    }
}
