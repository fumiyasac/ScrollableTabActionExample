//
//  PremiumPosterScreen.swift
//  ScrollableTabActionExample
//
//  Created by 酒井文也 on 2024/05/08.
//

import SwiftUI

struct PremiumPosterScreen: View {

    // MARK: - Body

    var body: some View {
        NavigationStack {
            Group {
                VStack {
                    Text("PremiumPosterScreen")
                }
            }
            // Navigation表示に関する設定
            .navigationTitle("Premium Poster")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    PremiumPosterScreen()
}
