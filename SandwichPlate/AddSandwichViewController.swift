//
//  AddSandwichViewController.swift
//  SandwichPlate
//
//  Created by Elias Hall on 12/26/21.
//

import Foundation
import UIKit

protocol AddSandwichOrderDelegate {
    func addSandwichOrderVCDidSave(order: Order, controller: UIViewController)
    func addSandwichOrderVCDidClose(controller: UIViewController)
}

class AddSandwichViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    var addSandwichVM = AddSandwichViewModel()
    var sandwichSizeSegmentedControl: UISegmentedControl!
    var delegate: AddSandwichOrderDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setupSegControl()
    }
    
    func setupSegControl() {
        self.sandwichSizeSegmentedControl = UISegmentedControl(items: self.addSandwichVM.sizes)
        self.sandwichSizeSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview((self.sandwichSizeSegmentedControl))
        
        self.sandwichSizeSegmentedControl.topAnchor.constraint(equalTo: self.tableView.bottomAnchor, constant: 20).isActive = true
    }
    @IBAction func closeButtonDidTouch(_ sender: Any) {
        if let delegate = self.delegate {
            delegate.addSandwichOrderVCDidClose(controller: self)
        }
    }
    
    @IBAction func save() {
        let name = self.nameTextField.text
        let email = self.emailTextField.text
        
        let selectedSize = self.sandwichSizeSegmentedControl.titleForSegment(at: self.sandwichSizeSegmentedControl.selectedSegmentIndex)
        
        guard let indexPath = self.tableView.indexPathForSelectedRow else {
            fatalError("Error in selecting")
        }
        
        self.addSandwichVM.name = name
        self.addSandwichVM.email = email
        self.addSandwichVM.selectedSize = selectedSize
        self.addSandwichVM.selectedType = self.addSandwichVM.types[indexPath.row]
        
        let order = Order(vm: addSandwichVM)
        
        if let order = order {
        delegate?.addSandwichOrderVCDidSave(order: order  , controller: self)
        }
        else {
            print("Error in order save")
        }
    }
}

extension AddSandwichViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.addSandwichVM.types.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addOrderCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = self.addSandwichVM.types[indexPath.row]
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
}
