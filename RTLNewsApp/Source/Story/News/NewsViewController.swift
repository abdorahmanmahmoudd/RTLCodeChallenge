//
//  NewsViewController.swift
//  RTLNewsApp
//
//  Created by Abdorahman on 28/05/2020.
//  Copyright © 2020 Abdorahman. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class NewsViewController: BaseViewController  {
    
    /// News listing table view
    private var newsTableView = UITableView()
    
    /// NewsViewModel
    private var viewModel: NewsViewModel!
    
    /// Refresh control
    private let refreshControl = UIRefreshControl()
    
    /// RxSwift
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Set navigation bar title
        styleNavigationItem()
        
        /// Configure news table view and add it
        view.addSubview(newsTableView)
        configureNewsTableView()
        
        bindObservables()
        viewModel.getNews()
    }
    
    /// Set navigation bar title
    private func styleNavigationItem() {
        title = "RTL_NEWS".localized
    }
    
    /// Configure News table view
    private func configureNewsTableView() {

        /// Set delegate, datasource and refresh control
        newsTableView.delegate = self
        newsTableView.dataSource = self
        newsTableView.refreshControl = refreshControl
        
        /// Register the cell
        let listTeaserNib = UINib(nibName: ListTeaserTableViewCell.identifier, bundle: nil)
        newsTableView.register(listTeaserNib, forCellReuseIdentifier: ListTeaserTableViewCell.identifier)

        /// Activate constraints and set row height
        newsTableView.activateConstraints(for: view)
        newsTableView.rowHeight = Constants.Theme.ListTeaserRowHeight
    }
    
    private func bindObservables() {

        /// Set view model state change callback
        viewModel.refreshState = { [weak self] in
            
            guard let self = self else {
                return
            }
            
            /// end refreshing anyways
            self.refreshControl.endRefreshing()
            
            switch self.viewModel.state {
                
            case .initial:
                debugPrint("initial NewsViewController")
                
            case .loading:
                debugPrint("loading NewsViewController")
                self.showLoadingIndicator(visible: true)
                
                
            case .error(let error):
                debugPrint("error \(String(describing: error))")
                self.showLoadingIndicator(visible: false)
                
                /// If there is an error then show error view with that error and try again button
                self.showError(with: "GENERAL_EMPTY_STATE_ERROR".localized, message: error?.localizedDescription, retry: {
                        self.viewModel.getNews()
                })
                return
                
            case .result:
                debugPrint("result NewsViewController")
                self.showLoadingIndicator(visible: false)
                
                /// If there is no results then show a message with a try again button
                if self.viewModel.isEmpty() {
                    
                    self.showError(with: "GENERAL_EMPTY_STATE_ERROR".localized, retry: {
                        self.viewModel.getNews()
                    })
                    return
                }
                self.newsTableView.reloadData()
            }
        }
        
        /// Bind Refresh control value changed event to refresh the content
        refreshControl.rx.controlEvent(.valueChanged)
            .asObservable()
            .debounce(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                
                guard let self = self else {
                    return
                }

                self.viewModel.refreshNews()
                
            }).disposed(by: disposeBag)
    }
    
    /// Push Article Details  view controller
    private func pushArticle(with indexPath: IndexPath) {
        let articleDetailViewModel = ArticleDetailsViewModel(article: viewModel.item(at: indexPath))
        let articleDetailsViewController = ArticleDetailsViewController.create(payload: articleDetailViewModel)
        navigationController?.pushViewController(articleDetailsViewController, animated: true)
    }
}

// MARK: UITableViewDelegate
extension NewsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        /// check if we should fetch the next page
        if viewModel.shouldGetNextPage(withCellIndex: indexPath.row) {
            viewModel.getNextPage()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pushArticle(with: indexPath)
    }
}

// MARK: UITableViewDataSource
extension NewsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTeaserTableViewCell.identifier, for: indexPath) as? ListTeaserTableViewCell else {
            fatalError("Couldn't dequeue a cell!")
        }
        cell.configure(with: viewModel.item(at: indexPath))
        return cell
    }

}

// MARK: Injectable
extension NewsViewController: Injectable {
    
    typealias Payload = NewsViewModel
    
    func inject(payload: NewsViewModel) {
        viewModel = payload
    }
    
    func assertInjection() {
        assert(viewModel != nil)
    }
}
