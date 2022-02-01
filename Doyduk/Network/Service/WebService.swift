//
//  WebService.swift
//  Doyduk
//
//  Created by Firat on 1.02.2022.
//

import Foundation

struct WebService {
    
    func getCategory(completion: @escaping (_ categoryResponse: CategoryResponse) -> Void) {
        
        let urlString = URL(string: "http://159.223.0.153/categories")!
        
        URLSession.shared.dataTask(with: urlString) { data, response, error in
            if let data = data {
                let result = try! JSONDecoder().decode(CategoryResponse.self, from: data)
                completion(result)
            }
        }.resume()
    }
    
    func getProduct(completion: @escaping (_ productResponse: ProductResponse) -> Void) {
        
        let urlString = URL(string: "http://159.223.0.153/dishes")!
        
        URLSession.shared.dataTask(with: urlString) { data, response, error in
            
            if let data = data {
                let result = try! JSONDecoder().decode(ProductResponse.self, from: data)
                completion(result)
            }
        }.resume()
        
    }
    
    func getProductDetails(id: Int, completion: @escaping (_ productDetailsResponse: ProductDetailsResponse) -> Void) {
        
        let urlString = "http://159.223.0.153/dishes/\(id)"
        let url = URL(string: urlString)!
        
        let request = URLRequest(url: url)
        
        let urlSession = URLSession.shared
        
        urlSession.dataTask(with: request) { data, response, error in
            
            let decoder = JSONDecoder()
            let productsResponse = try! decoder.decode(ProductDetailsResponse.self, from: data!)
            completion(productsResponse)
            
        }.resume()
    }

}
