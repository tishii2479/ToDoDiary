//
//  SimpleDateField.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/23.
//

import SwiftUI

struct SimpleDateField: View {
    @State var startDate: Date = Date()
        
    var body: some View {
        VStack(spacing: 0) {
            // 日にち
            ZStack {
                // 背景
                SimpleCellBackground()
                
                // タイトル
                SimpleCellTitle(title: "日にち")
            }
            
            SimpleDivider()
            
            // 開始時刻
            ZStack {
                // 背景
                SimpleCellBackground()
                
                // タイトル
                SimpleCellTitle(title: "開始時刻")
                
                
            }
            
            SimpleDivider()
            
            // 終了時刻
            ZStack {
                // 背景
                SimpleCellBackground()
                
                // タイトル
                SimpleCellTitle(title: "終了時刻")
            }
        }
    }
}

struct SimpleDateField_Previews: PreviewProvider {
    static var previews: some View {
        SimpleDateField()
    }
}
