//
//  DateFormatter.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/26.
//

import Foundation

extension DateFormatter {
    static func format(date _date: Date?, format: String) -> String {
        guard let date = _date else { return "" }
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
        formatter.dateFormat = format
        
        return formatter.string(from: date)
    }
}
