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
    
//    func fetchCharacter() async throws -> [Character] {
//        let request = URLRequest(
//            url: Constants
//                .API
//                .baseURL
//                .appendingPathComponent("character")
//        )
//        let (data, _) = try await URLSession.shared.data(for: request)
//        return try JSONDecoder().decode(Characters.self, from: data).results
//    }
//}
    
    func fetchCharacters(
        completion: @escaping
        (Result<[Character], RickAndMortyError>) -> Void
    ) {
        let request = URLRequest(
            url: Constants
                .API
                .baseURL
                .appendingPathComponent("character")
        )
        URLSession.shared.dataTask(
            with: request
        ) { data, response, error in

            guard let data else {
                return
            }
            do {
                let model = try JSONDecoder().decode(
                    Characters.self,
                    from: data
                )
                completion(.success(model.results))
            } catch {
                completion(.failure(.UFO))
            }
        }
        .resume()
    }
}
