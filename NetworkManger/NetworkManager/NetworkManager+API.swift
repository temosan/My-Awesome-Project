//
//  NetworkManager.swift
//  Adiscope_for_Mac
//
//  Created by mjgu on 2020/08/28.
//

import Foundation

struct DefaultModel: Codable { let id: String }
struct DefaultModelResponse: Identifiable, Codable {
    let id: String
    let value: DefaultModel?
}

extension NetworkManager {
    
    class func getIPAs(_ handler: NetworkResultHandler<IPAResponse?>?) {
        let urlString = "https://dl.dropboxusercontent.com/s/8a9ouqhnrzac11y/sample_dev.json"
        NetworkManager.Request.new(urlString: urlString, method: .GET, handler)
    }
    
    class func postIPAs(_ handler: NetworkResultHandler<IPAResponse?>?) {
        let urlString = "https://dl.dropboxusercontent.com/s/8a9ouqhnrzac11y/sample_dev.json"
        NetworkManager.Request.new(urlString: urlString, method: .POST, headers: nil, parameters: ["test":"123"], id: nil, handler)
    }
    
    class func deleteIPAs(_ handler: NetworkResultHandler<IPAResponse?>?) {
        let urlString = "https://dl.dropboxusercontent.com/s/8a9ouqhnrzac11y/sample_dev.json"
        NetworkManager.Request.new(urlString: urlString, method: .DELETE, headers: nil, parameters: nil, id: 10, handler)
    }
}
