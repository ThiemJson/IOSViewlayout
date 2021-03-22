//
//  CombineService.swift
//  layoutapp
//
//  Created by Thiem Jason on 3/22/21.
//

import Foundation

struct CombineService {
    static let mockData = 1...10
    
    static func fetch(completion:  @escaping (Result<String, Error>) -> ()){
        CombineService.mockData.forEach { (value) in
            let delay = DispatchTimeInterval.seconds(value)
            print("Start queue: \(value) with time interval: \(delay)")
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                completion(Result.success("\(value)"))
            }
        }
    }
}
