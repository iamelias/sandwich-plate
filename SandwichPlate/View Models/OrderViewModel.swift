//
//  OrderViewModel.swift
//  SandwichPlate
//
//  Created by Elias Hall on 12/26/21.
//

import Foundation

struct OrderListViewModel {
    var ordersViewModel: [OrderViewModel]
    
    public init() {
        self.ordersViewModel = [OrderViewModel]()
    }
    
    func ordersNumOfSections() -> Int {
        return 1
    }
    
    func ordersNumberOfRowsInSection() -> Int {
        return ordersViewModel.count
    }
    
    func orderViewModel(at index: Int) -> OrderViewModel {
        return self.ordersViewModel[index]
    }
    
}

struct OrderViewModel {
    let order: Order
    var name: String {
        return self.order.name
    }
    var email: String {
        return self.order.email
    }
    var sandwich: SandwichType {
        return self.order.sandwich
    }
    var size: SandwichSize {
        return self.order.size
    }
}
