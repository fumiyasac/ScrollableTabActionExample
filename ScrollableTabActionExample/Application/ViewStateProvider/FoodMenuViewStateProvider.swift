//
//  FoodMenuViewStateProvider.swift
//  ScrollableTabActionExample
//
//  Created by 酒井文也 on 2024/05/09.
//

import Foundation
import Observation

// MARK: - Protocol

protocol FoodMenuViewStateProvider {
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    var foodMenuModels: [[FoodMenuModel]] { get }
    func fetchFoodMenus()
}


@Observable
public final class FoodMenuViewStateProviderImpl: FoodMenuViewStateProvider {

    // MARK: - Property (Dependency)

    private let foodMenuRepository: FoodMenuRepository

    // MARK: - Property (Computed)

    private var _isLoading: Bool = false
    private var _errorMessage: String?
    private var _foodMenuModels: [[FoodMenuModel]] = []

    // MARK: - Property (`@Observable`)

    var isLoading: Bool {
        _isLoading
    }

    var errorMessage: String? {
        _errorMessage
    }
    
    var foodMenuModels: [[FoodMenuModel]] {
        _foodMenuModels
    }

    // MARK: - Initializer

    init(foodMenuRepository: FoodMenuRepository = FoodMenuRepositoryImpl()) {
        self.foodMenuRepository = foodMenuRepository
    }

    // MARK: - Function

    func fetchFoodMenus() {
        Task { @MainActor in
            do {
                let allFoodMenu = try await foodMenuRepository.getAll()
                for category in FoodMenuModel.FoodMenuCategeory.allCases {
                    let foodMenus = allFoodMenu.filter { $0.category == category }
                    _foodMenuModels.append(foodMenus)
                }
            } catch let error {
                print(error)
            }
        }
    }
}
