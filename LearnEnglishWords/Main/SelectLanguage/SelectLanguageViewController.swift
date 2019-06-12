//
//  SelectLanguageViewController.swift
//  LearnEnglishWords
//
//  Created by Andrey Posnov on 12/06/2019.
//  Copyright © 2019 Andrey Posnov. All rights reserved.
//

import UIKit

class SelectLanguageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let languageArray: [String] = ["English", "Russian", "Spanish"]
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var typeLanguage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        titleLabel.text = typeLanguage
        
        let nib = UINib(nibName: "SelectLanguageCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "SelectLanguageCell")
    }

    // MARK: - Table view data source

    @IBAction func closeButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languageArray.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectLanguageCell", for: indexPath) as! SelectLanguageCell
       
        cell.languageLabel.text = languageArray[indexPath.row]

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
            switch typeLanguage {
            case "Source Language":
                UserDefaults.standard.setValue(languageArray[indexPath.row], forKey: "sourceLanguage")
                self.dismiss(animated: true, completion: nil)
            case "Target Language":
                UserDefaults.standard.setValue(languageArray[indexPath.row], forKey: "targetLanguage")
                self.dismiss(animated: true, completion: nil)
            default:
                break
            }
      
    }
        
    
    
}
