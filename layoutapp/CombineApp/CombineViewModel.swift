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
    @Published var seconds: String = "0"
    @Published var timeModel = CombineTimeModel(second: 0)
    var passthroughSubject = PassthroughSubject<String, Error>()
    var passthroughtCombineModelSubject = PassthroughSubject<CombineTimeModel, Error>()
    
    private var cancellables : Set<AnyCancellable> = []
    
    init() {
        self.passthroughSubject
            .dropFirst()
            .filter({ (value) -> Bool in
                return true
            })
            .map({ (value) in
                return value + " seconds"
            })
            .sink {
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
            }
            receiveValue: { (value) in
                self.time = value
            }
            .store(in: &cancellables)
        
        self.passthroughtCombineModelSubject.sink { (completion) in
            print("Completion: \(completion)")
        } receiveValue: { (combineTimeModel) in
            print("Completion: \(combineTimeModel.second)")
        }.store(in: &cancellables)


    }
    
    // fetch data
    func startFetch(){
        CombineService.fetch { (result) in
            switch result {
            case .success(let value):
                if(Int(value) == 10){
                    self.passthroughSubject.send(completion: .finished)
                }
                else {
                    self.passthroughSubject.send(value)
                }
                
                self.seconds = value
                break;
            case .failure(let error):
                print(error.localizedDescription)
                self.passthroughSubject.send(completion: .failure(error))
                self.seconds = error.localizedDescription
                break;
            }
        }
    }
    
    // fetch Data model
    func startFetchModel(){
        CombineService.fetchModel{ (timeModel) in
            switch timeModel{
            case .success(let dataTimeModel):
                self.passthroughtCombineModelSubject.send(dataTimeModel)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
