//
//  HistoryModels.swift
//  LearnEnglishWords
//
//  Created by Andrey Posnov on 11/06/2019.
//  Copyright (c) 2019 Andrey Posnov. All rights reserved.
//

import UIKit

enum History {
   
  enum Model {
    struct Request {
      enum RequestType {
        case getVocabulary
        case cleanVocabulary
      }
    }
    struct Response {
      enum ResponseType {
        case sendVocabulary(vocabulary: [Words])
      }
    }
    struct ViewModel {
      enum ViewModelData {
        case displayVocabulary(historyViewModel: HistoryViewModel)
      }
    }
  }
  
}

struct HistoryViewModel {
    struct Cell: HistoryCellViewModel {
        var sourceLanguageTranslationWord: String
        var targetLanguageTranslationWord: String
     }
    let cells: [Cell]
}
