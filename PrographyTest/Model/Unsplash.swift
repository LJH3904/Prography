//
//  Unsplash.swift
//  PrographyTest
//
//  Created by LJh on 2/2/24.
//

import Foundation

struct Unsplash: Codable, Identifiable {
    let id: String
    let urls: Urls
    let description: String?
    let title: String
    let user: User
    let tags: [Tag]?
    enum CodingKeys: String, CodingKey {
        case id
        case urls
        case description
        case title = "alt_description"
        case user
        case tags
    }
}

struct Urls: Codable {
    let regular: String
}

struct User: Codable {
    let id: String
    let username: String
}

struct Tag: Codable, Hashable {
    let title: String
}

let tempUnsplash =
Unsplash(id: "",
         urls: Urls(regular: "https://health.chosun.com/site/data/img_dir/2023/07/17/2023071701753_0.jpg"),
         description: "description",
         title: "title",
         user: User(id: "ss",
                    username: "userName"), tags: [Tag(title: "No tag")]
)



