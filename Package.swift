// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "email",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .library(name: "Email", targets: ["Email"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0")
    ],
    targets: [
        .target(name: "Email", dependencies: [
            .product(name: "Vapor", package: "vapor")
        ]),
        .testTarget(name: "EmailTests", dependencies: [
            .target(name: "Email"),
            .product(name: "XCTVapor", package: "vapor")
        ]),
    ]
)
