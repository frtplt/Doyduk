//
//  CategoryResponse.swift
//  Doyduk
//
//  Created by Firat on 1.02.2022.
//

import Foundation

struct CategoryResponse: Decodable {
    
    let status: String
    let statusCode: Int
    let result: [Category]
    let message: String
    
}

struct Category: Decodable {
    
    let id: Int
    let name: String
    let prefix: String
    let imageUrl: URL
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case name
        case prefix
        case imageUrl = "img_url"
    }
}
