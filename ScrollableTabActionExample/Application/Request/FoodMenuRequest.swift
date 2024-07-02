//
//  FoodMenuRequest.swift
//  ScrollableTabActionExample
//
//  Created by 酒井文也 on 2024/06/21.
//

import Foundation

protocol FoodMenuRequest {
    func getAll() async throws -> [FoodMenuModel]
}

final class FoodMenuRequestImpl: FoodMenuRequest {

    // MARK: - Function

    func getAll() async throws -> [FoodMenuModel] {
        []
    }
}
