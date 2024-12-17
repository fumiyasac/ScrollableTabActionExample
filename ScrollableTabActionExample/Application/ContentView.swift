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
                //FoodMenuScreen()
                
                // 検証用に載せ替えてみる
                ExampleScreen()
                    .tabItem {
                        VStack {
                            Image(systemName: "fork.knife.circle.fill")
                            Text("Food Menu")
                        }
                    }
                    .tag(1)
            }
            .accentColor(Color(uiColor: UIColor(code: "#bf6301")))
        }
    }
}

#Preview {
    ContentView()
}
