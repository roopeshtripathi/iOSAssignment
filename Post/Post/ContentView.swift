//
//  ContentView.swift
//  Post
//
//  Created by Roopesh Tripathi on 29/04/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = PostViewModel()
    
    var body: some View {
        NavigationStack {
            List(viewModel.posts) { post in
                NavigationLink(destination: DetailView(post: post)) {
                    Text("\(post.id): \(post.title)")
                }
                .task {
                    if self.viewModel.posts.last == post {
                        self.viewModel.currentPage += 1
                        self.viewModel.fetchPosts()
                    }
                }
            }
            .navigationTitle("Posts")
        }
        .onAppear {
            self.viewModel.fetchPosts()
        }
    }
}
