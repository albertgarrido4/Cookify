//
//  Category.swift
//  M08-UF1-PR01-JaumeGandara_AlbertGarrido
//
//  Created by alumne on 08/01/2025.
//

import Foundation

enum Category: String, Codable, CaseIterable, Identifiable {
    case breakfast
    case lunch
    case dinner
    case dessert
    case snack
    
    var id: String { self.rawValue }
}
