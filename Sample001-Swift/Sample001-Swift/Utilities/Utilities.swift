//
//  Utilities.swift
//  Sample001-Swift
//
//  Created by 박영호 on 2021/01/06.
//

import UIKit

class Utilities {
    public static let shared = Utilities()
    
    /**
     로컬 JSON 파일 읽어오기
     - parameters:
        - type : 리턴 타입
        - filename : 확장자를 제외한 JSON파일 이름
     */
    func loadLocalJson<T : Decodable>(_ type: T.Type, filename fileName: String, completion: @escaping (Result<T, loadJsonError>) -> Void) {
        /// 파일이름 -> URL
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            return completion(.failure(.filenameToUrl))
        }
        
        /// URL -> Data
        guard let data = try? Data(contentsOf: url) else {
            return completion(.failure(.urlToData)) }
        
        /// Data -> T타입 값
        let decoder = JSONDecoder()
        guard let jsonData = try? decoder.decode(type, from: data) else {
            return completion(.failure(.dataToValue)) }
        
        return completion(.success(jsonData))
    }
}
