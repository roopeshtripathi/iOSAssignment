//
//  DetailView.swift
//  Post
//
//  Created by Roopesh Tripathi on 29/04/24.
//

import SwiftUI

struct DetailView: View {
    let post: Post
    
    var body: some View {
        VStack {
            Text("\(post.id): \(post.title)")
                .font(.title)
                .padding()
            Spacer()
        }
        .navigationTitle("Post Detail")
    }
}
