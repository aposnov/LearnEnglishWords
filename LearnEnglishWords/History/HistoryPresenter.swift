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
  
    switch response {
      case .sendVocabulary(let vocabulary):
        
        let cells = vocabulary.map { (vocabulary) in
            cellViewModel(from: vocabulary)
        }
         
        let historyViewModel = HistoryViewModel.init(cells: cells)
        
        viewController?.displayData(viewModel: .displayVocabulary(historyViewModel: historyViewModel))
   
    }
  }
    
    private func cellViewModel(from Words: Words) -> HistoryViewModel.Cell {
        return HistoryViewModel.Cell.init(sourceLanguageTranslationWord: Words.sourceWord ?? "", targetLanguageTranslationWord: Words.targetWord ?? "")
    }
    
 
  
}
