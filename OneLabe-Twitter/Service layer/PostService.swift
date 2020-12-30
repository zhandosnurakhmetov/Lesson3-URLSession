//
//  PostService.swift
//  OneLabe-Twitter
//
//  Created by admin on 12/30/20.
//

import Foundation

protocol PostService {
    func fetchPosts(success: @escaping ([Post]) -> Void, failure: @escaping (Error) -> Void)
    func updatePost(by id: Int)
    func removePost(by id: Int)
    func obtainPosts() -> [Post]
}

final class PostServiceImpl: PostService {

    private let dataProvider: PostDataProvider = PostNetworkDataProvider()
    private let localStorage: PostsLocalStorage = PostsLocalStorageImpl()

    func fetchPosts(success: @escaping ([Post]) -> Void, failure: @escaping (Error) -> Void) {
        if localStorage.obtainPost().isEmpty {
            dataProvider.fetchPosts { [weak self] posts in
                self?.localStorage.save(posts: posts)
                success(posts)
            } failure: { error in
                failure(error)
            }
        } else {
            success(localStorage.obtainPost())
        }
    }

    func updatePost(by id: Int) {
        print(id)
    }

    func removePost(by id: Int) {
        var temp = 0
        var name = ""
        //
        //
        //
        //
    }

    func obtainPosts() -> [Post] {
        return []
    }
}
