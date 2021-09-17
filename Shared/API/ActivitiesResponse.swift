//
//  ActivitiesResponse.swift
//  Qapital Activities
//
//  Created by Konstantin Zyrianov on 2021-09-14.
//

import Foundation

struct ActivitiesResponse: Decodable {
    let oldest: Date
    let activities: [Activity]
}
