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
        parseJSON()
        mainTableView.register(New_TableViewCell.self, forCellReuseIdentifier: cellid)
    }
    
    fileprivate func setupLayouts() {
        view.addSubview(mainTableView)
        mainTableView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
    }
    
    var testData = [new_test_model]()
    
    fileprivate func parseJSON() {
        if let path = Bundle.main.path(forResource: "new_test", ofType: "json") {
            let url = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: url) {
                let decoder = JSONDecoder()
                do {
                    let jsonResults = try decoder.decode(new_test.self, from: data)
                    testData = jsonResults.data
                    self.mainTableView.reloadData()
                } catch {
                    print(error)
                }
            }
        }
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as! New_TableViewCell
        cell.data = testData[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
    
}
