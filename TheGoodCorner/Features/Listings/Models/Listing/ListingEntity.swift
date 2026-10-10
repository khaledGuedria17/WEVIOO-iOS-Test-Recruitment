//
//  ListingEntity.swift
//  TheGoodCorner
//
//  Created by Khaled Guedria on 8/10/2026.
//

struct ListingEntity : Equatable, Identifiable, Hashable {
    //var
    var id:Int?
    var title:String?
    var description:String?
    var price:Int?
    var creationDate:String?
    var isUrgent:Bool?
    var imageSmall : String?
    var imageThumb : String?
    
    var categoryId:Int
    
        //init
    init(id: Int? = nil, title: String? = nil, description: String? = nil, price: Int? = nil, creationDate: String? = nil, isUrgent: Bool? = nil, imageSmall: String? = nil, imageThumb: String? = nil, categoryId: Int) {
        self.id = id
        self.title = title
        self.description = description
        self.price = price
        self.creationDate = creationDate
        self.isUrgent = isUrgent
        self.imageSmall = imageSmall
        self.imageThumb = imageThumb
        self.categoryId = categoryId
    }
}
