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
        case getTranslation
      }
    }
    struct Response {
      enum ResponseType {
        case presentTranslation
      }
    }
    struct ViewModel {
      enum ViewModelData {
        case displayTranslation
      }
    }
  }
  
}


