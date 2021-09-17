//
//  User.swift
//  Qapital Activities
//
//  Created by Konstantin Zyrianov on 2021-09-14.
//

import Foundation

struct User: Decodable, Equatable {
    let userId: Int
    let displayName: String
    let avatarUrl: URL
}
