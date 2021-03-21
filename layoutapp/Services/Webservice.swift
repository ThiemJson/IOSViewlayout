//
//  Webservice.swift
//  layoutapp
//
//  Created by Thiem Jason on 3/21/21.
//

import Foundation

class Webservice {
    func getAllPosts(completion: @escaping ([Post]) -> () ) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            fatalError("URL is not correct")
        }
        
        let task = URLSession.shared.dataTask(with: url){
            data, _, _ in
            let posts = try! JSONDecoder().decode([Post].self, from: data!)
            DispatchQueue.main.async {
                completion(posts)
            }
            
        }
        task.resume()
    }
}
