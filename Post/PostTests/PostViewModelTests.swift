//
//  PostViewModelTests.swift
//  PostTests
//
//  Created by Roopesh Tripathi on 29/04/24.
//

import XCTest
import Combine
@testable import Post

class PostViewModelTests: XCTestCase {
    var viewModel: PostViewModel!
    var mockNetworkManager: MockNetworkManager!
    
    override func setUpWithError() throws {
        mockNetworkManager = MockNetworkManager()
        viewModel = PostViewModel(networkManager: mockNetworkManager)
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        mockNetworkManager = nil
    }
    
    func testFetchPostsSuccess() {
        // Given
        let expectedPosts = [Post(id: 1, title: "Title 1"),
                             Post(id: 2, title: "Title 2")]
        mockNetworkManager.stubbedData = expectedPosts
        
        // When
        viewModel.fetchPosts()
        
        // Then
        XCTAssertEqual(viewModel.posts, expectedPosts)
    }
    
    func testFetchPostsFailure() {
        // Given
        mockNetworkManager.stubbedError = URLError(.notConnectedToInternet)
        
        // When
        viewModel.fetchPosts()
        
        // Then
        XCTAssertTrue(viewModel.posts.isEmpty)
    }
}

class MockNetworkManager: NetworkProtocol {
    var stubbedData: [Post]?
    var stubbedError: Error?
    
    func fetchData<T>(from url: URL) -> AnyPublisher<T, Error> where T : Decodable {
        if let data = stubbedData as? T {
            return Just(data)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else if let error = stubbedError {
            return Fail(error: error)
                .eraseToAnyPublisher()
        } else {
            fatalError("You need to stub either data or error")
        }
    }
}
