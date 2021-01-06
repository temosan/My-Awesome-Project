//
//  URL_Session_model .swift
//  Sample001-Swift
//
//  Created by 김희중 on 2021/01/06.
//

import Foundation

struct URL_Session_model: Codable {
    var servers: servers?
}

struct servers: Codable {
    var develop: [info]
    var service: [info]
}

struct info: Codable {
    var id: Int
    var version: String
    var build: String
    var downloadURL: String
    var description: String
}
