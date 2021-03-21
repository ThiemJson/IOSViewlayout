//
//  Post.swift
//  layoutapp
//
//  Created by Thiem Jason on 3/21/21.
//

import SwiftUI

struct Post: Codable, Identifiable{
    let id : Int
    let title: String
    let body: String
}

class Api {
    func getPosts(completion: @escaping ([Post]) -> ()){
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return  }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let posts = try! JSONDecoder().decode([Post].self, from: data!)
            DispatchQueue.main.async {
                completion(posts)
            }
        }.resume()
    }
}
