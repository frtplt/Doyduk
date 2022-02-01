//
//  ProductDetailsResponse.swift
//  Doyduk
//
//  Created by Firat on 1.02.2022.
//

import Foundation

struct ProductDetailsResponse: Decodable {
    
    let status: String
    let statusCode: Int
    let result: Product
    let message: String
    
}
