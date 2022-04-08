// swift-tools-version:5.5

import PackageDescription

var dependencies: [Package.Dependency] = []
var targetDependencies: [Target.Dependency] = []

#if os(Linux)
dependencies.append(.package(url: "https://github.com/cx-org/CombineX", from: "0.4.0"))
targetDependencies.append("CombineX")
#endif

let package = Package(
	name: "AsyncExtensions",
	platforms: [
		.iOS(.v13),
		.macOS(.v10_15),
		.watchOS(.v6),
		.tvOS(.v13)
	],
	products: [
		.library(
			name: "AsyncExtensions",
			targets: ["AsyncExtensions"]
		)
	],
	dependencies: dependencies,
	targets: [
		.target(
			name: "AsyncExtensions",
			dependencies: targetDependencies
		),
		.testTarget(
			name: "AsyncExtensionsTests",
			dependencies: ["AsyncExtensions"]
		)
	]
)
