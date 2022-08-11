//
//  RepositoryDTO.swift
//  RxSwiftMVVM
//
//  Created by User on 06.08.2022.
//

import Foundation

struct RepositoryDTO: Codable {
    let id: Int
    let nodeId: String
    let name: String
    let fullName: String
    let isPrivate: Bool
    let owner: RepositoryOwnerDTO
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case nodeId = "node_id"
        case name = "name"
        case fullName = "full_name"
        case isPrivate = "private"
        case owner = "owner"
    }
}

