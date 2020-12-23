//
//  EventColor.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/23.
//

import SwiftUI

enum EventColor: Int {
    case none = -1
    case gray = 0
    case red = 1
    case blue = 2
    case green = 3
    case yellow = 4
    case purple = 5
    case cyan = 6
    
    static let list: [EventColor] = [.gray, .red, .blue, .green, .yellow, .purple, .cyan]
    
    static func random() -> Int {
        return Int.random(in: 0...6)
    }
    
    func color() -> Color {
        switch self {
        case .gray:
            return ColorManager.eventGray
        case .red:
            return ColorManager.eventRed
        case .blue:
            return ColorManager.eventBlue
        case .green:
            return ColorManager.eventGreen
        case .yellow:
            return ColorManager.eventYellow
        case .purple:
            return ColorManager.eventPurple
        case .cyan:
            return ColorManager.eventCyan
        default:
            return Color.black
        }
    }
}
