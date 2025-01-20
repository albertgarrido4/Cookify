//
//  HomeView.swift
//  M08-UF1-PR01-JaumeGandara_AlbertGarrido
//
//  Created by alumne on 08/01/2025.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var homeViewModel:HomeViewModel
    @State private var searchText = ""
    @State private var selectedRecipe: Recipe? = nil
    @State private var isCreatingRecipe = false
    @State private var recipes: [Recipe] = [
        Recipe(title: "Pancakes", ingredients: [Ingredient(title: "Farina", quantity: "200g"), Ingredient(title: "Llet", quantity: "300ml"), Ingredient(title: "Ous", quantity: "2")], steps: "1. Barreja tots els ingredients. 2. Cuina al foc fins que estiguin daurats.", category: .breakfast, time: 15, isFavorite: true, image: nil),
        Recipe(title: "Amanida César", ingredients: [Ingredient(title: "Enciam", quantity: "1 cap"), Ingredient(title: "Pollastre", quantity: "150g"), Ingredient(title: "Formatge parmesà", quantity: "50g"), Ingredient(title: "Crostons", quantity: "100g"), Ingredient(title: "Salsa César", quantity: "50ml")], steps: "1. Barreja l'enciam amb el pollastre i el formatge parmesà. 2. Afegeix crostons i amanida César.", category: .lunch, time: 10, isFavorite: false, image: nil),
        Recipe(title: "Espaguetis a la Bolonyesa", ingredients: [Ingredient(title: "Espaguetis", quantity: "200g"), Ingredient(title: "Carn picada", quantity: "150g"), Ingredient(title: "Tomàquet triturat", quantity: "200ml"), Ingredient(title: "Ceba", quantity: "1"), Ingredient(title: "All", quantity: "2 grans")], steps: "1. Cuina els espaguetis. 2. Prepara la salsa bolonyesa amb carn picada i tomàquet. 3. Serveix calent.", category: .dinner, time: 30, isFavorite: true, image: nil),
        Recipe(title: "Brownie de Xocolata", ingredients: [Ingredient(title: "Xocolata negra", quantity: "200g"), Ingredient(title: "Mantega", quantity: "100g"), Ingredient(title: "Sucre", quantity: "150g"), Ingredient(title: "Farina", quantity: "100g"), Ingredient(title: "Ous", quantity: "2")], steps: "1. Foneu la xocolata i la mantega. 2. Barregeu amb sucre, ous i farina. 3. Coeu al forn a 180ºC durant 20 minuts.", category: .dessert, time: 25, isFavorite: true, image: nil),
        Recipe(title: "Fruita amb Iogurt", ingredients: [Ingredient(title: "Iogurt natural", quantity: "1"), Ingredient(title: "Maduixes", quantity: "100g"), Ingredient(title: "Plàtan", quantity: "1"), Ingredient(title: "Mel", quantity: "1 cullerada")], steps: "1. Talleu la fruita a trossos petits. 2. Barregeu amb iogurt i mel.", category: .snack, time: 5, isFavorite: false, image: nil)
    ]

    var filteredRecipes: [Recipe] {
        if searchText.isEmpty {
            return homeViewModel.recipes
        } else {
            return homeViewModel.recipes.filter {
                $0.title.lowercased().contains(searchText.lowercased())
            }
        }
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Barra de búsqueda
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Buscar recetas", text: $searchText)
                            .padding(.leading, 8)
                    }
                    .padding(8)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)

                    Button(action: {
                        selectedRecipe = nil // Crear nueva receta
                        isCreatingRecipe = true
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title)
                            .foregroundColor(.blue)
                    }
                    .padding(.trailing, 16)
                }
                .padding(.vertical, 8)
                .sheet(isPresented: $isCreatingRecipe) {
                    CreateEditView()
                        .environmentObject(homeViewModel)
                }

                // Lista de recetas
                List {
                    ForEach(filteredRecipes) { recipe in
                        NavigationLink(destination: DetailsView(recipe: recipe)) {
                            HStack(spacing: 12) {
                                if let imageUrlString = recipe.image, let imageUrl = URL(string: imageUrlString) {
                                    AsyncImageCompat(url: imageUrl)
                                        .frame(width: 80, height: 80)
                                        .cornerRadius(8)
                                        .clipped()
                                } else {
                                    Rectangle()
                                        .fill(Color(.systemGray5))
                                        .frame(width: 80, height: 80)
                                        .cornerRadius(8)
                                }

                                VStack(alignment: .leading, spacing: 4) {
                                    Text(recipe.title)
                                        .font(.system(size: 16, weight: .medium))
                                        .foregroundColor(.gray)
                                    Text("\(recipe.time) min")
                                        .font(.system(size: 14))
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                            }
                            .padding(12)
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                        }
                    }
                    .onDelete(perform: deleteRecipes)
                }
                .listStyle(PlainListStyle())
                
                // Barra de navegación inferior
                HStack(spacing: 0) {
                    Spacer()
                    // Botón Favoritos
                    Button(action: { print("Favorits") }) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 22))
                        .foregroundColor(.gray)
                        .frame(width: 60)
                    }
                    Spacer()
                    // Botón Home
                    Button(action: { print("Home") }) {
                        Image(systemName: "house.fill")
                            .font(.system(size: 22))
                            .foregroundColor(.black)
                            .frame(width: 60)
                    }
                    Spacer()
                    // Botón Temporizador
                    Button(action: { print("Temporitzador") }) {
                        Image(systemName: "clock")
                            .font(.system(size: 22))
                            .foregroundColor(.gray)
                            .frame(width: 60)
                    }
                    Spacer()
                }
                .padding(.vertical, 8)
                .background(Color.white)
                .shadow(color: Color.black.opacity(0.05), radius: 5, y: -5)
            }
            .navigationBarHidden(true)
            .background(Color.white)
        }
    }

    private func deleteRecipes(at offsets: IndexSet) {
        offsets.map { filteredRecipes[$0] }.forEach { recipe in
            homeViewModel.deleteRecipe(recipe)
        }
    }
}
