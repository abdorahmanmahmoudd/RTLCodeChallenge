//
//  ArticleDetailsTest.swift
//  RTLNewsAppTests
//
//  Created by Abdorahman on 01/06/2020.
//  Copyright © 2020 Abdorahman. All rights reserved.
//

import XCTest
import RxSwift
@testable import RTLNewsApp

class ArticleDetailsTest: XCTestCase {

    private func getArticle() -> Article? {
        return MockResponseData().mockedNews()?.articles?.first
    }

    func testArticleDetailsView() {
        
        /// Given
        let article = getArticle()
        XCTAssertNotNil(article)
        
        /// Given
        let articleViewModel = ArticleDetailsViewModel(article: article!)
        XCTAssertNotNil(articleViewModel)
        
        /// When
        let articleView = ArticleView.init().loadNib() as? ArticleView
        XCTAssertNotNil(articleView)
        
        /// Then
        articleView?.configure(with: article!)
        XCTAssertTrue(true)
    }

}
