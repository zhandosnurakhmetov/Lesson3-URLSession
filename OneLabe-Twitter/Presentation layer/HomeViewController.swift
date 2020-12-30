//
//  HomeViewController.swift
//  OneLabe-Twitter
//
//  Created by admin on 12/22/20.
//

import SnapKit

final class HomeViewController: UIViewController {

    private var viewModel = HomeViewModel()

    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        return indicator
    }()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureIndicatorView()
        viewModel.fetchPosts()
        bindViewModel()
    }

    private func bindViewModel() {
        viewModel.didStartRequest = {
            self.activityIndicator.startAnimating()
        }
        viewModel.didEndRequest = {
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
        }
        viewModel.didGetError = { error in
            print(error)
        }
    }

    private func configureTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: String(describing: PostTableViewCell.self))
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    private func configureIndicatorView() {
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = String(describing: PostTableViewCell.self)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? PostTableViewCell else { return UITableViewCell() }
        cell.usernameLabel.text = viewModel.posts[indexPath.row].title
        cell.titleLabel.text = viewModel.posts[indexPath.row].body
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = viewModel.posts[indexPath.row]
        viewModel.updatePostLikeCount(id: post.id)
    }
}
