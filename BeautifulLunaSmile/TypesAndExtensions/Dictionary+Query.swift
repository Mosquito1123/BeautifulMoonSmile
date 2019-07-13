//
//  Dictionary+Query.swift
//  BeautifulLunaSmile
//
//  Created by Mosquito1123 on 13/07/2019.
//  Copyright © 2019 Cranberry. All rights reserved.
//

import Foundation
extension Dictionary where Key == String, Value == String {
    var queryString: String {
        return keys.reduce("") { (string, key) -> String in
            let prefix = (string == "") ? "" : "&"
            guard let value = self[key] else { fatalError("missing value") }
            return "\(string)\(prefix)\(key)=\(value)"
        }
    }
}
