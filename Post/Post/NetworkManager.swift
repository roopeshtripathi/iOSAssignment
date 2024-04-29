//
//  NetworkManager.swift
//  Post
//
//  Created by Roopesh Tripathi on 29/04/24.
//

import Foundation
import Combine

protocol NetworkProtocol {
    func fetchData<T: Decodable>(from url: URL) -> AnyPublisher<T, Error>
}

class NetworkManager: NetworkProtocol {
    func fetchData<T: Decodable>(from url: URL) -> AnyPublisher<T, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
