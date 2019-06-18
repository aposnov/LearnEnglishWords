//
//  MainRouter.swift
//  LearnEnglishWords
//
//  Created by Andrey Posnov on 11/06/2019.
//  Copyright (c) 2019 Andrey Posnov. All rights reserved.
//

import UIKit

protocol MainRoutingLogic {
    func presentController(typeLanguage: String)
}

class MainRouter: NSObject, MainRoutingLogic {

  weak var viewController: MainViewController?
  weak var HistoryViewController: HistoryViewController?
  
  // MARK: Routing
    func  presentController(typeLanguage: String) {
        let storyboard = UIStoryboard(name: "SelectLanguage", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "SelectLanguageViewController") as! SelectLanguageViewController
        controller.typeLanguage = typeLanguage
        viewController?.present(controller, animated: true, completion: nil)
    }
  
}
