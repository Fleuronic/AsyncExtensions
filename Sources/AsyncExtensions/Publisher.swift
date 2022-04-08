// Copyright © Fleuronic LLC. All rights reserved.

#if canImport(Combine)
import Combine
#elseif canImport(CombineX)
import CombineX
#endif

public extension Publisher {
	var values: AsyncThrowingMapSequence<AsyncStream<Result<Output, Failure>>, Output> {
		results.map {
			try $0.get()
		}
	}

	var singleValue: Output {
		get async throws {
			try await singleResult.get()
		}
	}

	var results: AsyncStream<Result<Output, Failure>> {
		var cancellable: AnyCancellable?

		return .init { continuation in
			cancellable = handleEvents(
				receiveCancel: {
					cancellable?.cancel()
				}
			).sink { completion in
				if case let .failure(error) = completion {
					continuation.yield(.failure(error))
				}
				continuation.finish()
			} receiveValue: { value in
				continuation.yield(.success(value))
			}
		}
	}

	var singleResult: Result<Output, Failure> {
		get async {
			var cancellable: AnyCancellable?

			return await withCheckedContinuation { continuation in
				cancellable = handleEvents(
					receiveCancel: {
						cancellable?.cancel()
					}
				).sink { completion in
					if case let .failure(error) = completion {
						continuation.resume(returning: .failure(error))
					}
				} receiveValue: { value in
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
					continuation.resume(returning: completion)
					cancellable?.cancel()
				} receiveValue: { _ in }
			}
		}
	}
}

public extension Publisher where Failure == Never {
	var values: AsyncStream<Output> {
		var cancellable: AnyCancellable?

		return .init { continuation in
			cancellable = handleEvents(
				receiveCancel: {
					cancellable?.cancel()
				}
			).sink { completion in
				continuation.finish()
			} receiveValue: { value in
				continuation.yield(value)
			}
		}
	}

	var singleValue: Output {
		get async {
			var cancellable: AnyCancellable?

			return await withCheckedContinuation { continuation in
				cancellable = sink { value in
					continuation.resume(returning: value)
					cancellable?.cancel()
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
					continuation.resume(returning: ())
					cancellable?.cancel()
				} receiveValue: { _ in }
			}
		}
	}
}
