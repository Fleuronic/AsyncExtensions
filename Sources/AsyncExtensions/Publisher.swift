// Copyright © Fleuronic LLC. All rights reserved.

#if canImport(Combine)
import Combine
#else
import CombineX
#endif

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
public extension Publisher where Output == Never {
	var completion: Subscribers.Completion<Failure> {
		get async {
			var cancellable: AnyCancellable?

			return await withCheckedContinuation { continuation in
				cancellable = sink { completion in
					cancellable?.cancel()
					continuation.resume(returning: completion)
				} receiveValue: { _ in }
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

@available(iOS 15, macOS 12, watchOS 8, tvOS 15, *)
public extension Publisher where Output == Never, Failure == Never {
	var completion: Void {
		get async {
			var cancellable: AnyCancellable?

			return await withCheckedContinuation { continuation in
				cancellable = sink { completion in
					cancellable?.cancel()
					continuation.resume(returning: ())
				} receiveValue: { _ in }
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

public extension Publisher where Output == Never {
	var completion: Subscribers.Completion<Failure> {
		get async {
			var cancellable: AnyCancellable?

			return await withCheckedContinuation { continuation in
				cancellable = sink { completion in
					cancellable?.cancel()
					continuation.resume(returning: completion)
				} receiveValue: { _ in }
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

public extension Publisher where Output == Never, Failure == Never {
	var completion: Void {
		get async {
			var cancellable: AnyCancellable?

			return await withCheckedContinuation { continuation in
				cancellable = sink { completion in
					cancellable?.cancel()
					continuation.resume(returning: ())
				} receiveValue: { _ in }
			}
		}
	}
}
#endif
