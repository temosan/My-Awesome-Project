//
//  FrameJsonVC.swift
//  Sample001-Swift
//
//  Created by 박영호 on 2021/01/05.
//

import UIKit
import Then
import SnapKit

class FrameJsonVC: UIViewController {
    //MARK:- Params
    /// 테이블에 그려질 데이터
    let fileName = "frameJson"
    var dataes:[FrameCellData] = []
    
    //MARK:- Views
    /// 화면 중앙 메인 테이블뷰
    var tableView = UITableView().then {
        $0.register(FrameJsonCell.self, forCellReuseIdentifier: String(describing: FrameJsonCell.self))
        $0.setBorder(cornerRadius: 10)
    }
    
    //MARK:- Init
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupLayoutUseFrame()
    }
    
    
    /// 초기 세팅
    func configure() {
        tableView.delegate = self
        tableView.dataSource = self
        dataes = loadJson(filename: fileName) ?? []
    }
       
    /// 레이아웃 세팅(프레임으로)
    func setupLayoutUseFrame() {
        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemPink
        
        view.addSubview(tableView)
    }
    /// safeArea가 정해진 후 테이블 뷰 레이아웃 ( 프레임으로 레이아웃 잡기 )
    override func viewSafeAreaInsetsDidChange() {
        let screenWidth = UIScreen.main.bounds.width
        let safeTopHeight = view.safeAreaLayoutGuide.layoutFrame.minY
        let safeFrameHeight = view.safeAreaLayoutGuide.layoutFrame.maxY - safeTopHeight
        tableView.frame = CGRect(x: 10, y: safeTopHeight, width: screenWidth - 20, height: safeFrameHeight)
    }
    
    
    /**
     JSON 파일 읽어오기
     - parameters:
        - filename : 확장자를 제외한 JSON파일 이름
     */
    func loadJson(filename fileName: String) -> [FrameCellData]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(FrameCellDataes.self, from: data)
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


extension FrameJsonVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FrameJsonCell.self)) as! FrameJsonCell
        cell.frameCellData = dataes[indexPath.row]
//        cell.mappingData(cellData: dataes[indexPath.row])
        return cell
    }
}

