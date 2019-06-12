//
//  MainPresenter.swift
//  LearnEnglishWords
//
//  Created by Andrey Posnov on 11/06/2019.
//  Copyright (c) 2019 Andrey Posnov. All rights reserved.
//

import UIKit

protocol MainPresentationLogic {
  func presentData(response: Main.Model.Response.ResponseType)
}

class MainPresenter: MainPresentationLogic {
  weak var viewController: MainDisplayLogic?
  
  func presentData(response: Main.Model.Response.ResponseType) {
  
    switch response {
         case .presentTranslation(let resultText):
            viewController?.displayData(viewModel: .displayTranslation(resultText: resultText))
        }
    
    }
  
}
