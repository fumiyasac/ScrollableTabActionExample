//
//  PremiumPosterThumbnailView.swift
//  ScrollableTabActionExample
//
//  Created by 酒井文也 on 2024/05/17.
//

import SwiftUI

struct PremiumPosterThumbnailView: View {

    // MARK: - Property

    private var premiumPosterModel: PremiumPosterModel

    // MARK: - Initializer

    init(premiumPosterModel: PremiumPosterModel) {
        self.premiumPosterModel = premiumPosterModel
    }

    // MARK: - Body

    var body: some View {
        ZStack {
            Image(premiumPosterModel.posterIdentifier)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipped()
            Rectangle()
                .foregroundColor(.black.opacity(0.48))
        }
    }
}

// MARK: - Preview

#Preview {
    PremiumPosterThumbnailView(
        premiumPosterModel: PremiumPosterModel(
            id: 1,
            tab: "プレミアムディナーNo.1",
            title: "イタリアンをベースとした本格的なコースをお楽しみ下さい！",
            subTitle: "海の幸・山の幸をバランス良く取り入れた合計8品ラインナップ。ワインと一緒に特別な時間を過ごしてみて下さい。",
            price: 8000,
            posterIdentifier: "premium_dinner_1"
        )
    )
}
