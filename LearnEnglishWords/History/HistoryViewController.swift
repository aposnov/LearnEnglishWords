//
//  HistoryViewController.swift
//  LearnEnglishWords
//
//  Created by Andrey Posnov on 11/06/2019.
//  Copyright (c) 2019 Andrey Posnov. All rights reserved.
//

import UIKit

protocol HistoryDisplayLogic: class {
  func displayData(viewModel: History.Model.ViewModel.ViewModelData)
}

class HistoryViewController: UIViewController, HistoryDisplayLogic {

  var interactor: HistoryBusinessLogic?
  var router: (NSObjectProtocol & HistoryRoutingLogic)?

  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cleanButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    // MARK: Setup
  
  private func setup() {
    let viewController        = self
    let interactor            = HistoryInteractor()
    let presenter             = HistoryPresenter()
    let router                = HistoryRouter()
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
    

    
  }
  
  func displayData(viewModel: History.Model.ViewModel.ViewModelData) {

  }
  
}
