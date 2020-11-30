//
//  TableViewCell.swift
//  Insta-X
//
//  Created by Youssef Osama on 29/11/2020.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var saveButton: UIImageView!
    @IBOutlet weak var moreOptions: UIImageView!
    @IBOutlet weak var mainPic: UIImageView!
    @IBOutlet weak var playButton: UIImageView!
    @IBOutlet weak var heartImage: UIImageView!
    @IBOutlet weak var llikeCount: UILabel!
    @IBOutlet weak var replyImage: UIImageView!
    @IBOutlet weak var replyCount: UILabel!
    @IBOutlet weak var shareImage: UIImageView!
    @IBOutlet weak var shareCount: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
