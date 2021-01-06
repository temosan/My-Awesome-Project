//
//  third_ViewController.swift
//  Sample001-Swift
//
//  Created by 김희중 on 2021/01/06.
//

import UIKit
import SnapKit

class third_ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
        
        let cells = [thirdCollectionViewCell.self]
        cells.forEach { (cell) in
            mainCollectionView.register(cell.self, forCellWithReuseIdentifier: String(describing: cell))
        }
        
        mainCollectionView.register(thirdCollectionViewCellHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: thirdCollectionViewCellHeader.self))
        
        setupLayouts()
        getInfo(resource: "https://dl.dropboxusercontent.com/s/8a9ouqhnrzac11y/sample_dev.json")
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
    
    public enum customError: Error {
        case url_error
        case dataTaskError
        case statusError
        case jsonSyntaxError
    }
    
    fileprivate func getData<T: Codable>(resource: String, type: T, completion: @escaping (Result<T,Error>) -> ()) {
        let defaultSession = URLSession(configuration: .default)
        
        guard let url = URL(string: "\(resource)") else {
            completion(.failure(customError.url_error))
            return
        }
        //Request
        let request = URLRequest(url: url)
        
        //dataTask
        let dataTask = defaultSession.dataTask(with: request) { (data, response, error) in
            if error != nil {
                completion(.failure(customError.dataTaskError))
                return
            }
            
            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(customError.statusError))
                return
            }

            guard let object = try? JSONDecoder().decode(T.self, from: data) else {
                completion(.failure(customError.jsonSyntaxError))
                return
            }
            
            completion(.success(object))

        }
        dataTask.resume()
    }
    
    var develop_infos = [info]()
    var service_infos = [info]()
    
    fileprivate func getInfo(resource: String) {
        let resource = resource
        getData(resource: resource, type: URL_Session_model()) { [weak self] (result) in
            switch result {
            case .success(let json):
                guard let develop = json.servers?.develop else {return}
                guard let service = json.servers?.service else {return}
                self?.develop_infos = develop
                self?.service_infos = service
                
                DispatchQueue.main.async {
                    self?.mainCollectionView.reloadData()
                }
                
            case .failure(let message):
                print("GETTING INFO ERROR: ",message)
            }
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return develop_infos.count
        }
        else {
            return service_infos.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: thirdCollectionViewCellHeader.self), for: indexPath) as! thirdCollectionViewCellHeader
        if indexPath.section == 0 {
            header.label.text = "develop"
        }
        else {
            header.label.text = "service"
        }
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: thirdCollectionViewCell.self), for: indexPath) as! thirdCollectionViewCell
        if indexPath.section == 0 {
            let info = develop_infos[indexPath.item]
            cell.label1.text = "id: \(info.id)"
            cell.label2.text = "version: \(info.version)"
            cell.label3.text = "downloadURL: \(info.downloadURL)"
            cell.label4.text = "description: \(info.description)"
        }
        else {
            let info = service_infos[indexPath.item]
            cell.label1.text = "id: \(info.id)"
            cell.label2.text = "version: \(info.version)"
            cell.label3.text = "downloadURL: \(info.downloadURL)"
            cell.label4.text = "description: \(info.description)"
        }
        return cell
    }
}




