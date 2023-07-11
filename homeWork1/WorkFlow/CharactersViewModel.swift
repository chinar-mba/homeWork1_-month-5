//
//  CharactersViewModel.swift
//  homeWork1
//
//  Created by Chinara on 6/27/23.
//

import Foundation

class CharactersViewModel {
//    let networkService: NetworkService
//
//    init() {
//        self.networkService = NetworkService()
//    }
// 2 option to write  code
    

    
    private let networkService: NetworkService = {
        let service = NetworkService()
        return service
    } ()
    
    private var characters: [Character] = []
    
//    func fetchCharacters() async throws -> [Character] {
//        try await networkService.fetchCharacter()
//    }
    
    func fetchCharacters(completion: @escaping () -> Void) {
            networkService.fetchCharacters { result in
                switch result {
                case .success(let updatedCharacters):
                    self.characters = updatedCharacters
                    completion() 
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
}

