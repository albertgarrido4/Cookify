//
//  InfoView.swift
//  M08-UF1-PR01-JaumeGandara_AlbertGarrido
//
//  Created by alumne on 20/01/2025.
//

import SwiftUI

struct InfoView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Sobre Cookify")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("Cookify és una aplicació que té com a objectiu principal facilitar la gestió i creació de receptes de cuina. Permet als usuaris organitzar-se a la cuina amb funcionalitats com la consulta de receptes, visualització d'ingredients, passos detallats i temps de preparació.")
                    .font(.body)
                    .multilineTextAlignment(.leading)

                Text("Funcionalitats principals")
                    .font(.headline)

                Text("- Consulta de receptes amb informació detallada.")
                Text("- Creació i edició de receptes pròpies.")
                Text("- Personalització de l'experiència culinària.")

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Informació")
    }
}
