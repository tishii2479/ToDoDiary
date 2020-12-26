//
//  ViewSwitcher.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/20.
//

import Foundation
import SwiftUI

class ViewSwitcher: ObservableObject {
    @Published var currentView: ViewType = .calendar
    @Published var isShowingModal: Bool = false
    
    // 選択されたイベントの保持
    @Published var targetEvent: Event? = nil
    
    static var shared: ViewSwitcher!
}
