//
//  ViewController.swift
//  Sample001-Swift
//
//  Created by mjgu on 2021/01/05.
//

import UIKit
import SnapKit
import SwiftyJSON

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    fileprivate let cellid = String(describing: mainCollectionViewCell())
    
    lazy var mainCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .white
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        mainCollectionView.register(mainCollectionViewCell.self, forCellWithReuseIdentifier: cellid)
        
        setupLayouts()
        parseJSON()
        
    }
    
    fileprivate func setupLayouts() {
        view.addSubview(mainCollectionView)
        
        mainCollectionView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            if #available(iOS 11, *) {
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            }
            else {
                make.top.equalToSuperview()
                make.bottom.equalToSuperview()
            }

        }
    }
    
    var testData = [testModel]()
    
    fileprivate func parseJSON() {
        if let path = Bundle.main.path(forResource: "test", ofType: "json") {
            let url = URL(fileURLWithPath: path)
            do {
                let data = try Data(contentsOf: url)
                let json = try JSON(data: data)
                let jsonArray = json["data"].arrayValue

                for data in jsonArray {
                    let image = data["image"].stringValue
                    let label1 = data["title"].stringValue
                    let label2 = data["description"].stringValue
                    let test = testModel()
                    test.image = image
                    test.label1 = label1
                    test.label2 = label2
                    
                    testData.append(test)
                    self.mainCollectionView.reloadData()
                }
                

            } catch let error {
                print("parse error: \(error.localizedDescription)")
            }
        } else {
            print("Invalid filename/path.")
        }

        
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return testData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellid, for: indexPath) as! mainCollectionViewCell
        cell.data = testData[indexPath.item]
        return cell
    }
}

