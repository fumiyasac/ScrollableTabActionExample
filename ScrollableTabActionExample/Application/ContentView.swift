//
//  ContentView.swift
//  ScrollableTabActionExample
//
//  Created by 酒井文也 on 2024/05/08.
//

import SwiftUI

struct ContentView: View {

    // MARK: - Body

    var body: some View {
        ZStack {
            TabView {
                // PremiumPosterScreenコンテンツ画面
                PremiumPosterScreen()
                    .tabItem {
                        VStack {
                            Image(systemName: "book.circle.fill")
                            Text("Premium Poster")
                        }
                    }
                    .tag(0)
                // FoodMenuScreenコンテンツ画面
                FoodMenuScreen()
                    .tabItem {
                        VStack {
                            Image(systemName: "fork.knife.circle.fill")
                            Text("Food Menu")
                        }
                    }
                    .tag(1)
            }
            .accentColor(Color(uiColor: UIColor(code: "#e5c40d")))
        }
    }
}

#Preview {
    ContentView()
}
