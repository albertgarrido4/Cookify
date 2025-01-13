//
//  CreateView.swift
//  M08-UF1-PR01-JaumeGandara_AlbertGarrido
//
//  Created by alumne on 08/01/2025.
//

import SwiftUI

struct CreateView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var homeViewModel: HomeViewModel // Para añadir la receta creada
    @StateObject var viewModel = CreateViewModel()

    var body: some View {
        Form {
            Section(header: Text("Recipe Details")) {
                TextField("Title", text: $viewModel.title)
                TextEditor(text: $viewModel.steps)
                    .frame(height: 100)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
            }

            Section(header: Text("Ingredients")) {
                ForEach(viewModel.ingredients) { ingredient in
                    Text("\(ingredient.title): \(ingredient.quantity ?? "N/A")")
                }
                .onDelete { indexSet in
                    viewModel.ingredients.remove(atOffsets: indexSet)
                }

                Button("Add Ingredient") {
                    viewModel.addIngredient(title: "New Ingredient", quantity: nil)
                }
            }

            Section(header: Text("Category and Time")) {
                Picker("Category", selection: $viewModel.category) {
                    ForEach(Category.allCases) { category in
                        Text(category.rawValue.capitalized).tag(category)
                    }
                }
                Stepper(value: $viewModel.time, in: 1...120, step: 1) {
                    Text("Time: \(viewModel.time) minutes")
                }
            }

            Button("Save Recipe") {
                /*let newRecipe = Recipe(
                    id: <#T##UUID#>, title: <#T##String#>, ingredients: <#T##[Ingredient]#>, steps: <#T##String#>, category: <#T##Category#>, time: <#T##Int#>, isFavorite: <#T##Bool#>, image: <#T##String?#>
                )
                homeViewModel.createRecipe(
                    title: newRecipe.title,
                    ingredients: newRecipe.ingredients,
                    steps: newRecipe.steps,
                    category: newRecipe.category,
                    time: newRecipe.time
                )
                presentationMode.wrappedValue.dismiss()
                 */
            }
        }
    }
}
