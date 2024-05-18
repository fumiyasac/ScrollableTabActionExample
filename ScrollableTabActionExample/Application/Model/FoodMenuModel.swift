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
        case fish = "🐟魚料理"
        case meat = "🥩肉料理"
        case noodle = "🍜麺類"
        case rice = "🌾米"
        case vegetable = "🥦野菜料理"
        case dessert = "🍨デザート"
        case bread = "🍞パン"
        case seaweed = "🌊海藻"
        case soup = "🍲スープ"
    }
}
