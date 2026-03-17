// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "DesignKit",
    platforms: [
        .iOS(.v18)
    ],
    products: [
        .library(
            name: "DesignKit",
            targets: ["DesignKit"]
        )
    ],
    targets: [
        .target(
            name: "DesignKit",
            path: "Sources/DesignKit",
            swiftSettings: [
                .defaultIsolation(MainActor.self),
                .swiftLanguageMode(.v6)
            ]
        ),
        .testTarget(
            name: "DesignKitTests",
            dependencies: ["DesignKit"],
            path: "Tests/DesignKitTests"
        )
    ]
)
