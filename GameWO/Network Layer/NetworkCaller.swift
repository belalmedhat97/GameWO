//
//  NetworkCaller.swift
//  GameWO
//
//  Created by Belal medhat on 7/12/20.
//  Copyright © 2020 Belal medhat. All rights reserved.
//

import Foundation

class Network{
    class func Request<T:Codable,E:Codable>(URL:URLRequest, completion: @escaping (CustomResults<T,E,Error>) -> Void){
        
        let session = URLSession(configuration: .default)
        
        let RequesterTask = session.dataTask(with: URL) { (data, response, error) in
            guard error == nil else {return}
            if let HTTPResponse = response as? HTTPURLResponse {
                DispatchQueue.main.async {
                
                switch HTTPResponse.statusCode {
                case 200..<300:
                    if let URLData = data {
                    do {
                        print(URL)
                    let ResponseResult = try JSONDecoder().decode(T.self, from: URLData)
                        completion(.success(ResponseResult))
                    }catch{
                        completion(.failureError(error))
                    }
                    }
                case 400...500:
                    if let URLDataError = data {
                        do{
                    let ErrorResponseResult = try JSONDecoder().decode(E.self, from: URLDataError)
                        completion(.failure(ErrorResponseResult))
                    }catch{
                        completion(.failureError(error))
                    
                }
            }
                default:
                    print("")
                }
                }
          
        }
        }
        RequesterTask.resume()
    }
}
