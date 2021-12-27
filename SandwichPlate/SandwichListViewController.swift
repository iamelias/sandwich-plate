//
//  ViewController.swift
//  SandwichPlate
//
//  Created by Elias Hall on 12/26/21.
//

import UIKit

class SandwichListViewController: UIViewController, AddSandwichOrderDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var ordersListViewModel: OrderListViewModel = OrderListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navC = segue.destination as? UINavigationController, let addSandwichOrderVC = navC.viewControllers.first as? AddSandwichViewController else {
            fatalError("Error in segue")
        }
        addSandwichOrderVC.delegate = self
    }
    
    func addSandwichOrderVCDidSave(order: Order, controller: UIViewController) {
        controller.dismiss(animated: true, completion: nil)
        
        let orderVM = OrderViewModel(order: order)
        self.ordersListViewModel.ordersViewModel.append(orderVM)
        self.tableView.insertRows(at: [IndexPath.init(row: self.ordersListViewModel.ordersViewModel.count-1, section: 0)], with: .automatic)
        
    }
    
    func addSandwichOrderVCDidClose(controller: UIViewController) {
        controller.dismiss(animated: true, completion: nil)
    }

    
}

extension SandwichListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ordersListViewModel.ordersNumOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ordersListViewModel.ordersNumberOfRowsInSection()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sandwichListCell", for: indexPath)
        return cell
    }
}

