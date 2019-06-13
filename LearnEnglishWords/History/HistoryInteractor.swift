//
//  HistoryInteractor.swift
//  LearnEnglishWords
//
//  Created by Andrey Posnov on 11/06/2019.
//  Copyright (c) 2019 Andrey Posnov. All rights reserved.
//

import UIKit
import CoreData

protocol HistoryBusinessLogic {
  func makeRequest(request: History.Model.Request.RequestType)
}

class HistoryInteractor: HistoryBusinessLogic {

  var presenter: HistoryPresentationLogic?
  var service: HistoryService?
  
  func makeRequest(request: History.Model.Request.RequestType) {
  
        switch request {
          case .getVocabulary:
            var vocabulary = [Words]()
            vocabulary = getVocabulary()
            self.presenter?.presentData(response: .sendVocabulary(vocabulary: vocabulary))
          case .cleanVocabulary:
            var vocabulary = [Words]()
            vocabulary = cleanVocabulary()
            self.presenter?.presentData(response: .sendVocabulary(vocabulary: vocabulary))
          case .getVocabularyFiltered(let search):
            var vocabulary = [Words]()
            vocabulary = myFetchRequest(search: search)
            self.presenter?.presentData(response: .sendVocabulary(vocabulary: vocabulary))
        }
 
  }
    func myFetchRequest(search: String) -> [Words] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Words> = Words.fetchRequest()
        fetchRequest.predicate = NSPredicate (format: "sourceWord CONTAINS[cd] %@ OR targetWord CONTAINS[cd] %@", search, search)
        return try! context.fetch(fetchRequest)
    }
    
    func getVocabulary() -> [Words] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Words> = Words.fetchRequest()
        return try! context.fetch(fetchRequest)
    }
    
    func cleanVocabulary() -> [Words] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Words")
        fetchRequest.returnsObjectsAsFaults = false
        
        do
        {
            let results = try context.fetch(fetchRequest)
            for managedObject in results
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                context.delete(managedObjectData)
            }
        } catch let error as NSError {
          //  print("Detele all my data in \(entity) error : \(error) \(error.userInfo)")
        }
        
        let fetchRequestZ: NSFetchRequest<Words> = Words.fetchRequest()
        return try! context.fetch(fetchRequestZ)
    }
  
}
