//
//  CategoryModelTests.swift
//  TheGoodCorner
//
//  Created by Khaled Guedria on 8/10/2026.
//

import XCTest
@testable import TheGoodCorner

class CategoryModelTests: XCTestCase {
    
    //Locally : DTO XCTest
    func test_decodeCategoryDTO() throws {
       
        let json = """
    {
        "id": 1,
        "name":"Category 1"
        
    }
    """.data(using: .utf8)!
        
        //decode
        let categoryDTO = try JSONDecoder().decode(CategoryDTO.self, from: json)
        //assertion
        XCTAssertEqual(categoryDTO.id, 1)
        XCTAssertEqual(categoryDTO.name, "Category 1")
    }
    
    //Locally : Mapper + Entity XCTest
    func test_Map2CategoryEntity() throws {
       
        let dto = CategoryDTO(id: 99, name: "Category 99")
        
        //map
        let entity = CategoryMapper.map(dto: dto)
        
        //assertion
        XCTAssertEqual(entity.id, 99)
        XCTAssertEqual(entity.name, "Category 99")
    }
    
    //Network : DTO + Mapper + Entity XCTest
    func test_getCategories() async throws {
               
        //categories
        let entities = try await CategoryRepository().getCategories(data: CategoryService().fetch())
        
        //assertion
        XCTAssertEqual(entities.first?.id, 1)
        XCTAssertEqual(entities.first?.name, "Véhicule")
    }
}
