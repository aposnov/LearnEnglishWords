//
//  MainInteractor.swift
//  LearnEnglishWords
//
//  Created by Andrey Posnov on 11/06/2019.
//  Copyright (c) 2019 Andrey Posnov. All rights reserved.
//

import UIKit
import CoreData

protocol MainBusinessLogic {
  func makeRequest(request: Main.Model.Request.RequestType)
}

class MainInteractor: MainBusinessLogic {

  var presenter: MainPresentationLogic?
  var service: MainService?
  
     private var fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())
    
  func makeRequest(request: Main.Model.Request.RequestType) {
    if service == nil {
      service = MainService()
    }
    
    switch request {
      case .getTranslation(let query, let language):
        fetcher.getTranslation(query: query, language: language){[weak self] (TranslationResponse) in
            guard let TranslationResponse = TranslationResponse else { return }
            let text = TranslationResponse.text[0]
            self?.saveTranslationToCd(sourceWord: query, targetWord: text, language: language)
            self?.presenter?.presentData(response: .presentTranslation(resultText: text))
        }
   
    }
    
  }
    
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
