// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "rxrouter",
    products: [
        .library(
            name: "RxRouter",
            targets: ["RxRouter"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift", .upToNextMinor(from: "6.2.0")),
    ],
    targets: [
        .target(
            name: "RxRouter",
            dependencies: ["RxSwift", "RxCocoa"]),
    ]
)
