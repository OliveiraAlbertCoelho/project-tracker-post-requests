//
//  UserModel.swift
//  project-tracker-post-requests
//
//  Created by albert coelho oliveira on 9/13/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation

struct UserModel: Codable{
    let records: [UsersWrapper]
  
}
struct UsersWrapper: Codable{
    let fields: LogoWrapper
}
struct LogoWrapper:Codable {
    let About: String
    let Name: String
    let logo: [LogoImage]?
    static func getUsers(from jsonData: Data) throws ->
        [LogoWrapper]{
            let response = try JSONDecoder().decode(UserModel.self, from: jsonData)
            return response.records.map {$0.fields}
    }
}

struct LogoImage: Codable {
    let url: String?
}
