// swift-tools-version: 5.9

import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "HeritageInits",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .tvOS(.v13),
        .watchOS(.v6),
        .macCatalyst(.v13)
    ],
    products: [
        .library(
            name: "HeritageInits",
            targets: ["HeritageInits"]
        ),
        .executable(
            name: "HeritageInitsClient",
            targets: ["HeritageInitsClient"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/apple/swift-syntax.git",
            "509.0.2"..<"509.1.0"
        ),
    ],
    targets: [
        .macro(
            name: "HeritageInitsMacros",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax")
            ]
        ),
        .target(
            name: "HeritageInits",
            dependencies: ["HeritageInitsMacros"]
        ),
        .executableTarget(
            name: "HeritageInitsClient",
            dependencies: ["HeritageInits"]
        ),
        .testTarget(
            name: "HeritageInitsTests",
            dependencies: [
                "HeritageInitsMacros",
                .product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax"),
            ]
        ),
    ]
)
