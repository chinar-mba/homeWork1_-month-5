//
//  SplashViewController.swift
//  homeWork1
//
//  Created by Chinara on 7/5/23.
//

import UIKit

class SplashViewController: UIViewController {
    
    private var authentificated = false
    private var keychain = KeyChainService.shared
    private let encoder = JSONEncoder()

    override func viewDidLoad(_animated: Bool) {
        super.viewDidLoad()
        
        let character = Character(
            name: "Hello",
            status: "Hi",
            species: "some species",
            type: "some type",
            gender: "male",
            image: "some image"
        )
        
        FirestoreManager.shared.addData(
            with: .character,
            data: [
            "name": character.name,
            "name": character.status,
            "status": character.status,
            "species": character.species,
            "type": character.type,
            "gender": character.gender,
            "image": character.image
            ]
        )
        
        FirestoreManager.shared.addData(
            with: character,
            data: SplashUtility.mapData(character: character)
        ) 
     
        FirestoreManager.shared.readData(with: character) { result in
            if case .success(let model) = result {
                let characters = SplashUtility.mapData(data: model)
            }  
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        if
            let data = try! keychain.readPassword(service: "Authorization", account: "UserSession"),
            let date = try? decoder.decode(Data.self, from: data),
            date > Date() {
            print(data)
            print(Date())
            let vc = RickAndMortyViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: false)
        } else {
            let vc = AuthorizationViewController() //needs to check
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.authentificated = true
        }
    }
}
