// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-spatial",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(name: "Spatial", targets: ["Spatial"]),
        .library(name: "Spatial Standard Library Integration", targets: ["Spatial Standard Library Integration"]),
        .library(name: "Spatial Foundation Library Integration", targets: ["Spatial Foundation Library Integration"]),
        .library(name: "Spatial Test Support", targets: ["Spatial Test Support"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-atoms/swift-tagged.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-numeric.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-scale.git",
            branch: "main"
        ),
    ],
    targets: [
        .target(
            name: "Spatial",
            dependencies: [
                .product(name: "Tagged", package: "swift-tagged"),
                .product(name: "Numeric", package: "swift-numeric"),
                .product(name: "Scale", package: "swift-scale"),
            ],
            path: "Sources/Spatial"
        ),
        .target(
            name: "Spatial Standard Library Integration",
            dependencies: [
                .target(name: "Spatial"),
            ],
            path: "Sources/Spatial Standard Library Integration"
        ),
        .target(
            name: "Spatial Foundation Library Integration",
            dependencies: [
                .target(name: "Spatial"),
                .target(name: "Spatial Standard Library Integration"),
            ],
            path: "Sources/Spatial Foundation Library Integration"
        ),
        .target(
            name: "Spatial Test Support",
            dependencies: [
                .target(name: "Spatial"),
            ],
            path: "Tests/Support"
        ),
        .testTarget(
            name: "Spatial Tests",
            dependencies: [
                .target(name: "Spatial"),
                .product(name: "Tagged", package: "swift-tagged"),
                .product(name: "Tagged Standard Library Integration", package: "swift-tagged"),
                .product(name: "Numeric", package: "swift-numeric"),
                .product(name: "Scale", package: "swift-scale"),
                .target(name: "Spatial Test Support"),
                .target(name: "Spatial Standard Library Integration"),
                .target(name: "Spatial Foundation Library Integration"),
            ],
            path: "Tests/Spatial Tests"
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets {
    target.swiftSettings = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]
}
