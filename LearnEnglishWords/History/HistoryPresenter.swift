//
//  HistoryPresenter.swift
//  LearnEnglishWords
//
//  Created by Andrey Posnov on 11/06/2019.
//  Copyright (c) 2019 Andrey Posnov. All rights reserved.
//

import UIKit

protocol HistoryPresentationLogic {
  func presentData(response: History.Model.Response.ResponseType)
}

class HistoryPresenter: HistoryPresentationLogic {
  weak var viewController: HistoryDisplayLogic?
  
  func presentData(response: History.Model.Response.ResponseType) {
  
  }
  
}
