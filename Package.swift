// swift-tools-version:5.5
// Copyright © Fleuronic LLC. All rights reserved.

import PackageDescription

#if os(Linux)
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
	dependencies: [
		.package(url: "https://github.com/cx-org/CombineX", from: "0.4.0")
	],
	targets: [
		.target(
			name: "AsyncExtensions",
			dependencies: ["CombineX"]
		),
		.testTarget(
			name: "AsyncExtensionsTests",
			dependencies: ["AsyncExtensions"]
		)
	]
)
#else
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
	targets: [
		.target(
			name: "AsyncExtensions",
			dependencies: []
		),
		.testTarget(
			name: "AsyncExtensionsTests",
			dependencies: ["AsyncExtensions"]
		)
	]
)
#endif
