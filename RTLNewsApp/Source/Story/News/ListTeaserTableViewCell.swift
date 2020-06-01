//
//  ListTeaserTableViewCell.swift
//  RTLNewsApp
//
//  Created by Abdorahman on 28/05/2020.
//  Copyright © 2020 Abdorahman. All rights reserved.
//

import UIKit
import Nuke

final class ListTeaserTableViewCell: UITableViewCell {

    /// the identifier should match the class name
    static let identifier = "ListTeaserTableViewCell"

    @IBOutlet private weak var teaserTitle: UILabel!
    @IBOutlet private weak var teaserImage: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        teaserImage.image = nil
        teaserTitle.text = nil
    }
    
    /// Fill the view data fields
    func configure(with article: Article) {
        
        teaserTitle.text = article.title

        if let urlString = article.urlToImage, let imageURL = URL(string: urlString) {
            Nuke.loadImage(with: imageURL, into: teaserImage)
        } else {
            teaserImage.image = UIImage(named: "image-placeholder")
        }
    }
}
