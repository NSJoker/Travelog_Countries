//
//  LanguageViewModel.swift
//  Countries
//
//  Created by Chandrachudh K on 03/12/22.
//

import Foundation

class LanguageViewModel {
    // MARK: Public Properties
    let languages: [String: String]
    var allLanguages: String {
        var allLanguages = ""
        
        let langs = languages.map({
            $0.value
        })
        
        for value in langs {
            allLanguages += value
            if value != (langs.last ?? "") {
                allLanguages += ", "
            }
        }
        
        return allLanguages
    }
    
    init(languages: [String : String]) {
        self.languages = languages
    }
}
