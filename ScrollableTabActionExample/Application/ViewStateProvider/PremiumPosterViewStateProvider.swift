//
//  PremiumPosterViewStateProvider.swift
//  ScrollableTabActionExample
//
//  Created by 酒井文也 on 2024/05/09.
//

import Foundation
import Observation

// MARK: - Protocol

protocol PremiumPosterViewStateProvider {
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    var premiumPosterModels: [PremiumPosterModel] { get }
    func fetchPremiumPosters()
}

// MARK: - Protocol

@Observable
public final class PremiumPosterViewStateProviderImpl: PremiumPosterViewStateProvider {

    // MARK: - Property (Dependency)

    private let premiumPosterRepository: PremiumPosterRepository

    // MARK: - Property (Computed)

    private var _isLoading: Bool = false
    private var _errorMessage: String?
    private var _premiumPosterModels: [PremiumPosterModel] = []

    // MARK: - Property (`@Observable`)

    var isLoading: Bool {
        _isLoading
    }

    var errorMessage: String? {
        _errorMessage
    }

    var premiumPosterModels: [PremiumPosterModel] {
        _premiumPosterModels
    }

    // MARK: - Initializer

    init(premiumPosterRepository: PremiumPosterRepository = PremiumPosterRepositoryImpl()) {
        self.premiumPosterRepository = premiumPosterRepository
    }

    // MARK: - Function

    func fetchPremiumPosters() {
        Task { @MainActor in
            do {
                _premiumPosterModels = try await premiumPosterRepository.getAll()
            } catch let error {
                print(error)
            }
        }
    }
}
