// Copyright © Fleuronic LLC. All rights reserved.

#if swift(>=5.5)
#if swift(<5.5.2)
@available(iOS 15, macOS 12, watchOS 8, tvOS 15, *)
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
#else
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
#endif
#endif
