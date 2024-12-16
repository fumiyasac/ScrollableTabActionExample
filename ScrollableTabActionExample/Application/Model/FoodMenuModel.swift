//
//  FoodMenuModel.swift
//  ScrollableTabActionExample
//
//  Created by 酒井文也 on 2024/05/18.
//

import Foundation

struct FoodMenuModel: Hashable, Decodable {

    // MARK: - Property

    let id: Int
    let name: String
    let category: FoodMenuModel.FoodMenuCategeory
    let dish: String
    let price: Int
    let kcal: Int
    let foodUrl: String

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

    // MARK: - Enum

    private enum Keys: String, CodingKey {
        case id
        case name
        case category
        case dish
        case price
        case kcal
        case foodUrl = "food_url"
    }

    // MARK: - Initializer

    init(
        id: Int,
        name: String,
        category: String,
        dish: String,
        price: Int,
        kcal: Int,
        foodUrl: String
    ) {
        self.id = id
        self.name = name
        self.category = FoodMenuModel.FoodMenuCategeory(rawValue: category) ?? .sushi
        self.dish = dish
        self.price = price
        self.kcal = kcal
        self.foodUrl = foodUrl
    }

    init(from decoder: Decoder) throws {

        // JSONの配列内の要素を取得する
        let container = try decoder.container(keyedBy: Keys.self)

        // JSONの配列内の要素にある値をDecodeして初期化する
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.category = FoodMenuModel.FoodMenuCategeory(rawValue: try container.decode(String.self, forKey: .category)) ?? .sushi
        self.dish = try container.decode(String.self, forKey: .dish)
        self.price = try container.decode(Int.self, forKey: .price)
        self.kcal = try container.decode(Int.self, forKey: .kcal)
        self.foodUrl = try container.decode(String.self, forKey: .foodUrl)
    }
}
