//
//  PostViewModel.swift
//  Post
//
//  Created by Roopesh Tripathi on 29/04/24.
//

import Foundation
import Combine

class PostViewModel: ObservableObject {
    @Published var posts: [Post] = []
    var currentPage = 1
    var isLoading = false
    
    private let networkManager: NetworkProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(networkManager: NetworkProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func fetchPosts() {
        guard !isLoading else { return }
        isLoading = true
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts?_page=\(currentPage)")!
        
        networkManager.fetchData(from: url)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] (fetchedPosts: [Post]) in
                self?.posts += fetchedPosts
                self?.isLoading = false
            })
            .store(in: &cancellables)
    }
}
