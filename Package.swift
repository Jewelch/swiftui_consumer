// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftUI_Consumer",
    
    platforms: [
        .iOS(.v15),
        .macOS(.v14),
        .tvOS(.v13),
        .watchOS(.v6),
    ],
    
    products: [
        .library(
            name: "SwiftUI_Consumer",
            targets: ["SwiftUI_Consumer"]),
    ],
    
    dependencies: [
        .package(url: "https://github.com/Jewelch/swiftui_infrastructure.git", branch: "main")
    ],
 
    targets: [
        .target(
            name: "SwiftUI_Consumer",
            dependencies: [
                .product(name: "SwiftUI_Infrastructure", package: "swiftui_infrastructure")
            ])
      
    ]
)
