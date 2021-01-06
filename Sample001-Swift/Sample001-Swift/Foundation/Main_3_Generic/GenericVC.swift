//
//  GenericVC.swift
//  Sample001-Swift
//
//  Created by 박영호 on 2021/01/06.
//

import UIKit

enum loadJsonError: Error {
    /// 파일명으로 URL을 구할 때 에러 발생
    case filenameToUrl
    /// URL을 Data로 바꿀 때 에러 발생
    case urlToData
    /// Data를 실제 값 배열로 바꿀 때 에러 발생
    case dataToValue
}

class GenericVC: UIViewController {

    //MARK:- Params
    /// 테이블에 그려질 데이터
    let fileName = "frameJson"
    var dataes: FrameCellDataes!
    
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
        let result = loadJson(FrameCellDataes.self, filename: fileName)
        switch result {
        case .success(let dataes):
            self.dataes = dataes
        case .failure(let error):
            print(error)
        }
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
    func loadJson<T : Decodable>(_ type: T.Type, filename fileName: String) -> Result<T, loadJsonError> {
        /// 파일이름 -> URL
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            return .failure(.filenameToUrl)
        }
        
        /// URL -> Data
        let data: Data
        do { data = try Data(contentsOf: url)}
        catch { return .failure(.urlToData) }
        
        /// Data -> T타입 값
        let decoder = JSONDecoder()
        let jsonData: T
        do { jsonData = try decoder.decode(type, from: data) }
        catch { return .failure(.dataToValue)}
        
        return .success(jsonData)
    }
}


extension GenericVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataes.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FrameJsonCell.self)) as! FrameJsonCell
        cell.mappingData(cellData: dataes.data[indexPath.row])
        return cell
    }
}

