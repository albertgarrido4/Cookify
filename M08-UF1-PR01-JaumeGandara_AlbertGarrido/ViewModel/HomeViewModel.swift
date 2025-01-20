//
//  HomeViewModel.swift
//  M08-UF1-PR01-JaumeGandara_AlbertGarrido
//
//  Created by alumne on 08/01/2025.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var searchText: String = ""
    @Published var isEditing = false
    @Published var alertMessage = ""
    @Published var showAlert = false
    @Published var title: String = ""
    @Published var ingredients: [Ingredient] = []
    @Published var steps: String = ""
    @Published var category: Category = .lunch
    @Published var time: String = ""
    @Published var image: String? = nil
    
    private let recipesKey = "recipes"
    
    var filteredRecipes: [Recipe] {
        if searchText.isEmpty {
            return recipes
        } else {
            return recipes.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    init() {
        self.loadRecipes()
    }
    
    func createRecipe(_ recipe: Recipe) {
        recipes.append(recipe)
        saveRecipes()
    }
    
    func updateRecipe(_ recipe: Recipe) {
        if let index = recipes.firstIndex(where: { $0.id == recipe.id }) {
            recipes[index] = recipe
            saveRecipes()
        }
    }
    
    func deleteRecipe(_ recipe: Recipe) {
        recipes.removeAll { $0.id == recipe.id }
        saveRecipes()
    }
    
    func toggleFavorite(for recipe: Recipe) {
        if let index = recipes.firstIndex(where: { $0.id == recipe.id }) {
            recipes[index].isFavorite.toggle()
            saveRecipes()
        }
    }
    
    private func saveRecipes() {
        do {
            let data = try JSONEncoder().encode(recipes)
            UserDefaults.standard.set(data, forKey: recipesKey)
        } catch {
            print("Error saving recipes: \(error)")
        }
    }
    
    private func loadRecipes() {
        guard let data = UserDefaults.standard.data(forKey: recipesKey) else {
            // Cargar recetas de ejemplo si no hay datos guardados
            loadSampleRecipes()
            return
        }
        
        do {
            recipes = try JSONDecoder().decode([Recipe].self, from: data)
        } catch {
            print("Error loading recipes: \(error)")
            loadSampleRecipes()
        }
    }
    
    private func loadSampleRecipes() {
        recipes = [
            Recipe(title: "Pancakes", ingredients: [
                Ingredient(title: "Farina", quantity: "200g"),
                Ingredient(title: "Llet", quantity: "300ml"),
                Ingredient(title: "Ous", quantity: "2")
            ], steps: "1. Barreja tots els ingredients.\n2. Cuina al foc fins que estiguin daurats.", category: .breakfast, time: 15, isFavorite: true, image: nil),
            // Añade más recetas de ejemplo aquí...
        ]
        saveRecipes()
    }
    
    func saveRecipe(recipe: Recipe) -> Bool {
        print("TODO: evitar duplicados")
        recipes.append(recipe)
        return true

    }
    
    
}
