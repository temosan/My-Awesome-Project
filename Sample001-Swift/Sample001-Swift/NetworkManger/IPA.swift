//
//  IPA.swift
//  Sample001-Swift
//
//  Created by 박영호 on 2021/01/07.
//

import Foundation

struct IPA: Identifiable, Codable {
    let id: Int
    let version: String
    let build: String
    let downloadURL: String
    let description: String?
}
