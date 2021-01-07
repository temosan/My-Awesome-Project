//
//  IPAResponse.swift
//  AdiscopeSwift-Pods
//
//  Created by mjgu on 2020/11/20.
//

import Foundation

struct IPAResponse: Codable {
    let servers: Server
    
    struct Server: Codable {
        let develop: [IPA]
        let service: [IPA]
    }
}
