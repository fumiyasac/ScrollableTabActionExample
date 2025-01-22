//
//  FoodMenuRowView.swift
//  ScrollableTabActionExample
//
//  Created by 酒井文也 on 2024/05/28.
//

import SDWebImageSwiftUI
import SwiftUI

struct FoodMenuRowView: View {

    // MARK: - Property

    private var foodMenuModel: FoodMenuModel

    // MARK: - Initializer

    init(foodMenuModel: FoodMenuModel) {
        self.foodMenuModel = foodMenuModel
    }

    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading, spacing: 0.0) {
            // メインの情報表示部分
            HStack(spacing: 0.0) {
                // 1. サムネイル画像表示
                AnimatedImage(
                    url: URL(string: foodMenuModel.thumbnail),
                    placeholder: {
                        // 参考: SDWebImageSwiftUIのVer3以降では.placeholderの表示位置が変更になりました。
                        // https://github.com/SDWebImage/SDWebImageSwiftUI/pull/275/files#diff-921c6d871c99a552fd985c2280175c9b9d9b1b165fc773a0865f278652f279ebL98
                        Rectangle()
                            .foregroundColor(.white)
                            .frame(width: 96.0, height: 72.0)
                    }
                )
                .resizable()
                .indicator(.activity)
                .scaledToFit()
                .transition(.fade(duration: 0.24))
                .frame(width: 96.0, height: 72.0)
                .cornerRadius(4.0)
                .padding(.trailing, 12.0)
                // 2. 文言表示
                VStack(alignment: .leading, spacing: 0.0) {
                    // 2-(1). 日付
                    Text(foodMenuModel.name)
                        .font(.caption)
                        .bold()
                        .foregroundColor(.primary)
                    // 2-(2). フィルター項目(カテゴリーや区分)
                    Text(foodMenuModel.dish.rawValue + " / " + foodMenuModel.category.rawValue)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding(.top, 4.0)
                    // 2-(3). タイトル
                    Text("カロリー: \(foodMenuModel.kcal) [kcal]" + "・" + "値段: \(foodMenuModel.price) [円]")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding(.top, 4.0)
                }
                // 3. 調整用Spacer
                Spacer()
            }
        }
        .padding(.horizontal, 8.0)
    }
}

// MARK: - Preview

#Preview {
    FoodMenuRowView(
        foodMenuModel: FoodMenuModel(
            id: 1,
            name: "アジフライ",
            category: "fish",
            dish: "main_dish",
            price: 360,
            kcal: 340,
            thumbnail: "https://student-cafeteria-application.s3.ap-northeast-1.amazonaws.com/1000000001.jpg"
        )
    )
}
