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
    let dish: FoodMenuModel.FoodMenuDish
    let price: Int
    let kcal: Int
    let thumbnail: String

    // MARK: - Enum

    enum FoodMenuCategeory: String, CaseIterable {
        case fish = "🐟魚料理"
        case meat = "🥩肉料理"
        case noodle = "🍝麺類"
        case rice = "🌾米"
        case vegetable = "🥦野菜料理"
        case dessert = "🍨デザート"
        case bread = "🍞パン"
        case seaweed = "🌊海藻"
        case soup = "🍲スープ"
    }

    enum FoodMenuDish: String, CaseIterable {
        case mainDish = "主菜"
        case subDish = "副菜"
        case stapleFood = "主食"
        case soup = "汁物"
        case sweets = "甘味"
    }

    // MARK: - Enum

    private enum Keys: String, CodingKey {
        case id
        case name
        case category = "categorySlug"
        case dish = "dishType"
        case price
        case kcal
        case thumbnail
    }

    // MARK: - Initializer

    init(
        id: Int,
        name: String,
        category: String,
        dish: String,
        price: Int,
        kcal: Int,
        thumbnail: String
    ) {
        self.id = id
        self.name = name
        self.category = FoodMenuModel.FoodMenuCategeory(rawValue: category) ?? .fish
        self.dish = FoodMenuModel.FoodMenuDish(rawValue: dish) ?? .mainDish
        self.price = price
        self.kcal = kcal
        self.thumbnail = thumbnail
    }

    init(from decoder: Decoder) throws {

        // JSONの配列内の要素を取得する
        let container = try decoder.container(keyedBy: Keys.self)

        // JSONの配列内の要素にある値をDecodeして初期化する
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.category = FoodMenuModel.FoodMenuCategeory(rawValue: try container.decode(String.self, forKey: .category)) ?? .meat
        self.dish = FoodMenuModel.FoodMenuDish(rawValue: try container.decode(String.self, forKey: .dish)) ?? .mainDish
        self.price = try container.decode(Int.self, forKey: .price)
        self.kcal = try container.decode(Int.self, forKey: .kcal)
        self.thumbnail = try container.decode(String.self, forKey: .thumbnail)
    }

    // MARK: - Hashable

    // MEMO: Hashableプロトコルに適合させるための処理
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: FoodMenuModel, rhs: FoodMenuModel) -> Bool {
        return lhs.id == rhs.id
    }
}
