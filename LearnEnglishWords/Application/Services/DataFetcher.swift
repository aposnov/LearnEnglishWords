//
//  DataFetcher.swift
//  LearnEnglishWords
//
//  Created by Andrey Posnov on 12/06/2019.
//  Copyright © 2019 Andrey Posnov. All rights reserved.
//

import Foundation

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
