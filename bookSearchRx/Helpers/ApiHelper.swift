//
//  ApiHelper.swift
//  bookSearchRx
//
//  Created by Burak Colak on 12.11.2018.
//  Copyright © 2018 Burak Colak. All rights reserved.
//

import UIKit
import Alamofire

class ApiHelper: NSObject {

    static let sharedInstance = ApiHelper()
    
    private override init() {}
    
    func getSearchResult(path:String,failure:@escaping (Error?)->Void,success:@escaping (SearchResult)->Void){
        Alamofire.request("\(Constants.baseURL)/\(path)", method: .post).responseJSON { (response) in
            if let error = response.error {
                failure(error)
                return
            }
            if let data = response.data {
                guard let result = try? JSONDecoder().decode(SearchResult.self, from: data) else {
                    failure(nil)
                    return
                }
                success(result)
            }
        }
    }
    
}
