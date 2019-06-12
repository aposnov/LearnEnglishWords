//
//  TranslationResponse.swift
//  LearnEnglishWords
//
//  Created by Andrey Posnov on 11/06/2019.
//  Copyright © 2019 Andrey Posnov. All rights reserved.
//

import Foundation

struct TranslationResponse: Decodable {
    let text: [String]
}
