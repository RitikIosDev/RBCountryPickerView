//
//  Country.swift
//  RBCountryPickerView
//
//  Created by Ritik Bunkar on 27/03/25.
//

import Foundation
class RBCountryPickerResourceFinder: NSObject {}

struct ModelCountry: Codable, Hashable {
    public var name: String
    public var iso3: String
    public var iso2: String
    public var emoji: String
    public var states: [ModelState]
    public var phone_code: String
}
