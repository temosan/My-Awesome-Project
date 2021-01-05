//
//  MyCell.swift
//  Sample001-Swift
//
//  Created by 박영호 on 2021/01/05.
//

import UIKit
import SnapKit

/// 메인 화면 테이블 셀의 데이터 모델
struct CellData: Decodable {
    var image: String
    var title: String
    var description: String
}
/// JSON파일 디코드를 위한 구조 구현
struct CellDataes: Decodable {
    var data:[CellData]
}

class MyCell: UITableViewCell {
    //MARK:- Views
    let picture = UIImageView().then {
        $0.backgroundColor = .blue
        $0.setBorder(cornerRadius: 10)
    }
    let label = UILabel()
    let label2 = UILabel()
    
    //MARK:- Methoes
    /// 셀에 데이터 넣기
    func mappingData(cellData: CellData) {
        picture.image = urlStringToImage(urlString: cellData.image)
        label.text = cellData.title
        label2.text = cellData.description
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
    
//    func setupLayout() {
//        backgroundColor = .clear
//        contentView.addSubViews([picture, label, label2])
//
//        picture.snp.makeConstraints{
//            $0.top.bottom.leading.equalToSuperview().inset(10)
//            $0.width.height.equalTo(70)
//        }
//
//        label.snp.makeConstraints{
//            $0.height.equalTo(30)
//            $0.top.equalToSuperview().offset(10)
//            $0.leading.equalTo(picture.snp.trailing).offset(10)
//        }
//
//        label2.snp.makeConstraints{
//            $0.height.equalTo(30)
//            $0.leading.equalTo(picture.snp.trailing).offset(10)
//            $0.bottom.equalToSuperview().offset(-10)
//        }
//    }
    func setupLayoutUseFrame() {
        backgroundColor = .clear
        contentView.addSubViews([picture, label, label2])
        
        picture.frame = CGRect(x: 10, y: 10, width: 70, height: 70)
        label.frame = CGRect(x: 90, y: 10, width: UIScreen.main.bounds.width - 120, height: 30)
        label2.frame = CGRect(x: 90, y: 50, width: UIScreen.main.bounds.width - 120, height: 30)
    }
}
