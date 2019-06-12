//
//  HistoryCell.swift
//  LearnEnglishWords
//
//  Created by Andrey Posnov on 12/06/2019.
//  Copyright © 2019 Andrey Posnov. All rights reserved.
//

import UIKit

protocol HistoryCellViewModel {
    var sourceLanguageTranslationWord: String { get }
    var targetLanguageTranslationWord: String { get }
}

class HistoryCell: UITableViewCell {
    
    @IBOutlet weak var sourceLanguageTranslationWord: UILabel!
    @IBOutlet weak var targetLanguageTranslationWord: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(viewModel: HistoryCellViewModel){
        sourceLanguageTranslationWord.text = viewModel.sourceLanguageTranslationWord
        targetLanguageTranslationWord.text = viewModel.targetLanguageTranslationWord
    }
    
}
