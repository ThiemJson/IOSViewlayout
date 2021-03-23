//
//  LoginService.swift
//  layoutapp
//
//  Created by Thiem Jason on 3/24/21.
//

import Foundation

class LoginService {
    static func login(username: String, password: String, completion: @escaping (String) -> ()){
        let delay = DispatchTimeInterval.milliseconds(3000)
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            completion(UUID().description)
        }
    }
    
    static func checkToken(completion: @escaping (Bool)->()) {
        let delay = DispatchTimeInterval.milliseconds(3000)
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            guard let _ = UserDefaults.standard.string(forKey: "token") else {
                return completion(false)
            }
            completion(true)
        }
    }
    
    static func loggout()-> Void {
        deleteToken();
    }
    
    static func setToken(token: String){
        UserDefaults.standard.set(token, forKey: "token")
    }
    
    static func getToken()-> String {
        guard let token = UserDefaults.standard.string(forKey: "token") else {
            return ""
        }
        return token
    }
    
    static func deleteToken(){
        UserDefaults.standard.removeObject(forKey: "token")
    }
}
