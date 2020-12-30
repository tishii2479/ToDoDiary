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
                    // 日付
                    Text(CalendarManager.shared.formatFullDate(date: calendar.getDateFromIndex(index: calendar.selectedIndex)))
                        .foregroundColor(ColorManager.character)
                        .font(Font.custom(FontManager.number, size: 14))
                    
                    Spacer()
                    
                    // 作成ボタン
                    Button(action: {
                        viewSwitcher.showModal(selectedDate: calendar.getDateFromIndex(index: calendar.selectedIndex))
                    }) {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 10, height: 10)
                            .foregroundColor(ColorManager.image)
                    }
                    
                    // 閉じるボタン
                    Button(action: {
                        calendar.isShowingDetail = false
                    }) {
                        Image(systemName: "multiply")
                            .resizable()
                            .frame(width: 10, height: 10)
                            .foregroundColor(ColorManager.image)
                    }
                }
                .padding(.horizontal, 10)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 40)
                .background(ColorManager.main)
                
                ScrollView {
                    VStack (spacing: 0) {
                        if calendar.selectedEventArray.count > 0 {
                            ForEach(0 ..< calendar.selectedEventArray.count, id: \.self) { index in
                                // 削除のチェック
                                if calendar.selectedEventArray[index].isInvalidated == false {
                                    Button(action: {
                                        // Set target event to selected event
                                        viewSwitcher.showModal(targetEvent: calendar.selectedEventArray[index])
                                    }) {
                                        DetailEventLabel(event: calendar.selectedEventArray[index])
                                    }
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
