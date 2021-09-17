//
//  Activity.swift
//  Qapital Activities
//
//  Created by Konstantin Zyrianov on 2021-09-14.
//

import Foundation

struct Activity: Decodable {
    
    let message: String
    let amount: Double
    let userId: Int
    let timestamp: Date
}
