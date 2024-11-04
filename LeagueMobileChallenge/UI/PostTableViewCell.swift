//
//  PostTableViewCell.swift
//  LeagueMobileChallenge
//
//  Created by Steven Rockarts on 2024-11-03.
//
import UIKit

class PostTableViewCell: UITableViewCell {
    static let identifier = "PostCell"
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var postBodyLabel: UILabel!
    
}
