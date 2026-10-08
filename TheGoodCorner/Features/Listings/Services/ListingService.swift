//
//  ListingsService.swift
//  TheGoodCorner
//
//  Created by Khaled Guedria on 8/10/2026.
//

import Foundation

class ListingService: NetworkingProtocol {
    //get all : Listing
    static func fetch() async throws -> Data {
        let (data, _) = try await URLSession.shared.data(from: URL(string: Utilities.BASE_URL + "/listings")!)
            return data
    }
    
}
