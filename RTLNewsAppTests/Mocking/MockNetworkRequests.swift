//
//  MockNetworkRequests.swift
//  RTLNewsAppTests
//
//  Created by Abdorahman on 01/06/2020.
//  Copyright © 2020 Abdorahman. All rights reserved.
//

import Foundation
import RxSwift
@testable import RTLNewsApp

enum MockError: Error {
    case error
    case noData
    case decodingError
}

enum MockNetworkRequestsResponse {
    case success
    case error
}

final class MockNetworkRequests: NetworkRequests {
    
    /// Config for Succes or Failure
    private let responseType: MockNetworkRequestsResponse
    
    init(responseType: MockNetworkRequestsResponse) {
        self.responseType = responseType
    }
        
    func getNews(country: String, page: Int) -> Observable<NewsResponse?> {
        
        switch responseType {
        case .success:
            return MockResponse(responseType: .success, api: .news).newsResponse()
            
        default:
            return MockResponse(responseType: .error, api: .news).newsResponse()
        }
    }
}
