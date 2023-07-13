//
//  CharactersViewModel.swift
//  homeWork1
//
//  Created by Chinara on 6/27/23.
//

import Foundation

class CharactersViewModel {
    
    
    private let networkService = NetworkService.shared
    
    private var characters: [Character] = []
    
    func fetchCharacters() async throws -> [Character] {
        try await networkService.fetchCharacter()
    }
}

