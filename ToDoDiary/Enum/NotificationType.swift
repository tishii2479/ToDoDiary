//
//  NotificationType.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/23.
//

import Foundation

enum NotificationType: Int {
    case none = 0
    case once = 1
    
    var text: String {
        get {
            switch self {
            case .none:
                return "通知なし"
            case .once:
                return "一度だけ"
            }
        }
    }
}
