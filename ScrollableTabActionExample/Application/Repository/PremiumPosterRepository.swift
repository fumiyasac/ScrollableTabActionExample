//
//  PremiumPosterRepository.swift
//  ScrollableTabActionExample
//
//  Created by 酒井文也 on 2024/06/20.
//

import Foundation

protocol PremiumPosterRepository {
    func getAll() async throws -> [PremiumPosterModel]
}

final class PremiumPosterRepositoryImpl: PremiumPosterRepository {

    // MARK: - Function

    func getAll() async throws -> [PremiumPosterModel] {
        try await ApiClientManager.shared.getAllPremiumPoster()
    }
}
