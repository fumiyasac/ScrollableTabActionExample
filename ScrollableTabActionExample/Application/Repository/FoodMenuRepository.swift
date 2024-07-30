//
//  FoodMenuRepository.swift
//  ScrollableTabActionExample
//
//  Created by 酒井文也 on 2024/06/20.
//

import Foundation

protocol FoodMenuRepository {
    func getAll() async throws -> [FoodMenuModel]
}

final class FoodMenuRepositoryImpl: FoodMenuRepository {

    // MARK: - Function

    func getAll() async throws -> [FoodMenuModel] {
        []
    }
}
