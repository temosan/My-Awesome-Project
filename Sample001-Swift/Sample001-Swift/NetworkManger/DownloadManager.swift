//
//  RequesterManager.swift
//  Sample001-Swift
//
//  Created by 박영호 on 2021/01/06.
//

import UIKit
import Foundation

class Download {
    var isDownloading = false
    var progress: Float = 0
    var resumeData: Data?
    var task: URLSessionDownloadTask?
    var url: URL
    init(url: URL) {
        self.url = url
    }
}


class DownloadManager {
    public static let shared = DownloadManager()

    var activeDownloads: [URL: Download] = [:]

    var downloadsSession: URLSession!

    func startDownload(_ url: URL) {
      let download = Download(url: url)
      download.task = downloadsSession.downloadTask(with: url)
      download.task?.resume()
      download.isDownloading = true
      activeDownloads[download.url] = download
    }

    /**
     서버 JSON 파일 읽어오기
     - parameters:
        - type : 리턴 타입
        - urlString : 서버의 JSON파일 URL 문자열
     */
    func loadServerJson<T : Decodable>(_ type: T.Type, urlString: String, completion: @escaping (Result<T, loadJsonError>) -> Void) {
        /// URLString -> URL
        guard let url = URL (string : urlString) else {
            return completion(.failure(.filenameToUrl))
        }

        /// URLSession을 이용하여 URL로 서버 Data 받아오기
        URLSession.shared.dataTask (with : url) {data, response, error in
            /// 데이터 정상 수신
            if let data = data {
                /// Data -> T타입 값
                let decoder = JSONDecoder()
                guard let jsonData = try? decoder.decode(type, from: data) else {
                    return completion(.failure(.dataToValue))
                }
                return completion(.success(jsonData))
            } else {
                return completion(.failure(.urlToData))
            }
        }.resume ()
    }
}





