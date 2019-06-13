//
//  MainWorker.swift
//  LearnEnglishWords
//
//  Created by Andrey Posnov on 11/06/2019.
//  Copyright (c) 2019 Andrey Posnov. All rights reserved.
//

import UIKit
import CoreData

class MainServiceCoreData {

    func saveTranslationToCd(sourceWord: String, targetWord: String, language: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Words", in: context)
        let wordObject = NSManagedObject(entity: entity!, insertInto: context) as! Words
        wordObject.sourceWord = sourceWord
        wordObject.targetWord = targetWord
        wordObject.language = language
        
        try? context.save()
    }
    
}

class NetworkService {
    
    
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

protocol DataFetcher {
    func getTranslation(query: String, language: String, response: @escaping (TranslationResponse?) -> Void)
}

struct NetworkDataFetcher: DataFetcher {
    
    let networking: NetworkService
    
    init(networking: NetworkService) {
        self.networking = networking
    }
    
    func getTranslation(query: String,  language: String, response: @escaping (TranslationResponse?) -> Void) {
        networking.getTranslation(q: query, language: language) { (data, error) in
            
            if let error = error {
                print("Error received data: \(error.localizedDescription)")
                response(nil)
            }
            
            let decoded = self.decodeJSON(type: TranslationResponse.self, from: data)
            response(decoded)
        }
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = from, let response = try? decoder.decode(type.self, from: data) else {return nil}
        return response
    }
}

