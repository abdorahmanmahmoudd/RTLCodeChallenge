//
//  News.swift
//  RTLNewsApp
//
//  Created by Abdorahman on 29/05/2020.
//  Copyright © 2020 Abdorahman. All rights reserved.
//

import Foundation

struct NewsResponse: Codable {
    var status: String?
    var totalResults: Int? = 0
    var articles: [Article]?
}

struct Article: Codable {
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
    var source: Source?
}

struct Source: Codable {
    var id: String?
    var name: String?
}
