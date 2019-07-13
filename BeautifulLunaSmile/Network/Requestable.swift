//
//  Requestable.swift
//  BeautifulLunaSmile
//
//  Created by Mosquito1123 on 13/07/2019.
//  Copyright © 2019 Cranberry. All rights reserved.
//

import Foundation

typealias Parameters = [String: String]

protocol Requestable {
    var baseURL: URL { get }
    var path: String { get }
    var parameters: Parameters { get }
    
    var request: URLRequest { get }
}
