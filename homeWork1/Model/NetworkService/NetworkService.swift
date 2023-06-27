//
//  NetworkService.swift
//  homeWork1
//
//  Created by Chinara on 6/20/23.
//

import Foundation

struct NetworkService {
    
    enum RickAndMortyError: Error {
        case UFO, RICK
    }
    
    static let shared = NetworkService()
    
    func fetchCharacter() async throws -> [Character] {
        let request = URLRequest(
            url: Constants
                .API
                .baseURL
                .appendingPathComponent("character")
        )
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(Characters.self, from: data).results
    }
}
   

