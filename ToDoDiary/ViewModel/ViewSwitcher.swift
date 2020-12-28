//
//  ViewSwitcher.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/20.
//

import Foundation
import SwiftUI

class ViewSwitcher: ObservableObject {
    @Published var colorTheme: ColorScheme = .light
    @Published var currentView: ViewType = .calendar
    @Published var isShowingModal: Bool = false
    
    // 選択されたイベントの保持
    @Published var targetEvent: Event? = nil
    
    // 選択された日付の保持
    @Published var selectedDate: Date? = nil
    
    static var shared: ViewSwitcher!

    func showModal(targetEvent: Event? = nil, selectedDate: Date? = nil) {
        self.targetEvent = targetEvent
        self.selectedDate = selectedDate
        self.isShowingModal = true
    }
}
