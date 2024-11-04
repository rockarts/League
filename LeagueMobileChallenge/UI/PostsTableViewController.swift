//
//  PostsTableViewController.swift
//  LeagueMobileChallenge
//
//  Created by Steven Rockarts on 2024-11-03.
//  Copyright © 2024 Kelvin Lau. All rights reserved.
//

import UIKit
import SDWebImage

class PostsTableViewController: UITableViewController {
    
    private var viewModel = PostViewModel()
    private var posts: [UserPosts] = []
    private var errorMessage: String?
    
    private enum TableState {
        case loading
        case loaded
        case error(String)
    }
    
    private var state: TableState = .loading {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Posts"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ErrorCell")
        
        Task {
            await loadPosts()
        }
    }
    
    private func loadPosts() async {
        state = .loading
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
        
        
        tableView.refreshControl?.beginRefreshing()
        
        do {
            
            posts = try await viewModel.getPosts()

            await MainActor.run {
                tableView.refreshControl?.endRefreshing()
                if posts.isEmpty {
                    state = .error("No posts available.\nPull to refresh and try again.")
                } else {
                    state = .loaded
                }
            }
        } catch let error as APIError {
            await MainActor.run {
                state = .error("\(error.localizedDescription)\nPull to refresh and try again.")
                tableView.refreshControl?.endRefreshing()
            }
        } catch {
            await MainActor.run {
                state = .error("Something went wrong.\nPull to refresh and try again.")
                tableView.refreshControl?.endRefreshing()
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch state {
        case .loading:
            return 0
        case .loaded:
            return posts.count
        case .error:
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch state {
        case .loaded:
            let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as! PostTableViewCell
            let post = posts[indexPath.row]
            
            cell.postTitleLabel.text = post.title
            cell.postBodyLabel?.text = post.body
            cell.userNameLabel?.text = post.username
            
            if let imageUrlString = post.avatarImage,
               let imageUrl = URL(string: imageUrlString) {
                cell.avatarImageView.sd_setImage(
                    with: imageUrl,
                    placeholderImage: UIImage(systemName: "person.circle.fill"),
                    options: .refreshCached) { (image, error, cacheType, url) in
                        if let error = error {
                            print("Error loading image: \(error)")
                        }
                    }
            }
            cell.avatarImageView.layer.cornerRadius = 25
            cell.avatarImageView.clipsToBounds = true
            return cell
            
        case .error(let message):
            let cell = tableView.dequeueReusableCell(withIdentifier: "ErrorCell", for: indexPath)

            var content = cell.defaultContentConfiguration()
            content.text = message
            content.textProperties.alignment = .center
            content.textProperties.color = .systemGray
            content.textProperties.numberOfLines = 0
            cell.contentConfiguration = content
            cell.selectionStyle = .none
            return cell
            
        case .loading:
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if case .error = state {
            return tableView.bounds.height
        }
        return UITableView.automaticDimension
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if refreshControl == nil {
            refreshControl = UIRefreshControl()
            refreshControl?.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        }
    }
    
    @objc private func handleRefresh() {
        Task {
            await loadPosts()
        }
    }
}
