//
//  ViewController.swift
//  bookSearchRx
//
//  Created by Burak Colak on 12.11.2018.
//  Copyright © 2018 Burak Colak. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    let disposeBag = DisposeBag()
    
    var searchResult : SearchResult!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchBooks()
        
        tableView.register(UINib(nibName: "BookTableViewCell", bundle: nil), forCellReuseIdentifier: "BookTableViewCell")

    }
    
    private func searchBooks(){
        self.searchBar.rx.searchButtonClicked.bind(onNext: { _ in
            self.searchBar.resignFirstResponder()
        }).disposed(by: self.disposeBag)
        
        self.searchBar.rx.text.orEmpty
            .distinctUntilChanged()
            .subscribe({ query in
                
                //Wrap our query string
                if let searchQuery = query.element , searchQuery.trim().count > 2 {
                    
                    let searchQueryArray = searchQuery.split(separator: " ")
                    let searchQueryStr = searchQueryArray.joined(separator: "+").localizedLowercase
                    
                    ApiHelper.sharedInstance.getSearchResult(path: "?q=\(searchQueryStr)", failure: { error in
                        print(error?.localizedDescription ?? "")
                    }, success: { result in
                        
                        self.tableView.delegate = nil
                        self.tableView.dataSource = nil
                        
                        let items = Observable.just((result.docs).map { $0 })
                        
                        items.bind(to: self.tableView.rx.items(cellIdentifier: "BookTableViewCell", cellType: BookTableViewCell.self)) { (index, book, cell) in
                            let title = book.title
                            
                            cell.lblTitle.text = title
                            
                        }.disposed(by: self.disposeBag)
                        
                    })
                }
                
            }).disposed(by: self.disposeBag)
    }

}

