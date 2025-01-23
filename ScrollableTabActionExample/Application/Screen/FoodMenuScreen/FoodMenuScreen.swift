//
//  FoodMenuScreen.swift
//  ScrollableTabActionExample
//
//  Created by 酒井文也 on 2025/01/23.
//

import SwiftUI

struct FoodMenuScreen: View {

    // MARK: - `@State` Property

    /// View Properties
    @State private var activeTab: ProductType = .iphone
    @Namespace private var animation
    @State private var productsBasedOnType: [[Product]] = []
    @State private var animationProgress: CGFloat = 0

    /// Optional
    @State private var scrollableTabOffset: CGFloat = 0
    @State private var initialOffset: CGFloat = 0

    // MARK: - Initializer

    init() {}

    // MARK: - Body

    var body: some View {
        NavigationStack {
            
            /// For Auto Scrolling Content's
            ScrollViewReader { proxy in
                ScrollView(.vertical, showsIndicators: false) {
                    /// Remove Comments, if you want to use LazyStack
                    /// Lazy Stack For Pinning View at Top While Scrolling
                    LazyVStack(spacing: 15, pinnedViews: [.sectionHeaders]) {
                        Section {
                            ForEach(productsBasedOnType, id: \.self) { products in
                                ProductSectionView(products)
                            }
                        } header: {
                            ScrollableTabs(proxy)
                        }
                    }
                    .getRectangleViewToCoordinateSpace("CONTENTVIEW") { rect in
                        scrollableTabOffset = rect.minY - initialOffset
                    }
                }
                .background(
                    Rectangle()
                        .fill(.white)
                )
            }
            /// For Scroll Content Offset Detection
            .coordinateSpace(name: "CONTENTVIEW")
            .navigationBarTitle("Apple Store")
            .navigationBarTitleDisplayMode(.inline)
            .background {
                Rectangle()
                    .fill(.white)
                    .ignoresSafeArea()
            }
            .onAppear {
                /// Filtering Products Based on Product Type (Only Once)
                guard productsBasedOnType.isEmpty else { return }
                
                for type in ProductType.allCases {
                    let products = products.filter { $0.type == type }
                    productsBasedOnType.append(products)
                }
            }
        }
    }

    // MARK: - `@ViewBuilder` Private Function

    /// Products Sectioned View
    @ViewBuilder
    func ProductSectionView(_ products: [Product]) -> some View {
        VStack(alignment: .leading, spacing: 15) {
            /// Safe Check
            if let firstProduct = products.first {
                Text(firstProduct.type.rawValue)
                    .font(.title)
                    .fontWeight(.semibold)
            }
            
            ForEach(products) { product in
                ProductRowView(product)
            }
        }
        .padding(15)
        /// - For Auto Scrolling VIA ScrollViewProxy
        .id(products.type)
        .getRectangleViewToCoordinateSpace("CONTENTVIEW") { rect in
            let minY = rect.minY
            /// When the Content Reaches it's top then updating the current active Tab
            if (minY < 30 && -minY < (rect.midY / 2) && activeTab != products.type) && animationProgress == 0 {
                withAnimation(.easeInOut(duration: 0.3)) {
                    /// Saftey Check
                    activeTab = (minY < 30 && -minY < (rect.midY / 2) && activeTab != products.type) ? products.type : activeTab
                }
            }
        }
    }

    /// Product Row View
    @ViewBuilder
    func ProductRowView(_ product: Product) -> some View {
        HStack(spacing: 15) {
            Image(product.productImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .padding(10)
                .background {
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(.white)
                }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(product.title)
                    .font(.title3)
                
                Text(product.subtitle)
                    .font(.callout)
                    .foregroundColor(.gray)
                
                Text(product.price)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(Color("Purple"))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    /// Scrollable Tabs
    @ViewBuilder
    func ScrollableTabs(_ proxy: ScrollViewProxy) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(ProductType.allCases, id: \.rawValue) { type in
                    Text(type.rawValue)
                        .fontWeight(.regular)
                        .font(.callout)
                        .foregroundColor(Color(uiColor: UIColor(code: "#bf6301")))
                        /// Active Tab Indicator
                        .background(alignment: .bottom, content: {
                            if activeTab == type {
                                Capsule()
                                    .fill(Color(uiColor: UIColor(code: "#bf6301")))
                                    .frame(height: 2)
                                    .padding(.horizontal, -2)
                                    .offset(y: 12)
                                    .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                            }
                        })
                        .padding(.horizontal, 12)
                        .contentShape(Rectangle())
                        /// Scrolling Tab's When ever the Active tab is Updated
                        .id(type.tabID)
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                activeTab = type
                                animationProgress = 1.0
                                /// Scrolling To the Selected Content
                                proxy.scrollTo(type, anchor: .topLeading)
                            }
                        }
                }
            }
            .padding(.vertical, 12)
            .onChange(of: activeTab) {
                withAnimation(.easeInOut(duration: 0.3)) {
                    proxy.scrollTo(activeTab.tabID, anchor: .center)
                }
            }
            .checkAnimationCompleted(for: animationProgress) {
                /// Reseting to Default, when the animation was finished
                animationProgress = 0.0
            }
        }
        .background(.white)
    }
}


