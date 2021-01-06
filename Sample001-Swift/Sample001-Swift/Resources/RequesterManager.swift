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


class RequesterManager {
    public static let shared = RequesterManager()
    
    var activeDownloads: [URL: Download] = [:]
    
    var downloadsSession: URLSession!
    
    func startDownload(_ url: URL) {
      let download = Download(url: url)
      download.task = downloadsSession.downloadTask(with: url)
      download.task?.resume()
      download.isDownloading = true
      activeDownloads[download.url] = download
    }
}
