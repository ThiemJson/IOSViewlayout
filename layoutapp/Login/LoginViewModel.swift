//
//  LoginViewModel.swift
//  layoutapp
//
//  Created by Thiem Jason on 3/23/21.
//

import Foundation
import Combine

class LoginViewModel : ObservableObject {
    var passthroughLoginViewModel = PassthroughSubject<LoginModel, Error>()
    var passthroughAuthentication = PassthroughSubject<Authentication, Error>()
    var cancellables = Set<AnyCancellable>()
    @Published var authentication = Authentication.LoggedOut
    
    init() {
        self.passthroughLoginViewModel
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .sink { (loginThroughComplete) in
                // todo
            } receiveValue: { (loginModel) in
                self.passthroughAuthentication.send(Authentication.Loadding)
                LoginService.login(username: loginModel.username, password: loginModel.password) { (token) in
                    LoginService.setToken(token: token)
                    self.passthroughAuthentication.send(Authentication.LoggedIn)
                }
            }.store(in: &cancellables)
        
        self.passthroughAuthentication
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .sink { (authenThroughComplete) in
                // todo
            } receiveValue: { (authentication) in
                switch authentication {
                case .LoggedIn:
                    self.authentication = Authentication.LoggedIn
                case .LoggedOut:
                    LoginService.loggout { (_) in
                        self.authentication = Authentication.LoggedOut
                    }
                    
                case .Loadding:
                    self.authentication = Authentication.Loadding
                }
            }.store(in: &cancellables)
        
        self.passthroughAuthentication.send(Authentication.Loadding)
        LoginService.checkToken { (tokenExits) in
            switch tokenExits {
            case true:
                self.passthroughAuthentication.send(Authentication.LoggedIn)
            case false:
                self.passthroughAuthentication.send(Authentication.LoggedOut)
            }
        }
    }
    
    func login(username: String, password: String) -> Void {
        self.passthroughLoginViewModel.send(LoginModel(username: username, password: password))
    }
    
    func logout(){
        self.passthroughAuthentication.send(Authentication.LoggedOut)
    }
}
