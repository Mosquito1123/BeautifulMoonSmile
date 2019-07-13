//
//  NetworkError.swift
//  BeautifulLunaSmile
//
//  Created by Mosquito1123 on 13/07/2019.
//  Copyright © 2019 Cranberry. All rights reserved.
//

import Foundation

public enum NetworkError: Error {
    case badStatusCode(statusCode: Int)
    case badResponse
    case badJSON
    case noData
    case offline
    case other(Error?)
}

extension NetworkError: LocalizedError {
    public var localizedDescription: String {
        switch self {
        case .badResponse:
            return NSLocalizedString("Bad response object returned", comment: "")
        case .badJSON:
            return NSLocalizedString("Bad JSON object, unable to parse", comment: "")
        case .noData:
            return NSLocalizedString("No response data", comment: "")
        case .offline:
            return NSLocalizedString("No internet connection is available", comment: "")
        case .badStatusCode(let statusCode):
            return "Bad status code returned: \(statusCode)"
        case .other(let error):
            return "NetworkError: \(String(describing: error))"
        }
    }
}
