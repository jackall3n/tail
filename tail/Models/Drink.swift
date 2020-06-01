//
//  Cocktail.swift
//  tail
//
//  Created by Jack Allen on 01/06/2020.
//  Copyright © 2020 Jack Allen. All rights reserved.
//

import SwiftUI

struct Drink: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var imageName: String
    var description: String
    var shortDescription: String
    var rating: Float
}

struct DrinkData: Hashable, Codable {
    var trending: [Drink]
    var suggested: [Drink]
}
