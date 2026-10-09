//
//  NetworkingProtocol.swift
//  TheGoodCorner
//
//  Created by Khaled Guedria on 8/10/2026.
//
import Foundation

protocol NetworkingProtocol {
    
     func fetch() async throws -> Data
}
