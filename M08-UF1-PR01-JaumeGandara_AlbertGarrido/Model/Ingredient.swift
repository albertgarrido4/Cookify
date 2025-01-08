//
//  Ingredient.swift
//  M08-UF1-PR01-JaumeGandara_AlbertGarrido
//
//  Created by alumne on 08/01/2025.
//

import Foundation

struct Ingredient: Identifiable {
    let id = UUID()
    var title: String
    var quantity: String?
}
