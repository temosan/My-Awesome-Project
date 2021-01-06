//
//  RequestVC.swift
//  Sample001-Swift
//
//  Created by 박영호 on 2021/01/06.
//

import UIKit

class RequestVC: UIViewController {

    //MARK:- Params
    /// 테이블에 그려질 데이터
    let fileName = "servers"
    var dataes: RequestCellDataes!
    
    /// 델리게이트 설정
    lazy var downloadsSession: URLSession = {
    let configuration = URLSessionConfiguration.default

    return URLSession(configuration: configuration,
                        delegate: self,
                        delegateQueue: nil)
    }()
    
    //MARK:- Views
    /// 화면 중앙 메인 테이블뷰
    var tableView = UITableView().then {
        $0.register(RequestCell.self, forCellReuseIdentifier: String(describing: RequestCell.self))
        $0.setBorder(cornerRadius: 10)
    }
    
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupLayout()
        /// JSON 데이터 읽기
        loadData()
        
        /// 델리게이트 설정하고 넘겨주기
        RequesterManager.shared.downloadsSession = downloadsSession
    }
        
    //MARK:- Methoes
    /// 데이터 받아와서 테이블에 뿌려주기
    func loadData() {
        Utilities.shared.loadJson(RequestCellDataes.self, filename: fileName) { [weak self] result in
            switch result {
            case .success(let dataes):
                self?.dataes = dataes
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    /// 초기 세팅
    func configure() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    /// 레이아웃 세팅
    func setupLayout() {
        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemPink

        view.addSubview(tableView)

        tableView.snp.makeConstraints{
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(10)
        }
    }
}


extension RequestVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataes.servers.develop.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RequestCell.self)) as! RequestCell
        cell.delegate = self
        cell.mappingData(cellData: dataes.servers.develop[indexPath.row], downloaded: false, download: RequesterManager.shared.activeDownloads[URL(string:dataes.servers.develop[indexPath.row].downloadURL)!])
        return cell
    }
}

extension RequestVC: URLSessionDownloadDelegate {
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask,
            didFinishDownloadingTo location: URL) {
        guard let sourceURL = downloadTask.originalRequest?.url else {
            return
        }

        let download = RequesterManager.shared.activeDownloads[sourceURL]
        RequesterManager.shared.activeDownloads[sourceURL] = nil
        
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask,
                    didWriteData bytesWritten: Int64, totalBytesWritten: Int64,
                    totalBytesExpectedToWrite: Int64) {
        print("다운로드 진행률 : \(Float(totalBytesWritten) / Float(totalBytesExpectedToWrite))")
    }
}

extension RequestVC: CellDelegate {
    func downloadTapped(_ cell: RequestCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            let cellData = dataes.servers.develop[indexPath.row]
            
            ///JSON의 URL들이 문제인듯..?
            //guard let url = URL(string: cellData.downloadURL) else { return }
            ///정상적인 URL 넣으니까 작동함. (테일러 스위프트 음원임)
            guard let url = URL(string: "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview118/v4/29/a7/3c/29a73c87-754b-3ed9-32ee-c2debff14693/mzaf_7473464556302093883.plus.aac.p.m4a") else { return }
            RequesterManager.shared.startDownload(url)
            
            tableView.reloadRows(at: [indexPath], with: .none)
        }
    }
}
