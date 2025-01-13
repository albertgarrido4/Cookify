//
//  HomeView.swift
//  M08-UF1-PR01-JaumeGandara_AlbertGarrido
//
//  Created by alumne on 08/01/2025.
//

import SwiftUI

struct HomeView: View {
    @State private var searchText = ""
    @State private var recipes: [Recipe] = [
        Recipe(id: UUID(), title: "Pancakes", ingredients: [Ingredient(title: "Farina", quantity: "200g"), Ingredient(title: "Llet", quantity: "300ml"), Ingredient(title: "Ous", quantity: "2")], steps: "1. Barreja tots els ingredients. 2. Cuina al foc fins que estiguin daurats.", category: .breakfast, time: 15, isFavorite: true, image: nil),
        Recipe(id: UUID(), title: "Amanida César", ingredients: [Ingredient(title: "Enciam", quantity: "1 cap"), Ingredient(title: "Pollastre", quantity: "150g"), Ingredient(title: "Formatge parmesà", quantity: "50g"), Ingredient(title: "Crostons", quantity: "100g"), Ingredient(title: "Salsa César", quantity: "50ml")], steps: "1. Barreja l'enciam amb el pollastre i el formatge parmesà. 2. Afegeix crostons i amanida César.", category: .lunch, time: 10, isFavorite: false, image: nil),
        Recipe(id: UUID(), title: "Espaguetis a la Bolonyesa", ingredients: [Ingredient(title: "Espaguetis", quantity: "200g"), Ingredient(title: "Carn picada", quantity: "150g"), Ingredient(title: "Tomàquet triturat", quantity: "200ml"), Ingredient(title: "Ceba", quantity: "1"), Ingredient(title: "All", quantity: "2 grans")], steps: "1. Cuina els espaguetis. 2. Prepara la salsa bolonyesa amb carn picada i tomàquet. 3. Serveix calent.", category: .dinner, time: 30, isFavorite: true, image: nil),
        Recipe(id: UUID(), title: "Brownie de Xocolata", ingredients: [Ingredient(title: "Xocolata negra", quantity: "200g"), Ingredient(title: "Mantega", quantity: "100g"), Ingredient(title: "Sucre", quantity: "150g"), Ingredient(title: "Farina", quantity: "100g"), Ingredient(title: "Ous", quantity: "2")], steps: "1. Foneu la xocolata i la mantega. 2. Barregeu amb sucre, ous i farina. 3. Coeu al forn a 180ºC durant 20 minuts.", category: .dessert, time: 25, isFavorite: true, image: nil),
        Recipe(id: UUID(), title: "Fruita amb Iogurt", ingredients: [Ingredient(title: "Iogurt natural", quantity: "1"), Ingredient(title: "Maduixes", quantity: "100g"), Ingredient(title: "Plàtan", quantity: "1"), Ingredient(title: "Mel", quantity: "1 cullerada")], steps: "1. Talleu la fruita a trossos petits. 2. Barregeu amb iogurt i mel.", category: .snack, time: 5, isFavorite: false, image: nil)
    ]

    var filteredRecipes: [Recipe] {
        if searchText.isEmpty {
            return recipes
        } else {
            return recipes.filter {
                $0.title.lowercased().contains(searchText.lowercased())
            }
        }
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Barra de cerca
                HStack {
                    TextField("Cerca receptes...", text: $searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)

                    Button(action: {
                        // Acció per crear una nova recepta
                        print("Crear recepta")
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title)
                            .foregroundColor(.blue)
                    }
                    .padding(.trailing)
                }
                
                // Llista de receptes
                List(filteredRecipes) { recipe in NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                    VStack(alignment: .leading) {
                        Text(recipe.title)
                            .font(.headline)
                        Text(recipe.category.rawValue.capitalized)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }}

                // Barra inferior
                HStack {
                    Spacer()
                    Button(action: {
                        print("Favorits")
                    }) {
                        VStack {
                            Image(systemName: "star.fill")
                            Text("")
                                .font(.caption)
                        }
                    }
                    Spacer()
                    Button(action: {
                        print("Home")
                    }) {
                        VStack {
                            Image(systemName: "house.fill")
                            Text("")
                                .font(.caption)
                        }
                    }
                    Spacer()
                    Button(action: {
                        print("Temporitzador")
                    }) {
                        VStack {
                            Image(systemName: "stopwatch.fill")
                            Text("")
                                .font(.caption)
                        }
                    }
                    Spacer()
                }
                .padding()
                .background(Color(UIColor.systemGray6))
            }.navigationBarHidden(true)
            //.edgesIgnoringSafeArea(.top)
        }
    }
}

struct RecipeDetailView: View {
    let recipe: Recipe
        
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(recipe.title)
                .font(.largeTitle)
            Text("Categoria: \(recipe.category.rawValue.capitalized)")
                .font(.subheadline)
            Text("Temps: \(recipe.time) min")
                .font(.subheadline)
            Text("Passos: \(recipe.steps)")
                .font(.body)
        }
        .padding()
        .navigationTitle("Detalls de la recepta")
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
