// swift-tools-version:5.5
// Copyright © Fleuronic LLC. All rights reserved.

import PackageDescription

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
