//
//  MockResponse.swift
//  RTLNewsAppTests
//
//  Created by Abdorahman on 01/06/2020.
//  Copyright © 2020 Abdorahman. All rights reserved.
//

import RxSwift
@testable import RTLNewsApp

enum APIName {
    case news
}

class MockResponse {
    
    private let responseType: MockNetworkRequestsResponse
    private let api: APIName
    
    init(responseType: MockNetworkRequestsResponse, api: APIName) {
        self.responseType = responseType
        self.api = api
    }
    
    func newsResponse() -> Observable<NewsResponse?> {
        return Observable.create { observable -> Disposable in
            
            switch self.responseType {
            case .error:
                debugPrint("TEST-LOG RESPONSE OBSERVABLE ERROR")
                observable.on(.error(MockError.error))
                
            case .success:
                debugPrint("TEST-LOG RESPONSE OBSERVABLE SUCCESS")
                let newsList = MockResponseData().mockedNews()
                observable.on(.next(newsList))
            }
            
            observable.on(.completed)
            return Disposables.create()
        }
    }
}
