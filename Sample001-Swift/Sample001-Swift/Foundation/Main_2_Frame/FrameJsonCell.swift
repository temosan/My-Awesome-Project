//
//  FrameJsonCell.swift
//  Sample001-Swift
//
//  Created by 박영호 on 2021/01/05.
//


import UIKit
import SnapKit

/// 메인 화면 테이블 셀의 데이터 모델
struct FrameCellData: Decodable {
    var id: Int
    var status: String
    var downloadurl: String
    var description: String
}
/// JSON파일 디코드를 위한 구조 구현
struct FrameCellDataes: Decodable {
    var data:[FrameCellData]
}

class FrameJsonCell: UITableViewCell {
    //MARK:- Views
    let id = UILabel()
    let status = UILabel()
    let downloadurl = UILabel()
    let desc = UILabel()
    
    //MARK:- Methoes
    /// 셀에 데이터 넣기
    func mappingData(cellData: FrameCellData) {
        id.text = String(cellData.id)
        status.text = cellData.status
        downloadurl.text = cellData.downloadurl
        desc.text = cellData.description
    }
    
    /// URL문자열을 이미지로 ( String -> URL -> Data -> UIImage )
    func urlStringToImage(urlString: String) -> UIImage? {
        let url = URL(string: urlString)
        var data: Data?
        do {
            data = try Data(contentsOf: url!)
            return UIImage(data: data!)
        } catch {
            print("image URL Error")
        }
        return nil
    }
    
    //MARK:- Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //setupLayout()
        setupLayoutUseFrame()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayoutUseFrame() {
        backgroundColor = .clear
        contentView.addSubViews([id, status, downloadurl, desc])
        
        id.frame = CGRect(x: 10, y: 10, width: 80, height: 80)
        status.frame = CGRect(x: 100, y: 10, width: UIScreen.main.bounds.width - 120, height: 20)
        downloadurl.frame = CGRect(x: 100, y: 40, width: UIScreen.main.bounds.width - 120, height: 20)
        desc.frame = CGRect(x: 100, y: 70, width: UIScreen.main.bounds.width - 120, height: 20)
    }
}
