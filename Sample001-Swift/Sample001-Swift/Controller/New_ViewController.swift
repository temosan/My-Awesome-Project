//
//  New_ViewController.swift
//  Sample001-Swift
//
//  Created by 김희중 on 2021/01/05.
//

import UIKit

class New_ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    fileprivate let cellid = String(describing: mainCollectionViewCell())

    lazy var mainTableView: UITableView = {
        let tv = UITableView()
        tv.dataSource = self
        tv.delegate = self
        return tv
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayouts()
        
//        mainTableView.register(New_TableViewCell.self, forCellReuseIdentifier: cellid)
        
        // 만약 추가로 확장되었을 경우
        let cells = [New_TableViewCell.self]
        cells.forEach { (cell) in
            mainTableView.register(cell.self, forCellReuseIdentifier: String(describing: cell))
        }
        
        getData()
    }
    
    fileprivate func setupLayouts() {
        view.addSubview(mainTableView)
        mainTableView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
    }
    
    var testData = [new_test_model]()
    
    // getData function에서 codable 모델과 json 파일을 명시해주고, 결과를 받아옵니다.
    fileprivate func getData() {
        parseJSON(type: new_test_models(), resource: "new_test") { (result) in
            switch result {
            case .success(let json):
                guard let data = json.data else {return}
                self.testData = data
                self.mainTableView.reloadData()
            case .failure(let message):
                print(message)
            }
        }
  
    }
    // json 파서에 제네릭 사용과 Result 타입 사용 하였습니다.
    fileprivate func parseJSON<T: Codable>(type: T, resource: String, completion: @escaping (Result<T,Error>) -> ()) {
        if let path = Bundle.main.path(forResource: resource, ofType: "json") {
            let url = URL(fileURLWithPath: path)
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonResults = try decoder.decode(T.self, from: data)
                completion(.success(jsonResults))
                
                } catch {
                    completion(.failure(error))
                }
            }
    }
    
    public enum ParseError: Error {
        case notFoundFile
        case jsonSyntaxError
    }
    
    /// parseJSON을 guard로 바꾼 method
    /// - Parameters:
    ///   - type: object Type
    ///   - resource: bundle resouce name
    ///   - completion: handler
    /// - Returns: -
    public class func guardParseJSON<T: Codable>(type: T, resource: String, completion: @escaping (Result<T,Error>) -> ()) {
        guard
            let path = Bundle.main.path(forResource: resource, ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path))
        else {
            completion(.failure(ParseError.notFoundFile))
            return
        }
        
        guard let object = try? JSONDecoder().decode(T.self, from: data) else {
            completion(.failure(ParseError.jsonSyntaxError))
            return
        }
        
        completion(.success(object))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = String(describing: New_TableViewCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! New_TableViewCell
        cell.data = testData[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
