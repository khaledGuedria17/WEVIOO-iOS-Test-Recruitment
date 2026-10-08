//
//  ListingMapper.swift
//  TheGoodCorner
//
//  Created by Khaled Guedria on 8/10/2026.
//

struct ListingMapper {
    
    static func map(dto:ListingDTO) -> ListingEntity {
        return ListingEntity(id: dto.id, title: dto.title, description: dto.description, price: dto.price, creationDate: dto.creation_date, isUrgent: dto.is_urgent, imageSmall: dto.images_url?.small, imageThumb: dto.images_url?.thumb, categoryId: dto.category_id)
    }
}
