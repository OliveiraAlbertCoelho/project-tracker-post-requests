//
//  UserApi.swift
//  project-tracker-post-requests
//
//  Created by albert coelho oliveira on 9/13/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation

struct UserApi{

static let manager = UserApi()


func getUser(completionHandler: @escaping (Result<[LogoWrapper], AppError>) -> Void) {
    NetworkHelper.manager.performDataTask(from: airtableURL, httpMethod: .get){ result in
        switch result {
        case let .failure(error):
            completionHandler(.failure(error))
            return
        case let .success(data):
            do {
                let projects = try LogoWrapper.getUsers(from: data)
                completionHandler(.success(projects))
            }
            catch {
                completionHandler(.failure(.couldNotParseJSON(rawError: error)))
            }
        }
    }
}

func postUser (project: LogoWrapper, completionHandler: @escaping (Result<Data, AppError>) -> Void){
    let projectWrapper = UsersWrapper(fields: project)
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
private var airtableURL: URL {
    guard let url = URL(string: "https://api.airtable.com/v0/\(Secrets.APISubPath)/Clients?&view=All%20clients&api_key=" + Secrets.APIKey) else {
        fatalError("Error: Invalid URL")
    }
    return url
}
private init() {}
}

