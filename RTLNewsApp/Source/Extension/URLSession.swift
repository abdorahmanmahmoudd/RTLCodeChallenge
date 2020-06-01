//
//  URLSession.swift
//  RTLNewsApp
//
//  Created by Abdorahman on 29/05/2020.
//  Copyright © 2020 Abdorahman. All rights reserved.
//

import Foundation
import RxSwift

extension URLSession {
    
    enum URLErrorUnknown: Error {
        case unknown
        case nonHTTPResponse(response: URLResponse)
    }
    
    func response(request: URLRequest) -> Observable<(response: HTTPURLResponse, data: Data)> {
        return Observable.create { observer in
            let task = self.dataTask(with: request) { data, response, error in
                
                guard let response = response, let data = data else {
                    observer.on(.error(error ?? URLErrorUnknown.unknown))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    observer.on(.error(URLErrorUnknown.nonHTTPResponse(response: response)))
                    return
                }
                
                guard (200 ..< 300) ~= httpResponse.statusCode, error == nil else {
                    return observer.on(.error(API.Error.httpErrorCode(httpResponse.statusCode)))
                }
                
                observer.on(.next((httpResponse, data)))
                observer.on(.completed)
            }
            
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
