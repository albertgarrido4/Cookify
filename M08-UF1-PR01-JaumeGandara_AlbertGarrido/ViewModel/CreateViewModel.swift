//
//  CreateViewModel.swift
//  M08-UF1-PR01-JaumeGandara_AlbertGarrido
//
//  Created by alumne on 08/01/2025.
//

import Foundation

class CreateViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var ingredients: [Ingredient] = []
    @Published var steps: String = ""
    @Published var category: Category = .lunch
    @Published var time: Int = 0

    func addIngredient(title: String, quantity: String?) {
        let newIngredient = Ingredient(title: title, quantity: quantity)
        ingredients.append(newIngredient)
    }

    func clearFields() {
        title = ""
        ingredients = []
        steps = ""
        category = .lunch
        time = 0
    }
}
