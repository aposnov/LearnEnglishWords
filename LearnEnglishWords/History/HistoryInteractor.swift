//
//  HistoryInteractor.swift
//  LearnEnglishWords
//
//  Created by Andrey Posnov on 11/06/2019.
//  Copyright (c) 2019 Andrey Posnov. All rights reserved.
//

import UIKit
import CoreData

protocol HistoryBusinessLogic {
  func makeRequest(request: History.Model.Request.RequestType)
}

class HistoryInteractor: HistoryBusinessLogic {

  var presenter: HistoryPresentationLogic?
  var service: HistoryServiceCoreData?
  
  func makeRequest(request: History.Model.Request.RequestType) {
  
    if service == nil {
        service = HistoryServiceCoreData()
    }
    
        switch request {
          case .getVocabulary:
            if let vocabulary = service?.getVocabulary() {
            self.presenter?.presentData(response: .sendVocabulary(vocabulary: vocabulary))
            }
          case .cleanVocabulary:
            if let vocabulary = service?.cleanVocabulary() {
            self.presenter?.presentData(response: .sendVocabulary(vocabulary: vocabulary))
            }
          case .getVocabularyFiltered(let search):
            if let vocabulary = service?.myFetchRequest(search: search) {
            self.presenter?.presentData(response: .sendVocabulary(vocabulary: vocabulary))
            }
        }
 
  }
   
  
}
