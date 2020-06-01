//
//  API.swift
//  RTLNewsApp
//
//  Created by Abdorahman on 29/05/2020.
//  Copyright © 2020 Abdorahman. All rights reserved.
//

import Foundation
import RxSwift

// MARK: - NetworkRequests
protocol NetworkRequests {
    func getNews(country: String, page: Int) -> Observable<NewsResponse?>
}

// MARK: Real implementation of the APIs
final class API: NSObject, NetworkRequests {
        
    func getNews(country: String, page: Int) -> Observable<NewsResponse?> {
        
        guard let fullURL = URL(string: "\(Constants.baseURL)/v2/top-headlines?country=\(country)&apiKey=\(Constants.apiKey)&page=\(page)") else {
            return .error(API.Error.invalidURL)
        }
        
        var request = URLRequest(url: fullURL)
        request.httpMethod = "GET"
        
        return URLSession.shared.response(request: request)
            .asObservable()
            .observeOn(MainScheduler.instance)
            .map { response, data -> NewsResponse? in
                return try? JSONDecoder().decode(NewsResponse.self, from: data)
        }
    }
}
