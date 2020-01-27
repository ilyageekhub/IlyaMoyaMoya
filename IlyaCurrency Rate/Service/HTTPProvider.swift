//
//  HTTPProvider.swift
//  IlyaCurrency Rate
//
//  Created by Admin on 27.01.2020.
//  Copyright © 2020 Ilya Ilushenko. All rights reserved.
//

import Foundation
import Moya

enum PrivateAPI {
    case getRate(coursID: Int)
    case getBranches(city: String, address: String)
}

extension PrivateAPI: TargetType {
    var sampleData: Data {
        return Data()
    }
    var headers: [String: String]? {
        return nil
    }
    var method: Moya.Method {
        .get
    }
    var baseURL: URL {
        return URL(string: "https://api.privatbank.ua/p24api/")!
    }
    var path: String {
        switch self {
        case .getRate:
            return "pubinfo"
        case .getBranches:
            return "pboffice"
        }
    }
    var task: Task {
        switch self {
        case .getRate(let coursID):
            return .requestParameters(parameters: ["exchange": "",
                                                   "json": "",
                                                   "coursid": coursID],
                                      encoding: URLEncoding.queryString)
        case let .getBranches(city, address):
            return .requestParameters(parameters: ["json": "",
                                                   "city": city,
                                                   "address": address],
                                      encoding: URLEncoding.queryString)
        }
    }
}
