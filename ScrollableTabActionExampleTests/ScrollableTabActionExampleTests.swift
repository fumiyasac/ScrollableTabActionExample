//
//  ScrollableTabActionExampleTests.swift
//  ScrollableTabActionExampleTests
//
//  Created by 酒井文也 on 2024/06/06.
//

import XCTest
import Testing

final class ScrollableTabActionExampleTests: XCTestCase {

    // MARK: - Function

    func testAll() async {
        await XCTestScaffold.runAllTests(hostedBy: self)
    }
}
