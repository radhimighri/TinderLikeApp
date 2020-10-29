//
//  AuthenticationViewModel.swift
//  TinderLikeApp
//
//  Created by Radhi Mighri on 29/10/2020.
//  Copyright © 2020 Radhi Mighri. All rights reserved.
//

import UIKit

protocol AuthenticationViewModel {
    var formIsValid: Bool { get }
}

    struct LoginViewModel: AuthenticationViewModel {
        var email: String?
        var password: String?
        
        var formIsValid: Bool {
            return email?.isEmpty == false &&
                   password?.isEmpty == false
        }

    }

struct RegistrationViewModel: AuthenticationViewModel {
    var email: String?
    var fullname: String?
    var password: String?
    
    
    var formIsValid: Bool {
        return email?.isEmpty == false &&
            fullname?.isEmpty == false &&
            password?.isEmpty == false
    }
}
