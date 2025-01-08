//
//  Recipe.swift
//  M08-UF1-PR01-JaumeGandara_AlbertGarrido
//
//  Created by alumne on 08/01/2025.
//

import Foundation

struct Recipe: Identifiable, Codable {
    let id: UUID
    var title: String
    var ingredients: [Ingredient]
    var steps: String
    var category: Category
    var time: Int
    var isFavorite: Bool
    var image: String?
}
