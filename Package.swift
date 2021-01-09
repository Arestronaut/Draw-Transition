// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "DrawTransition", 
    platforms: [.iOS(v14)], 
    products: [
        .library(name: "DrawTransition", targets: "DrawTransition")
    ], 
    dependencies: [],
    targets: [
        .target(
            name: "DrawTransition", 
            dependencies: [], 
            path: "DrawTransition"
        )
    ]
)