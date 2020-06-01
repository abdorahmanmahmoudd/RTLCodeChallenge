//
//  MockResponseData.swift
//  RTLNewsAppTests
//
//  Created by Abdorahman on 01/06/2020.
//  Copyright © 2020 Abdorahman. All rights reserved.
//

import Foundation
import RxSwift
@testable import RTLNewsApp

class MockResponseData {}

// MARK: News Mocked Response
extension MockResponseData {

    func mockedNews() -> NewsResponse? {
        return NewsResponse(status: "ok", totalResults: 38, articles: articles())
    }
    
    private func articles() -> [Article]? {
        
        let mockedArticle = Article(author: "Abdo",
                                    title: "Software engineer",
                                    description: "Human",
                                    url: "Amstedam",
                                    urlToImage: "none",
                                    publishedAt: "1994",
                                    content: "N/A",
                                    source: Source(id: "1", name: "Abdelrahman"))
       
        
        return [mockedArticle]
    }
}
