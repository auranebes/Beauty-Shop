//
//  NetworkManager.swift
//  Beuty Shop
//
//  Created by Arslan Abdullaev on 22.01.2022.
//

import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    
    let postRequest = "https://jsonplaceholder.typicode.com/posts"
    
    func fetchProducts<T: Decodable>(from url: String, dataType: T.Type, completion: @escaping(Result<T, NetworkErrors >) -> Void) {
        AF.request(url)
            .validate()
            .responseDecodable(of: T.self) { response in
                guard let value = response.value else { return }
                        completion(.success(value))
            }
    }
    
    func fetchData(url: URL, completion: @escaping(Result<Data, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    
    func postRequest(with data: Cosmetic, to url: String, completion: @escaping(Result<Any, NetworkErrors>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidUrl))
            return
        }
        
        guard let courseData = try? JSONEncoder().encode(data) else {
            completion(.failure(.noData))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = courseData
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }

            
            do {
                let course = try JSONDecoder().decode(Cosmetic.self, from: data)
                completion(.success(course))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    private init() {}
}

enum NetworkErrors: Error {
    case invalidUrl
    case noData
    case decodingError
}

//        NetworkManager.shared.fetchData(url: "https:\(item.api_featured_image ?? "")") { result in
//            switch result {
//            case .success(let data):
//                self.productImage.image = UIImage(data: data)
//            case .failure(let error):
//                print(error)
//            }
//        }
