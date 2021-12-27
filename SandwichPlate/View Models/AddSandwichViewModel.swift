//
//  AddSandwichViewModel.swift
//  SandwichPlate
//
//  Created by Elias Hall on 12/26/21.
//

import Foundation



struct AddSandwichViewModel {
    var name: String?
    var email: String?
    var selectedType: String?
    var selectedSize: String?
    var types: [String] {
        return SandwichType.allCases.map { $0.rawValue}
    }
    var sizes: [String] {
        return SandwichSize.allCases.map { $0.rawValue}
    }
}
