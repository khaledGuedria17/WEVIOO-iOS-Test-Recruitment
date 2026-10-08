//
//  ListingDTO.swift
//  TheGoodCorner
//
//  Created by Khaled Guedria on 8/10/2026.
//

struct ListingDTO: Codable {
    var id:Int?
    var title:String?
    var description:String?
    var category_id:Int
    var price:Int?
    var creation_date:String?
    var is_urgent:Bool?
    var images_url:imagesUrl?
    
    //init
    init(id: Int? = nil, title: String? = nil, description: String? = nil, category_id: Int, price: Int? = nil, creation_date: String? = nil, is_urgent: Bool? = nil, images_url: imagesUrl? = nil) {
        self.id = id
        self.title = title
        self.description = description
        self.category_id = category_id
        self.price = price
        self.creation_date = creation_date
        self.is_urgent = is_urgent
        self.images_url = images_url
    }
}


struct imagesUrl: Codable  {
    var small:String?
    var thumb:String?
}
