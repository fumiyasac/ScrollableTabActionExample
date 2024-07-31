//
//  FoodMenuModel.swift
//  ScrollableTabActionExample
//
//  Created by 酒井文也 on 2024/05/18.
//

import Foundation

struct FoodMenuModel: Identifiable {

    // MARK: - Property

    let id: UUID = UUID()
    let foodID: Int
    let name: String
    let category: FoodMenuModel.FoodMenuCategeory
    let dish: String
    let subTitle: String
    let price: Int
    let kcal: Int
    let foodUrl: URL?

    // MARK: - Enum

    enum FoodMenuCategeory: String, CaseIterable {
        case fish = "🍛カレー"
        case steak = "🥩ステーキ"
        case chinese = "🍜中華料理"
        case pasta = "🍝パスタ"
        case sushi = "🍣お寿司"
        case western = "🍔洋食"
        case japanese = "🍲和食"
    }
}
