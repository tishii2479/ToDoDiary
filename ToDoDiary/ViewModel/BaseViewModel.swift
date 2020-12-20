//
//  BaseViewModel.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/20.
//

import Foundation
import SwiftUI

class BaseViewModel: ObservableObject {
    @Published var isShowingModal: Bool = false
}
