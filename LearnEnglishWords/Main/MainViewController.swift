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
    @IBOutlet weak var changeLanguage: UIButton!
  
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
        initButtons()
      }
  
    func displayData(viewModel: Main.Model.ViewModel.ViewModelData) {
        
        switch viewModel {
          case .displayTranslation(let resultText):
                resultTextiField.text = resultText
            }
        
     }
    
    //Add actions to buttons
    func initButtons(){
        sourceLanguage.addTarget(self, action: #selector(showSourceLanguage), for: .touchUpInside)
        targetLanguage.addTarget(self, action: #selector(showTargetLanguage), for: .touchUpInside)
        changeLanguage.addTarget(self, action: #selector(changeLanguagePlaces), for: .touchUpInside)
     }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Show choosen language
        let sourceLanguageTitle = UserDefaults.standard.string(forKey: "sourceLanguage")
        let targetLanguageTitle = UserDefaults.standard.string(forKey: "targetLanguage")
        
        if let sourceLangTitle = sourceLanguageTitle {
            sourceLanguage.setTitle(sourceLangTitle, for:.normal)
        }
        
        if let targetLangTitle = targetLanguageTitle {
            targetLanguage.setTitle(targetLangTitle, for:.normal)
        }
    }
    
    //Choose source language
    @objc private func showSourceLanguage() {
         router?.presentController(typeLanguage: "Source Language")
    }
    
    //Choose target language
    @objc private func showTargetLanguage() {
         router?.presentController(typeLanguage: "Target Language")
    }
    
    //Change source/target language places
    @objc private func changeLanguagePlaces() {
       
        let source = sourceLanguage.titleLabel
        let target = targetLanguage.titleLabel
        
        targetLanguage.setTitle(source?.text, for:.normal)
        sourceLanguage.setTitle(target?.text, for:.normal)
        
    }
    
}

extension MainViewController: UITextViewDelegate {
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        //Get choosen languages
        let source = sourceLanguage.titleLabel
        let target = targetLanguage.titleLabel
        
        //Match choosen languages
        let sourceLanguage = getLangForRequest(lang: source?.text)
        let targetLanguage = getLangForRequest(lang: target?.text)
        
        //Send request to translate
        if textView == inputTextField {
            let inputText = inputTextField.text
            guard let query = inputText else { return }
         
            let language = "\(sourceLanguage)-\(targetLanguage)"
            interactor?.makeRequest(request: .getTranslation(query: query, language: language))
            inputTextField.resignFirstResponder()
        }
    }
    
    //Match function selected language for API request
    func getLangForRequest(lang: String?) -> String {
        switch lang  {
            case "Russian":
            return "ru"
            case "English":
            return "en"
            case "Spanish":
            return "es"
            default:
            return ""
        }
        
    }
    
    //Hide keyboard when touch outside
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //Hide keyboard when press Enter
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
