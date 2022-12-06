//
//  String Extension.swift
//  Countries
//
//  Created by Chandrachudh K on 03/12/22.
//

import Foundation

extension String {
    /**
     Check for sub string
     */
    func isSubstring(text: String) -> Bool {
        if text.isEmpty {
            return true
        }
        return self.lowercased().contains(text.lowercased())
    }
}
