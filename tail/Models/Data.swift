//
//  Data.swift
//  tail
//
//  Created by Jack Allen on 01/06/2020.
//  Copyright © 2020 Jack Allen. All rights reserved.
//

import Foundation

let drinkData: DrinkData = load("drinks.json")

func load<T: Decodable>(_ filename: String, as type: T.Type = T.self) -> T {
    let data: Data;

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
            else {
        fatalError("Couldn't find \(filename) in main bundle")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename): \(error)")
    }

    do {
        let decoder = JSONDecoder()

        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't decode \(filename): \(error)")

    }
}
