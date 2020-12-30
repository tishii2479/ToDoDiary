//
//  UIApplication.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/30.
//

import SwiftUI

extension UIApplication {
    func closeKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
