//
//  AuthorizationService.swift
//  homeWork1
//
//  Created by Chinara on 7/5/23.
//

import Foundation
//import FirebaseAuth

class BaseAuthService {
    
    private let keychain = KeyChainService.shared
    
    private func saveSession() {
        let minutesLater = Calender.current.date(byAdding: .second, value: 10, to: Date())!
        let encoder = JSONDecoder()
        encoder.dataEncodingStrategy = .secondsSince1970
        let data = try! encoder.encode(minutesLater)
        do {
            try self.keychain.save("Authorization", forKey: "UserSession")
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
                    try self.keychain.addPassword(
                        service: "Authentification",
                        account: "PhoneNumber",
                        password: data
                    )
                } catch {
                    print(error.localizedDescription)
                }
                completion(.success(()))
            }
    }
    
    func signInVerificationCode(with verificationCode: String, completion: @escaping (Result<User, Error>) -> Void) {
        let data = keychain.readPassword(service: "Authentification", account: "PhoneNumber")
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
