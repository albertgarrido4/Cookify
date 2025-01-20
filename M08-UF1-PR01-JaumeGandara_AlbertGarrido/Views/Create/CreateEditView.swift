//
//  CreateView.swift
//  M08-UF1-PR01-JaumeGandara_AlbertGarrido
//
//  Created by alumne on 08/01/2025.
//

import SwiftUI

struct CreateEditView: View {
    @EnvironmentObject var viewModel: HomeViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @State private var isImagePickerPresented = false
    @State private var inputImage: UIImage? = nil
    @State private var newIngredientTitle = ""
    @State private var newIngredientQuantity = ""
    
    
    @State var title: String = ""
    @State var ingredients: [Ingredient] = []
    @State var steps: String = ""
    @State var category: Category = .lunch
    @State var time: String = ""
    @State var image: String? = nil
    @State var showAlert = false
    @State var alertMessage = ""

    @State var recipeToEdit: Recipe?

    var body: some View {
        NavigationView{
        Form {
            Section(header: Text("Photo")) {
                Button(action: {
                    isImagePickerPresented = true
                }) {
                    VStack {
                        if let imageUrlString = image, let imageUrl = URL(string: imageUrlString) {
                            AsyncImageCompat(url: imageUrl)
                                .frame(height: 200)
                                .clipped()
                        } else if let uiImage = inputImage {
                            Image(uiImage: uiImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 200)
                                .clipped()
                        } else {
                            placeholderImage
                        }
                    }
                }
                .sheet(isPresented: $isImagePickerPresented) {
                    ImagePicker(selectedImage: $inputImage)
                }
            }
            
            Section(header: Text("Basic Information")) {
                TextField("Title", text: $title)
                Picker("Category", selection: $category) {
                    ForEach(Category.allCases, id: \.self) { category in
                        Text(category.rawValue.capitalized)
                    }
                }
                TextField("Preparation Time (minutes)", text: $time)
                    .keyboardType(.numberPad)
            }
            
            Section(header: Text("Ingredients")) {
                ForEach(ingredients) { ingredient in
                    HStack {
                        Text(ingredient.title)
                        if let quantity = ingredient.quantity {
                            Spacer()
                            Text(quantity)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .onDelete(perform: deleteIngredient)
                
                HStack {
                    TextField("Ingredient", text: $newIngredientTitle)
                    TextField("Quantity", text: $newIngredientQuantity)
                    Button {
                        guard !newIngredientTitle.isEmpty else { return }
                        let ingredient = Ingredient(title: newIngredientTitle, quantity: newIngredientQuantity)
                        ingredients.append(ingredient)
                        newIngredientTitle = ""
                        newIngredientQuantity = ""
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                    .disabled(newIngredientTitle.isEmpty)
                }
            }
            
            Section(header: Text("Instructions")) {
                TextEditor(text: $steps)
                    .frame(minHeight: 100)
            }
        }
        .navigationTitle(viewModel.isEditing ? "Edit Recipe" : "New Recipe")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(viewModel.isEditing ? "Save" : "Create") {
                    if viewModel.isEditing{
                        print("TODO: viewModel edit")
                    }else{
                        let recipe = Recipe(title: title, ingredients: ingredients, steps: steps, category: category, time: Int(time)!, isFavorite: false, image: image)
                        if viewModel.saveRecipe(recipe: recipe){
                        presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
                .disabled(!isValid())
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
        }
            
        }.onAppear(){
            if viewModel.isEditing{
                
            }
        }
    }
    
    func isValid()-> Bool {
        !title.isEmpty && !ingredients.isEmpty && !steps.isEmpty && Int(time) != nil
    }
    
    private var placeholderImage: some View {
        ZStack {
            Rectangle()
                .fill(Color(.systemGray5))
                .frame(height: 200)
            Image(systemName: "photo")
                .foregroundColor(.gray)
        }
    }
    
    func deleteIngredient(at offsets: IndexSet) {
        ingredients.remove(atOffsets: offsets)
    }
}
