//
//  UserRepositoryTest.swift
//  TechnicalTask-lvl1Tests
//
//  Created by Alexander Pavlovets on 16.12.24.
//

import XCTest
import Combine
@testable import TechnicalTask_lvl1

class UserRepositoryTests: XCTestCase {
    var userRepository: UserLocalRepositoryImplementation!
    var networkManagerStub: NetworkManagerStub!
    var store: Set<AnyCancellable>!

    private let stubData = [
        UserModel(id: 1, name: "test name", username: "test username",
                  email: "test@email.com", phone: "test phone",
                  website: "test website", address: nil)
    ]

    override func setUp() {
        store = []

        let encodedData: Data
        do {
            encodedData = try JSONEncoder().encode(stubData)
        } catch {
            XCTFail("Failed to encode: \(error.localizedDescription)")
            return
        }

        let stubResponse: AnyPublisher<Data, RequestError> = Just(encodedData)
            .setFailureType(to: RequestError.self)
            .eraseToAnyPublisher()

        networkManagerStub = NetworkManagerStub(mockResponse: stubResponse)
        userRepository = UserLocalRepositoryImplementation(networkManager: networkManagerStub)
    }

    override func tearDown() {
        networkManagerStub = nil
        userRepository = nil
        store = nil
    }

    func testFetchUsersSuccess() {
        // Given
        let expectation = self.expectation(description: "Fetching users should succeed.")

        // When
        userRepository.fetchUsers()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    XCTFail("Expected error: \(error)")
                }
            }, receiveValue: { users in
                // Then
                XCTAssertEqual(users.count, 1)
                XCTAssertEqual(users.first?.name, "test name")
                XCTAssertEqual(users.first?.email, "test@email.com")
                expectation.fulfill()
            })
            .store(in: &store)

        waitForExpectations(timeout: 1)
    }

    func testFetchUsersFailure() {
        // Given
        let mockError = RequestError.connectionError(message: "Test error")
        networkManagerStub = NetworkManagerStub(mockResponse: Fail<Data, RequestError>(error: mockError).eraseToAnyPublisher())
        userRepository = UserLocalRepositoryImplementation(networkManager: networkManagerStub)

        let expectation = self.expectation(description: "Fetching users should fail.")

        // When
        userRepository.fetchUsers()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    // Then
                    XCTAssertEqual(error.localizedDescription, "The operation couldn’t be completed. (TechnicalTask_lvl1.RequestError error 2.)")
                    expectation.fulfill()
                }
            }, receiveValue: { users in
                XCTFail("Expected failure, but received value.")
            })
            .store(in: &store)

        waitForExpectations(timeout: 2)
    }
}
