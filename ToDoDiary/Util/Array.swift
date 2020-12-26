//
//  Array.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/26.
//

extension Array where Element: Equatable {
    mutating func remove(value: Element) {
        if let i = self.firstIndex(of: value) {
            self.remove(at: i)
        }
    }
}
