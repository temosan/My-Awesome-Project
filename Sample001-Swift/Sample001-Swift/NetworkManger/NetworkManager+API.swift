//
//  NetworkManager.swift
//  Sample001-Swift
//
//  Created by 박영호 on 2021/01/07.
//

/// 네트워크 매니져에 익스텐션 추가.
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
        NetworkManager.Request.new(urlString: urlString, method: .POST, parameters: ["test":"123"], handler)
    }
    
    class func deleteIPAs(_ handler: NetworkResultHandler<IPAResponse?>?) {
        let urlString = "https://dl.dropboxusercontent.com/s/8a9ouqhnrzac11y/sample_dev.json"
        NetworkManager.Request.new(urlString: urlString, method: .DELETE, handler)
    }
}
