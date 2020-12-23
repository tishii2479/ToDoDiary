//
//  ListDateField.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/23.
//

import SwiftUI

struct ListDateField: View {
    @State var startDate: Date = Date()
        
    var body: some View {
        VStack(spacing: 0) {
            // 日にち
            ZStack {
                // 背景
                ListCellBackground()
                
                // タイトル
                ListCellTitle(title: "日にち")
            }
            
            ListDivider()
            
            // 開始時刻
            ZStack {
                // 背景
                ListCellBackground()
                
                // タイトル
                ListCellTitle(title: "開始時刻")
                
                
            }
            
            ListDivider()
            
            // 終了時刻
            ZStack {
                // 背景
                ListCellBackground()
                
                // タイトル
                ListCellTitle(title: "終了時刻")
            }
        }
    }
}

struct ListDateField_Previews: PreviewProvider {
    static var previews: some View {
        ListDateField()
    }
}
