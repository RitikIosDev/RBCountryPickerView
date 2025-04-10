//
//  State.swift
//  RBCountryPickerView
//
//  Created by Ritik Bunkar on 28/03/25.
//

import Foundation

struct ModelState: Codable, Hashable {
public   var id: Int
public var name: String
public var type: String?
public var state_code: String
}
