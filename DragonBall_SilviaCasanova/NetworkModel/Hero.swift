//
//  Hero.swift
//  DragonBall_SilviaCasanova
//
//  Created by Silvia Casanova Martinez on 23/9/23.
//

import Foundation


struct Hero: Decodable, Equatable {
    let id: String
    let name: String
    let description: String
    let photo: URL
    let favorite: Bool
}
