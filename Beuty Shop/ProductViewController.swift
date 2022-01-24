//
//  ProductViewController.swift
//  Beuty Shop
//
//  Created by Arslan Abdullaev on 24.01.2022.
//

import UIKit

class ProductViewController: UITableViewController {

    var productData: UserActions!
    var products: [Cosmetic] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 300
        fetch()
        setupRefreshControl()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productInfo", for: indexPath) as! ProductCell
        let item = products[indexPath.row]
        
        cell.configureCell(with: item)
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl?.addTarget(self, action: #selector(fetch), for: .valueChanged)
    }
}
extension ProductViewController {
   @objc func fetch() {
        NetworkManager.shared.fetchProducts(from: productData.producrtsURL, dataType: [Cosmetic].self) { result in
            switch result {
            case .success(let products):
                self.products = products
                self.tableView.reloadData()
                if self.refreshControl != nil {
                    self.refreshControl?.endRefreshing()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
