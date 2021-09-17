//
//  CustomDateJSONDecoder.swift
//  Qapital Activities
//
//  Created by Konstantin Zyrianov on 2021-09-15.
//

import Foundation

final class ISO8601JSONDecoder: JSONDecoder {
    
    override init() {
        super.init()
        self.dateDecodingStrategy = .formatted(DateHelper.dateFormatter)
    }
}
