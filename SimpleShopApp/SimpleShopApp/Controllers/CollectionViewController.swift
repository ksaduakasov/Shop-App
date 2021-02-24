//
//  CollectionViewController.swift
//  SimpleShopApp
//
//  Created by Kalbek Saduakassov on 06.02.2021.
//

import UIKit

private let reuseIdentifier = "ItemCell"

class CollectionViewController: UIViewController {

    @IBOutlet public var gridSC: UISegmentedControl!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "My Cart", style: .plain, target: self, action: #selector(goToCartViewController))
        navigationItem.titleView = gridSC
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "ItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        
    }
    
    @IBAction func gridDidChosen(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            navigationController?.popToRootViewController(animated: true)
            sender.selectedSegmentIndex = 1
        }
    }
    
    @objc private func goToCartViewController() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "cartVC") as! CartViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension CollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ViewController.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ItemCollectionViewCell
        let index = ViewController.items[indexPath.row]
        cell.imgView.image = UIImage(named: index.image!)
        cell.titleLabel.text = index.title
        cell.descLabel.text = index.description
        cell.priceLabel.text = "\(Int(Float(index.price!) * (100 - Float(index.discount!)) / 100)) KZT"
        cell.discountLabel.text = "\(index.discount!)%"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "itemVC") as! ItemViewController
        let id = indexPath.row
        vc.object = Item(image: ViewController.items[id].image!, title: ViewController.items[id].title!, author: ViewController.items[id].author!, description: ViewController.items[id].description!, price: ViewController.items[id].price!, discount: ViewController.items[id].discount!)
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}
