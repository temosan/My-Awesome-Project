//
//  RequestCell.swift
//  Sample001-Swift
//
//  Created by 박영호 on 2021/01/06.
//

import UIKit

/// 메인 화면 테이블 셀의 데이터 모델
struct RequestCellData: Decodable {
    let id: Int
    let version: String
    let build: String
    let downloadURL: String
    let description: String
}
/// JSON파일 디코드를 위한 구조 구현
struct Servers: Decodable {
    let develop:[RequestCellData]
    let service:[RequestCellData]
}
struct RequestCellDataes: Decodable {
    let servers: Servers
}

protocol CellDelegate {
    func downloadTapped(_ cell: RequestCell)
}



class RequestCell: UITableViewCell {
    //MARK:- Views
    
    var delegate: CellDelegate!
    
    private let id = UILabel()
    private let version = UILabel()
    private let build = UILabel()
    private let desc = UILabel()
    lazy var downloadButton = UIButton().then {
        $0.setTitle("다운로드", for: .normal)
        $0.setBorder(borderWidth: 1, borderColor: .black, cornerRadius: 5, maskToBounds: true)
        $0.addTarget(self, action: #selector(buttonPress), for: .touchUpInside)
    }
    
    @objc func buttonPress() {
        delegate.downloadTapped(self)
    }
    
    // Setter
    var requestCellData: RequestCellData? {
        didSet {
            guard let data = requestCellData else { return }
            id.text = "id:" + String(data.id)
            version.text = "version:" + data.version
            build.text = "build: " + data.build
            desc.text = data.description
        }
    }
    
    //MARK:- Methoes
    /// 셀에 데이터 넣기
    func mappingData(cellData: RequestCellData, downloaded: Bool, download: Download?) {
        requestCellData = cellData
        
        if let download = download {
            if download.isDownloading {
                downloadButton.setTitle("다운로드 중", for: .normal)
            }
        }
    }
    
    //MARK:- Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        backgroundColor = .clear
        contentView.addSubViews([id, version, build, downloadButton, desc])
        let screenWidth = UIScreen.main.bounds.width
        
        id.snp.makeConstraints{
            $0.top.leading.equalToSuperview().inset(10)
            $0.height.equalTo(20)
            $0.width.equalTo((screenWidth - 140) / 2)
        }

        build.snp.makeConstraints{
            $0.top.equalToSuperview().inset(10)
            $0.trailing.equalTo(downloadButton.snp.leading).offset(-10)
            $0.height.equalTo(20)
            $0.width.equalTo((screenWidth - 140) / 2)
        }
        
        version.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(10)
            $0.top.equalTo(id.snp.bottom)
            $0.height.equalTo(20)
            $0.width.equalTo(screenWidth - 140)
        }

        desc.snp.makeConstraints{
            $0.height.equalTo(20)
            $0.bottom.leading.trailing.equalToSuperview().inset(10)
        }
        downloadButton.snp.makeConstraints{
            $0.height.equalTo(50)
            $0.width.equalTo(80)
            $0.top.trailing.equalToSuperview().inset(10)
        }
    }
}
