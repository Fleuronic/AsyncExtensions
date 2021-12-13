// swift-tools-version:5.3
// Copyright © Fleuronic LLC. All rights reserved.

import PackageDescription

#if swift(>=5.5)
let package = Package(
	name: "AsyncOptional",
	platforms: [
		.iOS(.v13),
		.macOS(.v11),
		.watchOS(.v6),
		.tvOS(.v13)
	],
	products: [
		.library(
			name: "AsyncOptional",
			targets: ["AsyncOptional"]
		)
	],
	targets: [
		.target(
			name: "AsyncOptional",
			dependencies: []
		),
		.testTarget(
			name: "AsyncOptionalTests",
			dependencies: ["AsyncOptional"]
		)
	]
)
#else
let package = Package(
	name: "AsyncOptional",
	platforms: [
		.iOS(.v13),
		.macOS(.v11),
		.watchOS(.v6),
		.tvOS(.v13)
	],
	products: [
		.library(
			name: "AsyncOptional",
			targets: ["AsyncOptional"]
		)
	],
	targets: [
		.target(
			name: "AsyncOptional",
			dependencies: []
		)
	]
)
#endif
