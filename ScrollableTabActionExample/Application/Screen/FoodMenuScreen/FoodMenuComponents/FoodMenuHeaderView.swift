//
//  FoodMenuHeaderView.swift
//  ScrollableTabActionExample
//
//  Created by 酒井文也 on 2024/06/22.
//

import SwiftUI

struct FoodMenuHeaderView: View {

    // MARK: - Property

    private var titleName: String

    // MARK: - Initializer

    init(titleName: String) {
        self.titleName = titleName
    }

    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(titleName)
                    .font(.title2)
                    .bold()
                    .foregroundColor(.primary)
                    .lineLimit(1)
                Spacer()
            }
            .padding(.top, 32.0)
            .padding(.horizontal, 8.0)
        }
    }
}

// MARK: - Preview

#Preview {
    FoodMenuHeaderView(titleName: "🐟魚料理")
}
