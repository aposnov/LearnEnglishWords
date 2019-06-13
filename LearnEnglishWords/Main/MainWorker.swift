//
//  MainWorker.swift
//  LearnEnglishWords
//
//  Created by Andrey Posnov on 11/06/2019.
//  Copyright (c) 2019 Andrey Posnov. All rights reserved.
//

import UIKit
import CoreData

class MainServiceCoreData {

    func saveTranslationToCd(sourceWord: String, targetWord: String, language: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Words", in: context)
        let wordObject = NSManagedObject(entity: entity!, insertInto: context) as! Words
        wordObject.sourceWord = sourceWord
        wordObject.targetWord = targetWord
        wordObject.language = language
        
        try? context.save()
    }
    
}
