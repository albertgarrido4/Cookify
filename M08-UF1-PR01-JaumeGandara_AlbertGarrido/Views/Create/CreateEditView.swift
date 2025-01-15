//
//  CreateView.swift
//  M08-UF1-PR01-JaumeGandara_AlbertGarrido
//
//  Created by alumne on 08/01/2025.
//

import SwiftUI

struct CreateEditView: View {
    @StateObject var viewModel: CreateEditViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @State private var isImagePickerPresented = false
    @State private var inputImage: UIImage? = nil
    @State private var newIngredientTitle = ""
    @State private var newIngredientQuantity = ""

    

    var body: some View {
        Form {
            Section(header: Text("Photo")) {
                Button(action: {
                    isImagePickerPresented = true
                }) {
                    VStack {
                        if let imageUrlString = viewModel.image, let imageUrl = URL(string: imageUrlString) {
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
                TextField("Title", text: $viewModel.title)
                Picker("Category", selection: $viewModel.category) {
                    ForEach(Category.allCases, id: \.self) { category in
                        Text(category.rawValue.capitalized)
                    }
                }
                TextField("Preparation Time (minutes)", text: $viewModel.time)
                    .keyboardType(.numberPad)
            }
            
            Section(header: Text("Ingredients")) {
                ForEach(viewModel.ingredients) { ingredient in
                    HStack {
                        Text(ingredient.title)
                        if let quantity = ingredient.quantity {
                            Spacer()
                            Text(quantity)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .onDelete(perform: viewModel.deleteIngredient)
                
                HStack {
                    TextField("Ingredient", text: $newIngredientTitle)
                    TextField("Quantity", text: $newIngredientQuantity)
                    Button {
                        viewModel.addIngredient(title: newIngredientTitle, quantity: newIngredientQuantity)
                        newIngredientTitle = ""
                        newIngredientQuantity = ""
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                    .disabled(newIngredientTitle.isEmpty)
                }
            }
            
            Section(header: Text("Instructions")) {
                TextEditor(text: $viewModel.steps)
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
                    if viewModel.saveRecipe() {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                .disabled(!viewModel.isValid)
            }
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("Error"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
        }
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
}
