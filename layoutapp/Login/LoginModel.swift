//
//  LoginModel.swift
//  layoutapp
//
//  Created by Thiem Jason on 3/23/21.
//

import Foundation

struct LoginModel {
    let username: String
    let password: String
}

enum Authentication {
    case LoggedIn
    case LoggedOut
    case Loadding
}
