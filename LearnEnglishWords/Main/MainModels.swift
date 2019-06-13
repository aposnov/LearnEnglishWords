//
//  MainModels.swift
//  LearnEnglishWords
//
//  Created by Andrey Posnov on 11/06/2019.
//  Copyright (c) 2019 Andrey Posnov. All rights reserved.
//

import UIKit

enum Main {
   
  enum Model {
    struct Request {
      enum RequestType {
        case getTranslation(query: String, language: String)
      }
    }
    struct Response {
      enum ResponseType {
        case presentTranslation(resultText: String)
      }
    }
    struct ViewModel {
      enum ViewModelData {
        case displayTranslation(resultText: String)
      }
    }
  }
  
}

struct TranslationResponse: Decodable {
    let text: [String]
}

struct API {
    static let scheme = "https"
    static let host = "translate.yandex.net"
    static let version = "/api/v1.5/"
    static let type = "tr.json/"
    static let translate = "translate"
}


