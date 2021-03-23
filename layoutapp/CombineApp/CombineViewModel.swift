//
//  CombineViewModel.swift
//  layoutapp
//
//  Created by Thiem Jason on 3/22/21.
//

import Foundation
import Combine

class CombineViewModel : ObservableObject {
    @Published var time: String = "0 seconds"
    var passhroughSubject = PassthroughSubject<String, Error>()
    private var cancellables : Set<AnyCancellable> = []
    
    init() {
        self.passhroughSubject.sink {
            (completion) in
            switch completion {
            case .finished:
                self.time = "Finished"
                break
            case .failure(let error):
                print(error.localizedDescription)
                self.time = error.localizedDescription
                break
            }
        } receiveValue: { (value) in
            self.time = value
        }.store(in: &cancellables)
    }
    
    // fetch data
    func startFetch(){
        CombineService.fetch { (result) in
            switch result {
            case .success(let value):
                if(Int(value) == 10){
                    self.passhroughSubject.send(completion: .finished)
                }
                else {
                    self.passhroughSubject.send(value)
                }
                break;
            case .failure(let error):
                print(error.localizedDescription)
                self.passhroughSubject.send(completion: .failure(error))
                break;
            }
        }
    }
}
