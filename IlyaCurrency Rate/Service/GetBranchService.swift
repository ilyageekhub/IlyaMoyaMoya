//
//  GetBranchService.swift
//  IlyaCurrency Rate
//
//  Created by Admin on 21.01.2020.
//  Copyright © 2020 Ilya Ilushenko. All rights reserved.
//

import Foundation
import Moya

class GetBranchService {
    var city: String = ""
    var address: String = ""

    init (city: String, address: String = "") {
        self.city = city
        self.address = address
    }

    func getAllCities(completion: @escaping (_ cities: [String]) -> Void ) {
        request { branches, _ in
            if let branches = branches {
                completion(Array(Set(branches.map { $0.city })))
            } else {
                completion([])
            }
        }
    }

    func request (completion: @escaping (_ branches: Branches?, _ error: Error?) -> Void) {
        let provider = MoyaProvider<PrivateAPI>()
        provider.request(.getBranches(city: city, address: address)) { result in
            switch result {
            case let .success(response):
                let decoder = JSONDecoder()
                do {
                    let responseObject = try decoder.decode(Branches.self, from: response.data)
                    completion(responseObject, nil)
                } catch {
                    completion(nil, error)
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
