//
//  CharactersViewModel.swift
//  homeWork1
//
//  Created by Chinara on 6/27/23.
//

import Foundation

class CharactersViewModel {
    let networkService: NetworkService
    
    init() {
        self.networkService = NetworkService()
    }
    
    func fetchCharacters() async throws -> [Character] {
        try await networkService.fetchCharacter()
    }
}
