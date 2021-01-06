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
    
    private let id = UILabel()
    private let status = UILabel()
    private let downloadurl = UILabel()
    private let desc = UILabel()
    
    
    // Setter
    var frameCellData: FrameCellData? {
        didSet {
            id.text = String(frameCellData.id)
            status.text = frameCellData.status
            downloadurl.text = frameCellData.downloadurl
            desc.text = frameCellData.description
        }
    }
    
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
    
    /// URL문자열을 이미지로 변경
    /// guard문으로 교체 할 경우에는 가독성이 더 나아 보입니다.
    /// - Parameter urlString: Image URL String
    /// - Returns: UIImage of URL Parameter
    private func guardUrlStringToImage(urlString: String) -> UIImage? {
        guard
            let url = URL(string: urlString),
            let data = try? Data(contentsOf: url)
        else { return nil }
        
        return UIImage(data: data)
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
        
        /// Recommend
        let sideMargin: CGFloat = 10
        let verticalSpacing: CGFloat = 10
        
        var newFrame = CGRect(x: id.frame.maxX, y: verticalSpacing,
                              width: UIScreen.main.bounds.width, height: 20)
        newFrame.origin.x += id.frame.maxX
        newFrame.size.width -= sideMargin * 2
    }
}
