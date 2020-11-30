//
//  CollectionViewCell.swift
//  Insta-X
//
//  Created by Youssef Osama on 30/11/2020.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var uploadedPic: UIImageView!
    @IBOutlet weak var userPic: UIImageView!
    @IBAction func playButton(_ sender: Any) {}
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var viewcount: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
