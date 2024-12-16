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
    var userRepository: UserRepositoryImpl!
    var networkManagerStub: NetworkManagerStub!
    var store: Set<AnyCancellable>!

    override func setUp() {
        store = []
        let stubData = [
            UserModel(id: 1, name: "test name", username: "test username",
                      email: "test@email.com", phone: "test phone",
                      website: "test website", address: nil)
        ]

        let encodedData: Data
        do {
            encodedData = try JSONEncoder().encode(stubData)
        } catch {
            XCTFail("Failed to encode: \(error.localizedDescription)")
            return
        }

        let stubResponse: AnyPublisher<Data, APIError> = Just(encodedData)
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()

        networkManagerStub = NetworkManagerStub(mockResponse: stubResponse)
        userRepository = UserRepositoryImpl(networkManager: networkManagerStub)
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
                case .finished:
                    break
                case .failure(let error):
                    XCTFail("Expected success error: \(error)")
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
        let mockError = APIError.connectionError(message: "Test error")
        networkManagerStub = NetworkManagerStub(mockResponse: Fail<Data, APIError>(error: mockError).eraseToAnyPublisher())
        userRepository = UserRepositoryImpl(networkManager: networkManagerStub)

        let expectation = self.expectation(description: "Fetching users should fail.")

        // When
        userRepository.fetchUsers()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    XCTFail("Expected failure, but got success.")
                case .failure(let error):
                    // Then
                    XCTAssertEqual(error.localizedDescription, "The operation couldn’t be completed. (TechnicalTask_lvl1.APIError error 3.)")
                    expectation.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Expected failure, but received value.")
            })
            .store(in: &store)

        waitForExpectations(timeout: 2)
    }
}
