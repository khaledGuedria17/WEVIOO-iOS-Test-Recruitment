//
//  CategoryDTO.swift
//  TheGoodCorner
//
//  Created by Khaled Guedria on 8/10/2026.
//

struct CategoryDTO : Codable {
    
    //var
    var id:Int?
    var name:String?
    
    //init
    init(id: Int? = nil, name: String? = nil) {
        self.id = id
        self.name = name
    }
    
    
}
