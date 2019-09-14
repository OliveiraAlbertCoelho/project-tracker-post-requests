//
//  imageHelper.swift
//  PeopleAndAppleStockPrices
//
//  Created by albert coelho oliveira on 9/5/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
import UIKit
class ImageHelper {
    // Singleton instance to have only one instance in the app of the imageCache
    private init() {}
    static let shared = ImageHelper()
    
    func fetchImage(urlString: URL, completionHandler: @escaping (Result<UIImage,AppError>) -> ()) {
        NetworkHelper.manager.getData(from: urlString){ (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                guard let image = UIImage(data: data) else {completionHandler(.failure(.badURL))
                    return
                }
                completionHandler(.success(image))
            }
        }
    }
}
