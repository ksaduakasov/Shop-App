//
//  CartViewController.swift
//  SimpleShopApp
//
//  Created by Kalbek Saduakassov on 02.02.2021.
//

import UIKit

protocol CellRemoveDeleage {
    func remove(id: IndexPath) -> UIContextualAction
}

class CartViewController: UIViewController, CellRemoveDeleage {
    static var cartItems = [Item]()
    private var totalAmount: Float = 0
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidAppear(_ animated: Bool) {
        initializeTotalAmount()
        print(totalAmount)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeTotalAmount()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "< Back", style: .plain, target: self, action: #selector(goToViewController))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Purchase", style: .plain, target: self, action: #selector(purchaseItems))
        
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CartTableViewCell", bundle: nil), forCellReuseIdentifier: "CartTableViewCell")
    }
    
    func remove(id: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Delete") { [self] (action, view, completion) in
            CartViewController.cartItems.remove(at: id.row)
            tableView.deleteRows(at: [id], with: .none)
            viewDidAppear(true)
        }
        return action
    }
    
    private func initializeTotalAmount() {
        totalAmount = 0
        for i in 0..<CartViewController.cartItems.count {
            totalAmount += (Float(CartViewController.cartItems[i].price!) * (100 - Float(CartViewController.cartItems[i].discount!)) / 100)
        }
    }
    
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CartViewController.cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartTableViewCell") as! CartTableViewCell
        let index = CartViewController.cartItems[indexPath.row]
        cell.imgView.image = UIImage(named: index.image!)
        cell.titleLabel.text = index.title
        cell.descLabel.text = index.description
        cell.priceLabel.text = "\(Float(index.price!) * (100 - Float(index.discount!)) / 100)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = remove(id: indexPath)
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    @objc private func goToViewController() {
        self.navigationController?.popToRootViewController( animated: true)
    }
    
    @objc private func purchaseItems() {
        if totalAmount > 0 {
            let alert = UIAlertController(title: "Your total amount to pay is \(totalAmount)", message: "Do you confirm your purchase?", preferredStyle: .alert)
            
            let action1 = UIAlertAction(title: "No", style: .default) { _ in
                self.dismiss(animated: true, completion: nil)
            }
            
            let action2 = UIAlertAction(title: "Yes", style: .default) { (_) in
                let congratsAlert = UIAlertController(title: "Congratulations!", message: "Your have successfully purchased your items!", preferredStyle: .alert)
                let lastAction = UIAlertAction(title: "Go to main page", style: .default) { _ in
                    self.navigationController?.popToRootViewController( animated: true)
                }
                congratsAlert.addAction(lastAction)
                self.present(congratsAlert, animated: true)
                CartViewController.cartItems.removeAll()
                self.tableView.reloadData()
            }
            alert.addAction(action1)
            alert.addAction(action2)
            present(alert, animated: true)
        }
    }
}
