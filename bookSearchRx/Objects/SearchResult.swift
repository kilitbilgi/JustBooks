//
//  Book.swift
//  bookSearchRx
//
//  Created by Burak Colak on 12.11.2018.
//  Copyright © 2018 Burak Colak. All rights reserved.
//

import UIKit

struct SearchResult : Codable {

    var start : NSInteger
    var num_found : NSInteger
    var numFound : NSInteger
    var docs: [Book]
    
}
