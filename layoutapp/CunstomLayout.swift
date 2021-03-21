//
//  CunstomLayout.swift
//  layoutapp
//
//  Created by Thiem Jason on 3/21/21.
//

import SwiftUI

struct CunstomLayout: View {
    @State private var posts: [Post] = []
    
    var body: some View {
        List(self.posts){
            post in
            Text(post.title)
                .padding()
                .foregroundColor(post.id % 2 == 0 ? .white : .black)
                .background(Color(post.id % 2 == 0 ?.gray : .blue))
                .cornerRadius(8)
        }
        .onAppear{
            Api().getPosts{
                (posts) in
                self.posts = posts
            }
        }
    }
}
