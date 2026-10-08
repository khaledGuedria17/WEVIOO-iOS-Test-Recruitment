//
//  CategoryMapper.swift
//  TheGoodCorner
//
//  Created by Khaled Guedria on 8/10/2026.
//

struct CategoryMapper {
    
    static func map(dto:CategoryDTO) -> CategoryEntity {
        return CategoryEntity(id: dto.id, name: dto.name)
    }
}
