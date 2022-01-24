//
//  TableViewCell.swift
//  Beuty Shop
//
//  Created by Arslan Abdullaev on 24.01.2022.
//

import UIKit

class ProductCell: UITableViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    private var activityIndicator: UIActivityIndicatorView?
    
    private var imageURL: URL? {
        didSet{
            productImage.image = nil
            updateImages()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        activityIndicator = showIndicator(in: productImage)
    }
    
    func configureCell(with item: Cosmetic) {
        brandLabel.text = item.brand
        nameLabel.text = item.name
        priceLabel.text = "\(item.price ?? "") \(item.price_sign ?? "")"
    
        imageURL = URL(string: "https:\(item.api_featured_image ?? "")")
    }
    
    private func updateImages() {
        guard let url = imageURL else { return }
        getImage(from: url) { result in
            switch result {
            case .success(let image):
                if url == self.imageURL {
                    self.productImage.image = image
                    self.activityIndicator?.stopAnimating()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func getImage(from url: URL, completion: @escaping(Result<UIImage, Error>) -> Void) {
        
        // Get image from cache
        if let cachedImage = ImageCache.shared.object(forKey: url.absoluteString as NSString) {
            print("Image from cache: ", url.absoluteString)
            completion(.success(cachedImage))
            return
        }
        
        // Dowonload image from url
        NetworkManager.shared.fetchData(url: url){ result in
            switch result {
            case .success(let data):
                guard let image = UIImage(data: data) else { return }
                ImageCache.shared.setObject(image, forKey: url.absoluteString as NSString)
                print("Image from network: ", url.absoluteString)
                completion(.success(image))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
    
    private func showIndicator(in view: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .purple
        activityIndicator.center = view.center
        
        view.addSubview(activityIndicator)
        return activityIndicator
    }
}
