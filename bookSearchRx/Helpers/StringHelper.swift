//
//  StringHelper.swift
//  bookSearchRx
//
//  Created by Burak Colak on 14.11.2018.
//  Copyright © 2018 Burak Colak. All rights reserved.
//

import UIKit

extension String {
    
    func trim()->String{
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
}
