//
//  LinstingModelTests.swift
//  TheGoodCorner
//
//  Created by Khaled Guedria on 8/10/2026.
//

import XCTest
@testable import TheGoodCorner

class ListingModelTests: XCTestCase {
    
    //DTO XCTest
    func test_decodeListingDTO() throws {
       
        let json = """
        {
          "images_url": {
            "small": "/images/ad-small/5877f940762daca3548cb19d89324098fb116356.jpg",
            "thumb": "/images/ad-thumb/5877f940762daca3548cb19d89324098fb116356.jpg"
          },
          "description": "A vendre 1 vinyle de  Elliott Murphy Just A Story From America, en bon état remis en main propre. Pressage hollandais 1977, CBS – 81881",
          "price": 10,
          "category_id": 7,
          "title": "Vinyle Elliott Murphy Just A Story From America",
          "is_urgent": true,
          "creation_date": "2019-11-06T11:22:35Z",
          "id": 1547408955
        }
    """.data(using: .utf8)!
        
        //decode
        let dto = try JSONDecoder().decode(ListingDTO.self, from: json)
        //assertion
        XCTAssertEqual(dto.id, 1547408955)
        XCTAssertEqual(dto.title, "Vinyle Elliott Murphy Just A Story From America")
        XCTAssertEqual(dto.description, "A vendre 1 vinyle de  Elliott Murphy Just A Story From America, en bon état remis en main propre. Pressage hollandais 1977, CBS – 81881")
        XCTAssertEqual(dto.price, 10)
        XCTAssertEqual(dto.category_id, 7)
        XCTAssertEqual(dto.is_urgent, true)
        XCTAssertEqual(dto.creation_date, "2019-11-06T11:22:35Z")
        XCTAssertEqual(dto.images_url?.small, "/images/ad-small/5877f940762daca3548cb19d89324098fb116356.jpg")
        XCTAssertEqual(dto.images_url?.thumb, "/images/ad-thumb/5877f940762daca3548cb19d89324098fb116356.jpg")

    }
    
    //Mapper + Entity XCTest
    func test_Map2ListingEntity() throws {
       
        let dto = ListingDTO(
            id: 1547408955,
            title: "Vinyle Elliott Murphy Just A Story From America",
            description: "A vendre 1 vinyle de  Elliott Murphy Just A Story From America, en bon état remis en main propre. Pressage hollandais 1977, CBS – 81881",
            category_id: 7,
            price: 10,
            creation_date: "2019-11-06T11:22:35Z",
            is_urgent: true,
            images_url: imagesUrl(
                small: "/images/ad-small/5877f940762daca3548cb19d89324098fb116356.jpg",
                thumb: "/images/ad-thumb/5877f940762daca3548cb19d89324098fb116356.jpg")
        )
        
        //map
        let entity = ListingMapper.map(dto: dto)
        
        //assertion
        XCTAssertEqual(entity.price, 10)
        XCTAssertEqual(entity.categoryId, 7)
        XCTAssertEqual(entity.isUrgent, true)
        XCTAssertEqual(entity.creationDate, "2019-11-06T11:22:35Z")
        XCTAssertEqual(entity.imageSmall, "/images/ad-small/5877f940762daca3548cb19d89324098fb116356.jpg")
        XCTAssertEqual(entity.imageThumb, "/images/ad-thumb/5877f940762daca3548cb19d89324098fb116356.jpg")
    }
}
