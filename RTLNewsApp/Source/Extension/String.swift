//
//  String.swift
//  RTLNewsApp
//
//  Created by Abdorahman on 29/05/2020.
//  Copyright © 2020 Abdorahman. All rights reserved.
//

import Foundation

extension String {
    
    // A variable that returns the localized value associated to the string as a key
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
