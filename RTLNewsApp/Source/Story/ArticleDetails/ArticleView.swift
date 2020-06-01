//
//  ArticleView.swift
//  RTLNewsApp
//
//  Created by Abdorahman on 31/05/2020.
//  Copyright © 2020 Abdorahman. All rights reserved.
//

import UIKit
import Nuke

class ArticleView: UIView {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var articleTitle: UILabel!
    @IBOutlet private weak var author: UILabel!
    @IBOutlet private weak var publishingDate: UILabel!
    @IBOutlet private weak var articleDescription: UILabel!
    @IBOutlet private weak var articleContent: UILabel!
    
    /// Article URL
    private var articleURL: URL? = nil
    
    /// Fill in the data
    func configure(with article: Article) {
        
        if let urlString = article.urlToImage, let url = URL(string: urlString) {
            Nuke.loadImage(with: url, into: imageView)
        } else {
            imageView.image = UIImage(named: "image-placeholder")
        }

        articleTitle.text = article.title
        author.text = article.author
        publishingDate.text = article.publishedAt
        articleDescription.text = article.description
        articleContent.text = article.content
        
        if let urlString = article.url, let url = URL(string: urlString) {
            articleURL = url
        }
    }

    @IBAction func openArticleTapped(_ sender: UIButton) {
        guard let url = articleURL else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
