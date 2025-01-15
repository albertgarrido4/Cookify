//
//  ImagePicker.swift
//  M08-UF1-PR01-JaumeGandara_AlbertGarrido
//
//  Created by alumne on 15/01/2025.
//

import SwiftUI
import UIKit

struct AsyncImageCompat: View {
    let url: URL
    @State private var image: UIImage? = nil
    @State private var isLoading: Bool = true

    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else if isLoading {
                ProgressView() // O un placeholder visual
            } else {
                Rectangle()
                    .fill(Color.gray)
                    .overlay(
                        Text("Failed to load image")
                            .foregroundColor(.white)
                    )
            }
        }
        .onAppear {
            loadImage()
        }
    }

    private func loadImage() {
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data, let loadedImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = loadedImage
                    self.isLoading = false
                }
            } else {
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
        }
        task.resume()
    }
}

