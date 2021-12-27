//
//  Order.swift
//  SandwichPlate
//
//  Created by Elias Hall on 12/26/21.
//

import Foundation

enum SandwichType: String, CaseIterable {
    case engineer, texan, citysub, beachman, farmer
}

enum SandwichSize: String, CaseIterable {
    case small, medium, large, xlarge
}


struct Order {
    let name: String
    let email: String
    let size: SandwichSize
    let sandwich: SandwichType
}

extension Order {
    public init?(vm: AddSandwichViewModel) {
        guard let name = vm.name, let email = vm.email, let selectedSandwich = SandwichType(rawValue: vm.selectedType!), let selectedSize = SandwichSize(rawValue: vm.selectedSize!) else {
            return nil
        }
        
        self.name = name
        self.email = email
        self.sandwich = selectedSandwich
        self.size = selectedSize
    }
    
    func createOrder(vm: AddSandwichViewModel) -> Order {
        let order = Order(name: self.name, email: self.email, size: self.size, sandwich: self.sandwich)
        return order
    }
}
