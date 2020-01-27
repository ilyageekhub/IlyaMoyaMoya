//
//  GetRatesService.swift
//  IlyaCurrency Rate
//
//  Created by Admin on 21.01.2020.
//  Copyright © 2020 Ilya Ilushenko. All rights reserved.
//

import Foundation
import Moya

class GetRatesService {

    var coursID: Int = 11

    init (coursID: Int = 11) {
        self .coursID = coursID
    }

    func request (completion: @escaping (_ rates: Rates?, _ error: Error?) -> Void) {
        let provider = MoyaProvider<PrivateAPI>()
        provider.request(.getRate(coursID: coursID)) { result in
            switch result {
            case let .success(response):
                let decoder = JSONDecoder()
                do {
                    let responseObject = try decoder.decode(Rates.self, from: response.data)
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
