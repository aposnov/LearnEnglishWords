//
//  NetworkService.swift
//  LearnEnglishWords
//
//  Created by Andrey Posnov on 11/06/2019.
//  Copyright © 2019 Andrey Posnov. All rights reserved.
//

import Foundation

final class NetworkService {
    
    func getTranslation(q: String, language: String, completion: @escaping (Data?, Error?) -> Void) {
            var components = URLComponents()
            let query = q
        
            let params = ["key":"trnsl.1.1.20190611T154159Z.9fa98935b45dd63e.d2ae642540c98ba064bf2f29b45b32f8417e15b4"]
            var allParams = params
            allParams["text"] = query
            allParams["lang"] = language
            allParams["format"] = "plain"
            allParams["options"] = "0"
        
            components.scheme = API.scheme
            components.host = API.host
            components.path = API.version+API.type+API.translate
            components.queryItems = allParams.map { URLQueryItem(name: $0, value: $1) }
            let url = components.url!
        
            let request = URLRequest(url: url)
            let task = createDataTask(from: request, completion: completion)
            task.resume()
            print(url)
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
         return URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        })
     }
    
    

}
