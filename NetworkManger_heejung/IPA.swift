//
//  IPA.swift
//  AdiscopeSwift-Pods
//
//  Created by mjgu on 2020/11/20.
//

import Foundation

struct IPA: Identifiable, Codable {
    let id: Int
    let version: String
    let build: String
    let downloadURL: String
    let description: String?
}
