//
//  HistoryInteractor.swift
//  LearnEnglishWords
//
//  Created by Andrey Posnov on 11/06/2019.
//  Copyright (c) 2019 Andrey Posnov. All rights reserved.
//

import UIKit

protocol HistoryBusinessLogic {
  func makeRequest(request: History.Model.Request.RequestType)
}

class HistoryInteractor: HistoryBusinessLogic {

  var presenter: HistoryPresentationLogic?
  var service: HistoryService?
  
  func makeRequest(request: History.Model.Request.RequestType) {
    if service == nil {
      service = HistoryService()
    }
  }
  
}
