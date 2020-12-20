//
//  CalendarViewModel.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/20.
//

import Foundation
import SwiftUI

class CalendarViewModel: ObservableObject {
    
    @Published var firstIndex: Int = -98
    @Published var lastIndex: Int = 98
    @Published var zeroIndex: Int = 0
    
    
    // スクロールカウント
    // 無限スクロールに使う、上下に何回更新されたかを保持する
    // 上に更新されたら-1、下に更新されたら+1
    // 更新された分、日付をずらす処理をgetDateFromIndexで行う
    var scrollCount: Int = 0
    
    func checkOffset(offset: CGFloat) {
        if offset < 100 {
            print("[debug] top")
        }
    }
}
