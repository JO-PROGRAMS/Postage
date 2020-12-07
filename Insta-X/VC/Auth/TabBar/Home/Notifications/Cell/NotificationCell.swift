//
//  NotificationCell.swift
//  Insta-X
//
//  Created by Youssef Osama on 02/12/2020.
//

import UIKit

class NotificationCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var actionlbel: UILabel!
    @IBOutlet weak var profilePic: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
