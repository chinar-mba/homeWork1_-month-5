//
//  AuthorizationViewModel.swift
//  homeWork1
//
//  Created by Chinara on 7/9/23.
//

import Foundation
import FirebaseAuth

class AuthorizationViewModel {
    private let authService = AuthorizationService()
    
    func signIn(with phoneNumber: String, completion: @escaping (Result<Void, Error>) -> Void) {
        authService.signIn(with: phoneNumber, completion: completion)
    }
    
    func signInVerificationCode(
        with verificationCode: String,
        completion: @escaping (Result<User, Error>) -> Void
    ) {
        authService.signInVerificationCode(with: verificationCode, completion: completion)
        
    }
}
