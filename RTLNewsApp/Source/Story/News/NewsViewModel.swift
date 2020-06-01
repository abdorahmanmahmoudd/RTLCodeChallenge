//
//  NewsViewModel.swift
//  RTLNewsApp
//
//  Created by Abdorahman on 28/05/2020.
//  Copyright © 2020 Abdorahman. All rights reserved.
//

import Foundation
import RxSwift

final class NewsViewModel: BaseStateController {
    
    /// Network requests
    private let api: NetworkRequests
    
    /// RxSwift
    private let disposeBag = DisposeBag()
    
    /// News list
    private var newsList: [Article] = []
    
    /// Current page number
    private var page = 1
    
    /// Total items
    private var totalItems = 0
    
    
    init(api: NetworkRequests) {
        self.api = api
    }
    
    /// Get news List
    func getNews(withCountry country: String = "nl", isRefreshing: Bool = false) {
        
        /// If not refreshing show loading indicator
        if !isRefreshing {
            loadingState()
        }
        
        /// Execute the API call
        api.getNews(country: country, page: page).subscribe(onNext: { [weak self] response in
            
            guard let self = self else {
                return
            }

            /// If refreshing, remove the old content
            if isRefreshing {
                self.newsList.removeAll()
            }
            
            self.newsList.append(contentsOf: response?.articles ?? [])
            self.totalItems = response?.totalResults ?? 0
            
            /// Call the result state backback
            self.resultState()
            
            },  onError: { [weak self] error in
                
                guard let self = self else {
                    return
                }
                
                self.errorState(error)
                
            }).disposed(by: disposeBag)
    }
    
    /// Returns whether you should get the next page or not
    func shouldGetNextPage(withCellIndex index: Int) -> Bool{
        
        /// if reached the last cell && not reached the total number of items then reload next page
        if index == newsList.count - 1 {
            if totalItems > newsList.count {
                return true
            }
        }
        return false
    }
    
    /// Get next news page
    func getNextPage() {
        page += 1
        getNews()
    }
    
    /// Refresh the content
    func refreshNews() {
        page = 1
        getNews(isRefreshing: true)
    }
}

// MARK: Datasource
extension NewsViewModel {

    func numberOfRows() -> Int {
        return newsList.count
    }
    
    func item(at indexPath: IndexPath) -> Article {
        return newsList[indexPath.row]
    }
    
    func isEmpty() -> Bool {
        return newsList.count == 0
    }
}
