//
//  HomeViewModel.swift
//  M08-UF1-PR01-JaumeGandara_AlbertGarrido
//
//  Created by alumne on 08/01/2025.
//

import Foundation

class HomeViewModel: ObservableObject {
    // Clave para guardar y cargar recetas en UserDefaults
    private let recipesKey = "recipes"
    
    // Lista de recetas
    @Published var recipes: [Recipe] = [] {
        didSet {
            saveRecipes()
        }
    }
    
    // Texto de búsqueda
    @Published var searchText: String = ""
    
    // Lista de recetas filtradas
    var filteredRecipes: [Recipe] {
        if searchText.isEmpty {
            return recipes
        } else {
            return recipes.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    // Inicializador
    init() {
        loadRecipes()
    }
    
    // Guardar recetas en UserDefaults
    private func saveRecipes() {
        do {
            let data = try JSONEncoder().encode(recipes)
            UserDefaults.standard.set(data, forKey: recipesKey)
        } catch {
            print("Error al guardar recetas: \(error)")
        }
    }
    
    // Cargar recetas desde UserDefaults
    private func loadRecipes() {
        guard let data = UserDefaults.standard.data(forKey: recipesKey) else {
            recipes = []
            return
        }
        
        do {
            recipes = try JSONDecoder().decode([Recipe].self, from: data)
        } catch {
            print("Error al cargar recetas: \(error)")
            recipes = []
        }
    }
    
    // Crear una nueva receta
    func createRecipe(title: String, ingredients: [Ingredient], steps: String, category: Category, time: Int, isFavorite: Bool = false, image: String? = nil) {
        let newRecipe = Recipe(
            id: UUID(),
            title: title,
            ingredients: ingredients,
            steps: steps,
            category: category,
            time: time,
            isFavorite: isFavorite,
            image: image
        )
        recipes.append(newRecipe)
    }
    
    // Alternar favorito
    func toggleFavorite(for recipe: Recipe) {
        if let index = recipes.firstIndex(where: { $0.id == recipe.id }) {
            recipes[index].isFavorite.toggle()
        }
    }
}

