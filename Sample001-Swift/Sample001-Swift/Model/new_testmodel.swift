//
//  New_TestModel.swift
//  Sample001-Swift
//
//  Created by 김희중 on 2021/01/05.
//

import Foundation

struct new_test: Codable {
    var data: [new_test_model]
}

struct new_test_model: Codable {
    var id: Int
    var status: String
    var downloadurl: String
    var description: String
}
