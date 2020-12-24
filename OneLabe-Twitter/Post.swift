//
//  Post.swift
//  OneLabe-Twitter
//
//  Created by admin on 12/22/20.
//

import Foundation

struct Post: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
