// Copyright © Fleuronic LLC. All rights reserved.

public extension Optional {
	func asyncMap<U>(_ transform: (Wrapped) async throws -> U) async rethrows -> U? {
		guard let wrapped = self else { return nil }

		return try await transform(wrapped)
	}

	func asyncFlatMap<U>(_ transform: (Wrapped) async throws -> U?) async rethrows -> U? {
		guard let wrapped = self else { return nil }

		return try await transform(wrapped)
	}
}
