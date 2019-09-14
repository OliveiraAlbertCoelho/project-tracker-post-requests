//
//  Project.swift
//  project-tracker-post-requestsTests
//
//  Created by David Rifkin on 9/10/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation

struct AirtableResponse: Codable {
    let projectWrappers: [ProjectWrapper]
    
    enum CodingKeys: String, CodingKey {
        case projectWrappers = "records"
    }
}

struct ProjectWrapper: Codable {
    let project: Project
    
    enum CodingKeys: String, CodingKey {
        case project = "fields"
    }
}

struct Project: Codable {
    static func getProjects(from jsonData: Data) throws -> [Project] {
        let response = try JSONDecoder().decode(AirtableResponse.self, from: jsonData)
        return response.projectWrappers.map { $0.project }
    }
    
    let name: String
    let dueDate: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case dueDate = "Due date"
    }
}
