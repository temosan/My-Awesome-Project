//
//  MyViewController.swift
//  Sample001-Swift
//
//  Created by 박영호 on 2021/01/04.
//

import UIKit
import Then
import SnapKit

class MyViewController_Frame: UIViewController {
    //MARK:- Params
    /// 테이블에 그려질 데이터
    let fileName = "test"
    var dataes:[CellData] = []
    
    //MARK:- Views
    /// 화면 중앙 메인 테이블뷰
    var tableView = UITableView().then {
        $0.register(MyCell.self, forCellReuseIdentifier: String(describing: MyCell.self))
        $0.setBorder(cornerRadius: 10)
    }
    
    //MARK:- Init
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupLayout()
    }

    /// 초기 세팅
    func configure() {
        tableView.dataSource = self
        dataes = loadJson(filename: fileName) ?? []
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
    
    /**
     JSON 파일 읽어오기
     - parameters:
        - filename : 확장자를 제외한 JSON파일 이름
     */
    func loadJson(filename fileName: String) -> [CellData]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(CellDataes.self, from: data)
                return jsonData.data
            } catch {
                print("error:\(error)")
            }
        } else {
            print("func loadJson ERROR!!")
        }
        return nil
    }
}


extension MyViewController_Frame: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell") as! MyCell
        cell.mappingData(cellData: dataes[indexPath.row])
        return cell
    }
}

