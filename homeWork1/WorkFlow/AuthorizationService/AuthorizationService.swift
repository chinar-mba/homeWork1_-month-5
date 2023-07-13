//
//  AuthorizationService.swift
//  homeWork1
//
//  Created by Chinara on 7/5/23.
//

import Foundation
import FirebaseAuth

class BaseAuthService {
    
    private let keychain = KeyChainService.shared
    
    func saveSession() {
        let minutesLater = Calendar.current.date(byAdding: .second, value: 10, to: Date())!
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .secondsSince1970
        let data = try! encoder.encode(minutesLater)
        do {
            try self.keychain.save(service: "Authorization", account: "UserSession", data: data)
        } catch {
            print(error.localizedDescription)
        }
    }
}

class AuthorizationService: BaseAuthService {
    
    private let keychain = KeyChainService.shared
    
    func signIn(with phoneNumber: String, completion: @escaping (Result<Void, Error>) -> Void) {
        PhoneAuthProvider.provider()
                    .verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
                if let error = error {
                    print(error)
                    completion(.failure(error))
                }
                let data = Data((verificationID ?? "") .utf8)
                
                do {
                    try self.keychain.save(
                        service: "Authentification",
                        account: "PhoneNumber",
                        data: data
                    )
                } catch {
                    print(error.localizedDescription)
                }
                completion(.success(()))
            }
    }
    
    func signInVerificationCode(with verificationCode: String, completion: @escaping (Result<User, Error>) -> Void) {
        let data = keychain.read(service: "Authentification", account: "PhoneNumber")
        let verificationID = String(data: data!, encoding: .utf8)!
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID,
            verificationCode: verificationCode
        )
        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let user = authResult?.user else {
                return
            }
            print("Our user is: \(user)")
            
            super.saveSession()
            completion(.success(user))
        }
    }


}

class EmailAuthorization: BaseAuthService {
    func signInEmail(email: String, password: String, completion: @escaping(Result<Void, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(error))
            } else {
                completion(.success(()))
                super.saveSession()
            }
        }
        
    }
    
    
    func signUpEmail(email: String, password: String, completion: @escaping(Result<Void, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(error))
            } else {
                completion(.success(()))
                super.saveSession()
            }
        }
        
    }
}
