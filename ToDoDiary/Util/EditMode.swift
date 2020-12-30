//
//  EditMode.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/30.
//

import SwiftUI
extension EditMode {
    mutating func toggle() {
        self = self == .active ? .inactive : .active
    }
}
