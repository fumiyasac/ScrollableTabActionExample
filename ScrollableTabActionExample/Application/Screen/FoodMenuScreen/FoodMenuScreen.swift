//
//  FoodMenuScreen.swift
//  ScrollableTabActionExample
//
//  Created by 酒井文也 on 2024/05/08.
//

import SwiftUI

struct FoodMenuScreen: View {

    // MARK: - Body

    var body: some View {
        NavigationStack {
            Group {
                VStack {
                    Text("FoodMenuScreen")
                }
            }
            // Navigation表示に関する設定
            .navigationTitle("Food Menu")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// MARK: - Preview

#Preview {
    FoodMenuScreen()
}
