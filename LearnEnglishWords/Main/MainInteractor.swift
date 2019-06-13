//
//  MainInteractor.swift
//  LearnEnglishWords
//
//  Created by Andrey Posnov on 11/06/2019.
//  Copyright (c) 2019 Andrey Posnov. All rights reserved.
//

import UIKit

protocol MainBusinessLogic {
  func makeRequest(request: Main.Model.Request.RequestType)
}

class MainInteractor: MainBusinessLogic {

  var presenter: MainPresentationLogic?
  var service: MainServiceCoreData?
  
     private var fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())
    
  func makeRequest(request: Main.Model.Request.RequestType) {
    if service == nil {
      service = MainServiceCoreData()
    }
    
    switch request {
      case .getTranslation(let query, let language):
        fetcher.getTranslation(query: query, language: language){[weak self] (TranslationResponse) in
            guard let TranslationResponse = TranslationResponse else { return }
            let text = TranslationResponse.text[0]
            self?.service?.saveTranslationToCd(sourceWord: query, targetWord: text, language: language)
            self?.presenter?.presentData(response: .presentTranslation(resultText: text))
        }
   
    }
    
  }
  
}
