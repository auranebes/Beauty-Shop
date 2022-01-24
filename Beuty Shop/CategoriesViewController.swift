//
//  CategoriesViewController.swift
//  Beuty Shop
//
//  Created by Arslan Abdullaev on 24.01.2022.
//

import UIKit

private let reuseIdentifier = "cosmetic"



class CategoriesViewController: UICollectionViewController {
    
    let categories = UserActions.getCategoriesInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(categories)
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let productVC = segue.destination as? ProductViewController else {return}
        productVC.productData = sender as? UserActions
    }

    // MARK: UICollectionViewDataSource


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CategoryCell
        
        let category = categories[indexPath.item]
        cell.categoryLabel.text = category.productsName
        cell.categoryImage.image = UIImage(named: category.productsName)
        
        return cell
    }

    // MARK: - UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let userAction = categories[indexPath.item]
        performSegue(withIdentifier: "showSegue", sender: userAction)
    }
}
    // MARK: - Methods

extension CategoriesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 40, height: 270)
    }
}

