//
//  ScrollableTabActionExampleApp.swift
//  ScrollableTabActionExample
//
//  Created by 酒井文也 on 2024/05/08.
//

import SwiftUI

@main
struct ScrollableTabActionExampleApp: App {

    // MEMO: AppDelegateでの適用できる形にするための定義
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    // MARK: - Body

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
