//
//  CategoryRepository.swift
//  TheGoodCorner
//
//  Created by Khaled Guedria on 8/10/2026.
//

import Foundation

class CategoryRepository {
    
    static func getCategories(data:Data) throws -> [CategoryEntity] {
                
        return try JSONDecoder().decode([CategoryDTO].self, from: data).map { dto in
            CategoryMapper.map(dto: dto)
        }
        
    }
}
