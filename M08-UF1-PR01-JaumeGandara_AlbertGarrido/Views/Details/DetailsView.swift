//
//  DetailsView.swift
//  M08-UF1-PR01-JaumeGandara_AlbertGarrido
//
//  Created by alumne on 08/01/2025.
//

import SwiftUI

struct DetailsView: View {
    let recipe: Recipe // Recibe la receta seleccionada como parámetro
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Imagen de la receta
                if let imageUrlString = recipe.image, let imageUrl = URL(string: imageUrlString) {
                    AsyncImageCompat(url: imageUrl)
                        .frame(height: 200)
                        .clipped()
                        .cornerRadius(12)
                } else {
                    Rectangle()
                        .fill(Color(.systemGray5))
                        .frame(height: 200)
                        .cornerRadius(12)
                }
                
                // Información de la receta
                VStack(alignment: .leading, spacing: 8) {
                    Text(recipe.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Categoria: \(recipe.category.rawValue.capitalized)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Text("Temps: \(recipe.time) min")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Text("Ingredients:")
                        .font(.headline)
                    
                    ForEach(recipe.ingredients, id: \.title) { ingredient in
                        Text("- \(ingredient.title): \(ingredient.quantity!)")
                            .font(.body)
                    }
                    
                    Text("Passos:")
                        .font(.headline)
                        .padding(.top, 8)
                    
                    Text(recipe.steps)
                        .font(.body)
                        .multilineTextAlignment(.leading)
                }
            }
            .padding()
        }
        .navigationTitle("Detalls")
    }
}
