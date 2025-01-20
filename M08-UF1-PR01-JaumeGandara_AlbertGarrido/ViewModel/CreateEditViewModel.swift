//
//  CreateViewModel.swift
//  M08-UF1-PR01-JaumeGandara_AlbertGarrido
//
//  Created by alumne on 08/01/2025.
//

import Foundation
import SwiftUI
import PhotosUI

class CreateEditViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var ingredients: [Ingredient] = []
    @Published var steps: String = ""
    @Published var category: Category = .lunch
    @Published var time: String = ""
    @Published var image: String? = nil
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    private let homeViewModel: HomeViewModel
    private let recipe: Recipe?
    @Published var isEditing: Bool
    
    init(homeViewModel: HomeViewModel, recipe: Recipe? = nil, isEditing: Bool = false) {
        self.homeViewModel = homeViewModel
        self.recipe = recipe
        self.isEditing = isEditing
        
        if let recipe = recipe {
            self.title = recipe.title
            self.ingredients = recipe.ingredients
            self.steps = recipe.steps
            self.category = recipe.category
            self.time = String(recipe.time)
            self.image = recipe.image
        }
    }
    
    var isValid: Bool {
        !title.isEmpty && !ingredients.isEmpty && !steps.isEmpty && Int(time) != nil
    }
    
    func addIngredient(title: String, quantity: String?) {
        guard !title.isEmpty else { return }
        let ingredient = Ingredient(title: title, quantity: quantity)
        ingredients.append(ingredient)
    }
    
    
    
    
    
}

