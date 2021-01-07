//
//  IPAResponse.swift
//  Sample001-Swift
//
//  Created by 박영호 on 2021/01/07.
//

import Foundation

struct IPAResponse: Codable {
    let servers: Server
    
    struct Server: Codable {
        let develop: [IPA]
        let service: [IPA]
    }
}
