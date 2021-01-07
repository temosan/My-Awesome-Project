//
//  NetworkManager.swift
//  Adiscope_for_Mac
//
//  Created by mjgu on 2020/08/28.
//

import Foundation

class NetworkManager {
    
    enum NetworkMethod {
        case GET
        case POST
        case DELETE
    }
    
    enum NetworkError: Error {
        case unknown
        case jsonParse
        
        // 희중 수정사함
        // error 처리의 세분화
        
        /// response.statusCode == 200 아닐경우
        case invalidResponse
        
        /// data를 받아오지 못하는 경우
        case invalidData
    }
    
    typealias NetworkResultHandler<T> = (Result<T, NetworkError>) -> Void
    private typealias NetworkRawResultHandler = (Result<Data,NetworkError>) -> Void
    
    class Request {
        
        class func new<T: Decodable>(urlString: String, method: NetworkMethod, headers: [String: String]? = nil, parameters: [String: String]? = nil, id: Int? = nil, _ handler: NetworkResultHandler<T>?) {
            switch method {
            case .GET:  self.get(urlString: urlString, headers: headers, handler: handler)
            case .POST: self.post(urlString: urlString, headers: headers, parameters: parameters, handler: handler)
            case .DELETE: self.delete(urlString: urlString, headers: headers, id: id, handler: handler)
            }
        }
        
        private class func get<T: Decodable>(urlString: String, headers: [String: String]?, handler: NetworkResultHandler<T>?) {
            rawGet(urlString: urlString, headers: headers) { (result) in
                rawResultTranslator(rawResult: result, resultHandler: handler)
            }
        }
        
        private class func post<T: Decodable>(urlString: String, headers: [String: String]?, parameters: [String: String]?, handler: NetworkResultHandler<T>?) {
            rawPost(urlString: urlString, headers: headers, parameters: parameters) { (result) in
                rawResultTranslator(rawResult: result, resultHandler: handler)
            }
        }
        
        private class func delete<T: Decodable>(urlString: String, headers: [String: String]?, id: Int?, handler: NetworkResultHandler<T>?) {
            rawDelete(urlString: urlString, headers: headers, id: id) { (result) in
                rawResultTranslator(rawResult: result, resultHandler: handler)
            }
        }
        
        /// - Parameters:
        ///   - urlString: 요청할 Target URL
        ///   - headers: 기본 Header에 덧붙일 header
        ///   - completion: 요청후 실행하는 Handler
        private class func rawGet(urlString: String, headers: [String: String]?, completion: NetworkRawResultHandler?) {
            request(urlString, "GET", completion, headers)
        }
        
        /// - Parameters:
        ///   - urlString: 요청할 Target URL
        ///   - headers: 기본 Header에 덧붙일 header
        ///   - parameters: POST Body에 들어갈 Data
        ///   - completion: 요청후 실행하는 Handler
        private class func rawPost(urlString: String, headers: [String: String]?, parameters: [String: String]?, completion: NetworkRawResultHandler?) {
            request(urlString, "POST", completion, headers, parameters)
        }
        
        /// - Parameters:
        ///   - urlString: 요청할 Target URL
        ///   - headers: 기본 Header에 덧붙일 header
        ///   - completion: 요청후 실행하는 Handler
        private class func rawDelete(urlString: String, headers: [String: String]?, id: Int?, completion: NetworkRawResultHandler?) {
            request(urlString, "DELETE", completion, headers, nil, id)
        }
        
        
        // MARK: - Network Utils
        /// - Parameter additionHeaders: 덧붙일 Header
        /// - Returns: Default Header + Addition Headers
        private class func createDefaultHeader(additionHeaders: [String: String]?)
        -> [String: String]? {
            
            var defaultHeader = ["Content-Type": "application/json",
                                 "Accept": "application/json"]
            guard let additionHeaders = additionHeaders else { return defaultHeader }
            
            defaultHeader.merge(additionHeaders, uniquingKeysWith: +)
            return defaultHeader
        }
        
        /// - Parameters:
        ///   - urlString: Request URL
        ///   - httpMethod: Request Http Method Type
        ///   - completion: Completion Handler
        ///   - headers: Request Headers
        ///   - parameters: Request Data Body
        private class func request(_ urlString: String, _ httpMethod: String, _ completion: NetworkRawResultHandler?, _ headers: [String: String]?, _ parameters: [String: String]? = nil, _ id: Int? = nil) {
            
            var urlstr = urlString
            
            // 희중 수정
            // DELETE 할 경우 해당 id를 추가해주게 하였습니다.
            if let id = id {
                urlstr = urlString + "/\(id)"
            }
            
            guard let url = URL.init(string: urlstr) else { return }
            
            var request = URLRequest.init(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 20.0)
            
            // 희중 수정
            // paramter를 받아와서 httpbody에 추가하는 기능을 구현하였습니다.
            if let param = parameters {
                guard let data = try? JSONSerialization.data(withJSONObject: param, options: .init()) else {return}
                request.httpBody = data
            }
            
            request.httpMethod = httpMethod
            request.allHTTPHeaderFields = Request.createDefaultHeader(additionHeaders: headers)
            request.cachePolicy = .reloadIgnoringLocalCacheData
            let dataTask = Request.processRequest(request: request, handler: completion)
            dataTask.resume()
        }
        
        /// - Parameters:
        ///   - request: URLRequest
        ///   - handler: completion Handler
        /// - Returns: Sesstion
        private class func processRequest(request: URLRequest, handler: NetworkRawResultHandler?)
        -> URLSessionDataTask {
            
            return URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard error == nil else {
                    handler?(.failure(.unknown))
                    return
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    handler?(.failure(.invalidResponse))
                    return
                }
                
                guard data != nil else {
                    handler?(.failure(.invalidData))
                    return
                }

                handler?(.success(data!))
            }
        }
        
        // MARK: - Data Parser
        private class func getObjectFromDataString<T: Decodable>(_ data: Data, _ type: T.Type) -> T? {
            return try? JSONDecoder().decode(T.self, from: data)
        }
        
        private class func rawResultTranslator<T: Decodable>(rawResult: Result<Data,NetworkError>, resultHandler: NetworkResultHandler<T>?) {
            switch rawResult { 
            case .success(let data):
                guard let object = getObjectFromDataString(data, T.self) else {
                    resultHandler?(.failure(.jsonParse))
                    return
                }
                resultHandler?(.success(object))
            case .failure(let error):
                resultHandler?(.failure(error))
            }
        }
    }
}
