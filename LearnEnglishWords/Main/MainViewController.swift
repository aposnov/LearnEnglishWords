//
//  MainViewController.swift
//  LearnEnglishWords
//
//  Created by Andrey Posnov on 11/06/2019.
//  Copyright (c) 2019 Andrey Posnov. All rights reserved.
//

import UIKit

protocol MainDisplayLogic: class {
  func displayData(viewModel: Main.Model.ViewModel.ViewModelData)
}

class MainViewController: UIViewController, MainDisplayLogic {

  var interactor: MainBusinessLogic?
  var router: (NSObjectProtocol & MainRoutingLogic)?
    
  
  // MARK: Setup
    @IBOutlet weak var sourceLanguage: UIButton!
    @IBOutlet weak var targetLanguage: UIButton!
    @IBOutlet weak var inputTextField: UITextView!
    @IBOutlet weak var resultTextiField: UITextView!
   
      private func setup() {
        let viewController        = self
        let interactor            = MainInteractor()
        let presenter             = MainPresenter()
        let router                = MainRouter()
        viewController.interactor = interactor
        viewController.router     = router
        interactor.presenter      = presenter
        presenter.viewController  = viewController
        router.viewController     = viewController
      }
  
    // MARK: Routing
  

  
    // MARK: View lifecycle
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
      }
  
    func displayData(viewModel: Main.Model.ViewModel.ViewModelData) {
        
        switch viewModel {
          case .displayTranslation(let resultText):
            
                resultTextiField.text = resultText
            
            }
        
     }
    
    
}

extension MainViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == inputTextField {
            
            let inputText = inputTextField.text
            guard let q = inputText else { return }
            interactor?.makeRequest(request: .getTranslation(query: q))
            inputTextField.resignFirstResponder()
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
