//
//  ArticleDetailsViewController.swift
//  RTLNewsApp
//
//  Created by Abdorahman on 31/05/2020.
//  Copyright © 2020 Abdorahman. All rights reserved.
//

import UIKit

final class ArticleDetailsViewController: BaseViewController {
    
    /// Article details view model
    private var viewModel: ArticleDetailsViewModel!
    
    /// Scroll view
    private var scrollView = UIScrollView()
    
    /// Article details view
    private var articleDetailsView: ArticleView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleNavigationItem()

        /// Embed and constraint the scroll view
        configureScrollView()
        
        /// Embed and configure the `ArticleView`
        configureArticleDetailsView()
    }
    
    private func styleNavigationItem() {
        navigationController?.navigationBar.topItem?.title = ""
    }
    
    private func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.activateConstraints(for: view)
        
        scrollView.backgroundColor = .white
    }
    
    
    private func configureArticleDetailsView() {
        
        guard let articleDetailsView = ArticleView().loadNib() as? ArticleView else {
            fatalError("Couldn't embed ArticleDetails View")
        }
        scrollView.addSubview(articleDetailsView)
        articleDetailsView.activateConstraints(for: scrollView)
        
        /// Set Article details view width to adjust the scroll view width
        articleDetailsView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        
        /// Fill article details view data
        articleDetailsView.configure(with: viewModel.article)
        
        self.articleDetailsView = articleDetailsView
    }

}

// MARK: Injectable
extension ArticleDetailsViewController: Injectable {
    
    typealias Payload = ArticleDetailsViewModel
    
    func inject(payload: ArticleDetailsViewModel) {
        viewModel = payload
    }
    
    func assertInjection() {
        assert(viewModel != nil)
    }
}

