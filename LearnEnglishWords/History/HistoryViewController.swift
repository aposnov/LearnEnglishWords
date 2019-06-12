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
    private var historyViewModel = HistoryViewModel.init(cells: [])
  
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
    
    initUI()
  
   }
    
   func displayData(viewModel: History.Model.ViewModel.ViewModelData) {
    switch  viewModel {
        case .displayVocabulary(let historyViewModel):
            self.historyViewModel = historyViewModel
            self.tableView.reloadData()
       }
   }
    
    func initUI(){
        let nib = UINib(nibName: "HistoryCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "HistoryCell")
        
        cleanButton.addTarget(self, action: #selector(clean), for: .touchUpInside)
    }
    
 }

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refresh()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyViewModel.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as! HistoryCell
        let cellViewModel = historyViewModel.cells[indexPath.row]
        cell.set(viewModel: cellViewModel)
        return cell
    }
    
    @objc private func clean() {
        interactor?.makeRequest(request: .cleanVocabulary)
    }
    
    @objc private func refresh() {
        interactor?.makeRequest(request: .getVocabulary)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
      print(searchText)
        
    }
    
    
}
