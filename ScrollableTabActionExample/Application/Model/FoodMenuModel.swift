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

        case fish
        case meat
        case noodle
        case rice
        case vegetable
        case dessert
        case bread
        case seaweed
        case soup

        var title: String {
            switch self {
            case .fish: return "🐟魚料理"
            case .meat: return "🥩肉料理"
            case .noodle: return "🍝麺類"
            case .rice: return "🌾米"
            case .vegetable: return "🥦野菜料理"
            case .dessert: return "🍨デザート"
            case .bread: return "🍞パン"
            case .seaweed: return "🌊海藻"
            case .soup: return "🍲スープ"
            }
        }

        var tabID: String {
            return self.rawValue
        }
    }

    enum FoodMenuDish: String, CaseIterable {
        case mainDish = "main_dish"
        case subDish = "sub_dish"
        case stapleFood = "staple_food"
        case soup = "soup"
        case sweets = "sweets"

        var title: String {
            switch self {
            case .mainDish: return "主菜"
            case .subDish: return "副菜"
            case .stapleFood: return "主食"
            case .soup: return "汁物"
            case .sweets: return "甘味"
            }
        }
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
        self.category = FoodMenuModel.FoodMenuCategeory(rawValue: try container.decode(String.self, forKey: .category)) ?? .fish
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
