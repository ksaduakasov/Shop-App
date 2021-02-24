//
//  ViewController.swift
//  SimpleShopApp
//
//  Created by Kalbek Saduakassov on 02.02.2021.
//

import UIKit



class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet var tableSC: UISegmentedControl!
    static var items = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ItemTableViewCell", bundle: nil), forCellReuseIdentifier: "ItemTableViewCell")
        showItems()
    }
    
    private func showItems() {
        let item1 = Item(image: "ekinwiBolma", title: "Екінші Болма!", author: "Kuanysh Shonbay", description: "The Kazakh way of becoming successful!", price: 3500.00, discount: 10)
        let item2 = Item(image: "games", title: "Игры, в которые играют люди", author: "Eric Berne", description: "Human relationship phsychology", price: 2250.00, discount: 12)
        let item3 = Item(image: "MagicUtro", title: "Магия утра", author: "Hal Elrod", description: "How the first hour of the day determines your success", price: 3990.00, discount: 15)
        let item4 = Item(image: "neTupi", title: "НЕ ТУПИ", author: "Jen Sincero", description: "Only those who work on themselves every day live a dream life", price: 4150.00, discount: 21)
        let item5 = Item(image: "pofigizm", title: "Тонкое искусство пофигизма", author: "Mark Manson", description: "The Subtle Art of Not Giving a F*ck", price: 4990.00, discount: 16)
        
        ViewController.items = [item1, item2, item3, item4, item5]
    }
    
    
    @IBAction func gridDidChosen(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            sender.selectedSegmentIndex = 0
            let vc = storyboard?.instantiateViewController(withIdentifier: "collectionVC") as! CollectionViewController
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    private func calculateDiscount(id: Int) -> Float {
        return (Float(ViewController.items[id].price!) * Float(100 - ViewController.items[id].discount!) / 100)
    }
    
    
    func reviewItem(_ id: Int) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "itemVC") as! ItemViewController
        vc.object = Item(image: ViewController.items[id].image!, title: ViewController.items[id].title!, author: ViewController.items[id].author!, description: ViewController.items[id].description!, price: ViewController.items[id].price!, discount: ViewController.items[id].discount!)
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func goToCartVC(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "cartVC") as! CartViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ViewController.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell") as! ItemTableViewCell
        let index = ViewController.items[indexPath.row]
        cell.imgView.image = UIImage(named: index.image!)
        cell.titleLabel.text = index.title
        cell.descLabel.text = index.description
        cell.priceLabel.text = "\(Int(calculateDiscount(id: indexPath.row))) KZT"
        cell.discountLabel.text = "\(index.discount!)%"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        reviewItem(indexPath.row)
    }
    
    
    
    
}

