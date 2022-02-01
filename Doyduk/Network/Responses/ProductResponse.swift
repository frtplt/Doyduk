//
//  ProductResponse.swift
//  Doyduk
//
//  Created by Firat on 1.02.2022.
//

import Foundation

struct ProductResponse: Decodable {
    
    let statusCode: Int
    let result: [Product]
    let message: String
}

struct Product: Decodable {
    
    let id: Int
    let name: String
    let description: String
    let price: Double
    let categoryId: Int
    let imageUrl: URL
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case price
        case categoryId = "category_id"
        case imageUrl = "image_url"
    }
}

