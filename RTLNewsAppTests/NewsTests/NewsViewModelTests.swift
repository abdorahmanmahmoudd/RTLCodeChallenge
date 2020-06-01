//
//  NewsViewModelTests.swift
//  RTLNewsAppTests
//
//  Created by Abdorahman on 01/06/2020.
//  Copyright © 2020 Abdorahman. All rights reserved.
//

import XCTest
import RxSwift
@testable import RTLNewsApp

class NewsViewModelTests: XCTestCase {

    /// Returns `NewsViewModel` injected with `MockNetworkRequests`
    private func newsViewModel(responseType: MockNetworkRequestsResponse) -> NewsViewModel {
        
        let api = MockNetworkRequests(responseType: responseType)
        return NewsViewModel(api: api)
    }
    
    func testNewsReceived() {
        /// Given
        let viewModel = newsViewModel(responseType: .success)
        
        /// Then
        viewModel.refreshState = {
            switch viewModel.state {
            case .result:
                /// Then
                XCTAssert(!viewModel.isEmpty())
            case .error:
                /// Then
                XCTAssert(false)
            default:
                break
            }
        }
        
        /// When
        viewModel.getNews()
    }
    
    func testNewsError() {
        /// Given
        let viewModel = newsViewModel(responseType: .error)
        
        /// Then
        viewModel.refreshState = {
            switch viewModel.state {
            case .result:
                /// Then
                XCTAssert(false)
            case .error:
                /// Then
                XCTAssert(true)
            default:
                break
            }
        }
        
        /// When
        viewModel.getNews()
    }
    
    func testNewsEmpty() {
        
        /// Given
        let viewModel = newsViewModel(responseType: .error)
        
        /// When
        viewModel.getNews()
        
        /// Then
        XCTAssert(viewModel.isEmpty())
    }
    
    func testNewsNextPage() {
        
        /// Given
        let viewModel = newsViewModel(responseType: .success)
        
        /// Then
        viewModel.refreshState = {
            switch viewModel.state {
            case .result:
                /// Then
                XCTAssert(!viewModel.isEmpty())
            case .error:
                /// Then
                XCTAssert(false)
            default:
                break
            }
        }
        
        /// When
        viewModel.getNextPage()
    }
    
    func testRefreshNews() {
        
        /// Given
        let viewModel = newsViewModel(responseType: .success)
        
        /// Then
        viewModel.refreshState = {
            switch viewModel.state {
            case .result:
                /// Then
                XCTAssert(!viewModel.isEmpty())
            case .error:
                /// Then
                XCTAssert(false)
            default:
                break
            }
        }
        
        /// When
        viewModel.refreshNews()
    }

}