#Preview {
    FoodMenuScreen()
}

/// Product Model & Sample Products
struct Product: Identifiable,Hashable {
    var id: UUID = UUID()
    var type: ProductType
    var title: String
    var subtitle: String
    var price: String
    var productImage: String = ""
}

enum ProductType: String,CaseIterable {
    case iphone = "iPhone"
    case ipad = "iPad"
    case macbook = "MacBook"
    case desktop = "Mac Desktop"
    case appleWatch = "Apple Watch"
    case airpods = "Airpods"
    
    var tabID: String {
        /// Creating Another UniqueID for Tab Scrolling
        return self.rawValue + self.rawValue.prefix(4)
    }
}

fileprivate var products: [Product] = [
    /// Apple Watch
    Product(type: .appleWatch, title: "Apple Watch", subtitle: "Ultra: Alphine Loop", price: "$999",productImage: "AppleWatchUltra"),
    Product(type: .appleWatch, title: "Apple Watch", subtitle: "Series 8: Black", price: "$599",productImage: "AppleWatch8"),
    Product(type: .appleWatch, title: "Apple Watch", subtitle: "Series 6: Red", price: "$359",productImage: "AppleWatch6"),
    Product(type: .appleWatch, title: "Apple Watch", subtitle: "Series 4: Black", price: "$250", productImage: "AppleWatch4"),
    /// iPhone's
    Product(type: .iphone, title: "iPhone 14 Pro Max", subtitle: "A16 - Purple", price: "$1299", productImage: "iPhone14"),
    Product(type: .iphone, title: "iPhone 13", subtitle: "A15 - Pink", price: "$699", productImage: "iPhone13"),
    Product(type: .iphone, title: "iPhone 12", subtitle: "A14 - Blue", price: "$599", productImage: "iPhone12"),
    Product(type: .iphone, title: "iPhone 11", subtitle: "A13 - Purple", price: "$499", productImage: "iPhone11"),
    Product(type: .iphone, title: "iPhone SE 2", subtitle: "A13 - White", price: "$399", productImage: "iPhoneSE"),
    /// MacBook's
    Product(type: .macbook, title: "MacBook Pro 16", subtitle: "M2 Max - Silver", price: "$2499", productImage: "MacBookPro16"),
    Product(type: .macbook, title: "MacBook Pro", subtitle: "M1 - Space Grey", price: "$1299", productImage: "MacBookPro"),
    Product(type: .macbook, title: "MacBook Air", subtitle: "M1 - Gold", price: "$999", productImage: "MacBookAir"),
    /// iPad's
    Product(type: .ipad, title: "iPad Pro", subtitle: "M1 - Silver", price: "$999", productImage: "iPadPro"),
    Product(type: .ipad, title: "iPad Air 4", subtitle: "A14 - Pink", price: "$699", productImage: "iPadAir"),
    Product(type: .ipad, title: "iPad Mini", subtitle: "A15 - Grey", price: "$599", productImage: "iPadMini"),
    /// Desktop's
    Product(type: .desktop, title: "Mac Studio", subtitle: "M1 Max - Silver", price: "$1999", productImage: "MacStudio"),
    Product(type: .desktop, title: "Mac Mini", subtitle: "M2 Pro - Space Gray", price: "$999", productImage: "MacMini"),
    Product(type: .desktop, title: "iMac", subtitle: "M1 - Purple", price: "$1599", productImage: "iMac"),
    /// Airpods
    Product(type: .airpods, title: "Airpods", subtitle: "Pro 2nd Gen", price: "$249",productImage: "AirpodsPro"),
    Product(type: .airpods, title: "Airpods", subtitle: "3rd Gen", price: "$179",productImage: "Airpods3"),
    Product(type: .airpods, title: "Airpods", subtitle: "2nd Gen", price: "$129",productImage: "Airpods2"),
]

fileprivate extension [Product] {
    /// Return the Array's First Product Type
    var type: ProductType {
        if let firstProduct = self.first {
            return firstProduct.type
        }
        
        return .iphone
    }
}
