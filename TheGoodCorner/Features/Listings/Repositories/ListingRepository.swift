//
//  ListingRepository.swift
//  TheGoodCorner
//
//  Created by Khaled Guedria on 9/10/2026.
//

import Foundation

class ListingRepository {
    
    func getListings(data:Data) throws -> [ListingEntity] {
                
        return try JSONDecoder().decode(Listings.self, from: data).items.map { dto in
            ListingMapper.map(dto: dto)
        }
        
    }
}
