//
//  Character.swift
//  homeWork1
//
//  Created by Chinara on 6/20/23.
//

import Foundation

struct Characters: Decodable {
    let results: [Character]
}

struct Character: Decodable {
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let image: String
}

