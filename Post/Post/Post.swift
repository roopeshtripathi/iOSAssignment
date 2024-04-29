//
//  Post.swift
//  Post
//
//  Created by Roopesh Tripathi on 29/04/24.
//

import Foundation

struct Post: Decodable, Identifiable, Equatable {
    let id: Int
    let title: String
}
