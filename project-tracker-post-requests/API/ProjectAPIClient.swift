//
//  ProjectAPIClient.swift
//  project-tracker-post-requests
//
//  Created by David Rifkin on 9/12/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation

struct ProjectAPIClient {
    
    // MARK: - Static Properties
    
    static let manager = ProjectAPIClient()
    
    // MARK: - Internal Methods
    
    func getProjects(completionHandler: @escaping (Result<[Project], AppError>) -> Void) {
        NetworkHelper.manager.performDataTask(from: airtableURL, httpMethod: .get){ result in
            switch result {
            case let .failure(error):
                completionHandler(.failure(error))
                return
            case let .success(data):
                do {
                    let projects = try Project.getProjects(from: data)
                    completionHandler(.success(projects))
                }
                catch {
                    completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                }
            }
        }
    }
    
    func postProject (project: Project, completionHandler: @escaping (Result<Data, AppError>) -> Void){
        let projectWrapper = ProjectWrapper(project: project)
        guard let encodedProjectWrapper = try?
            JSONEncoder().encode(projectWrapper)else {
                fatalError()
        }
        NetworkHelper.manager.performDataTask(from: airtableURL, httpMethod: .post, data: encodedProjectWrapper) { result in
            switch result {
            case .success(let data):
                completionHandler(.success(data))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    // MARK: - Private Properties and Initializers
    
    private var airtableURL: URL {
        guard let url = URL(string: "https://api.airtable.com/v0/\(Secrets.APISubPath)/Design%20projects?typecast=true&&api_key=" + Secrets.APIKey) else {
            fatalError("Error: Invalid URL")
        }
        return url
    }
    
    private init() {}
}
