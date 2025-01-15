//
//  DetailsViewModel.swift
//  M08-UF1-PR01-JaumeGandara_AlbertGarrido
//
//  Created by alumne on 08/01/2025.
//

import Foundation
import SwiftUI

class DetailViewModel: ObservableObject {
    @Published var recipe: Recipe
    private let homeViewModel: HomeViewModel
    
    init(recipe: Recipe, homeViewModel: HomeViewModel) {
        self.recipe = recipe
        self.homeViewModel = homeViewModel
    }
    
    func toggleFavorite() {
        homeViewModel.toggleFavorite(for: recipe)
        recipe.isFavorite.toggle()
    }
    
    func deleteRecipe() {
        homeViewModel.deleteRecipe(recipe)
    }
    
    func updateRecipe(_ updatedRecipe: Recipe) {
        homeViewModel.updateRecipe(updatedRecipe)
        recipe = updatedRecipe
    }
}
