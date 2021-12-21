// Copyright © Fleuronic LLC. All rights reserved.

import Combine

#if swift(<5.5.2)
@available(iOS 15, macOS 12, watchOS 8, tvOS 15, *)
public extension Publisher {
	var singleValue: Output {
		get async throws {
			try await singleResult.get()
		}
	}

	var singleResult: Result<Output, Failure> {
		get async {
			var cancellable: AnyCancellable?

			return await withCheckedContinuation { continuation in
				cancellable = sink { completion in
					guard case let .failure(error) = completion else { return }
					continuation.resume(returning: .failure(error))
				} receiveValue: { value in
					cancellable?.cancel()
					continuation.resume(returning: .success(value))
				}
			}
		}
	}
}

@available(iOS 15, macOS 12, watchOS 8, tvOS 15, *)
public extension Publisher where Failure == Never {
	var singleValue: Output {
		get async {
			var cancellable: AnyCancellable?

			return await withCheckedContinuation { continuation in
				cancellable = sink { value in
					cancellable?.cancel()
					continuation.resume(returning: value)
				}
			}
		}
	}
}
#else
public extension Publisher {
	var singleValue: Output {
		get async throws {
			try await singleResult.get()
		}
	}

	var singleResult: Result<Output, Failure> {
		get async {
			var cancellable: AnyCancellable?

			return await withCheckedContinuation { continuation in
				cancellable = sink { completion in
					guard case let .failure(error) = completion else { return }
					continuation.resume(returning: .failure(error))
				} receiveValue: { value in
					cancellable?.cancel()
					continuation.resume(returning: .success(value))
				}
			}
		}
	}
}

public extension Publisher where Failure == Never {
	var singleValue: Output {
		get async {
			var cancellable: AnyCancellable?

			return await withCheckedContinuation { continuation in
				cancellable = sink { value in
					cancellable?.cancel()
					continuation.resume(returning: value)
				}
			}
		}
	}
}
#endif
