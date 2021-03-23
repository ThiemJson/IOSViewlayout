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
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                if(value == 8){
                    completion(.failure(CombineServiceError.invalid))
                }
                else{
                    completion(Result.success("\(value)"))
                }
            }
        }
    }
    
    static func fetchModel(completion:  @escaping (Result<CombineTimeModel, Error>) -> ()){
        CombineService.mockData.forEach { (value) in
            let delay = DispatchTimeInterval.seconds(value)
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                completion(Result.success(CombineTimeModel(second: value)))
            }
        }
    }
    
    struct CombineServiceError {
        static let invalid = NSError(domain: "Number 8 is invalid", code: 1, userInfo: nil)
    }
    //    static func getSumOf(numbers: [Int] ,completion: (Int) -> Void) {
    //        // 2. Excute function.
    //        var sum = 0
    //        for aNumber in numbers {
    //            sum += aNumber
    //        }
    //        let delay = DispatchTimeInterval.milliseconds(5000)
    //        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
    //            completion(sum)
    //        }
    //    }
    //
    //    static func doSomething() {
    //        // 1. Gọi function, truyền closure vào làm tham số.
    //        getSumOf(numbers: [34, -34]) { result in
    //            print("Sum is \(result)")
    //            // 4. Closure được excute xong, return compiler và closure out of scope, bị giải phóng khỏi bộ nhớ.
    //        }
    //    }
}
