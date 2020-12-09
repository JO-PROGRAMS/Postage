//
//  UIImageView+.swift
//  Insta-X
//
//  Created by Youssef on 09/12/2020.
//

import UIKit
import SDWebImage

extension UIImageView {
    func loadWebImage(url: String?) {
        let imageUrl = URL(string: url ?? "")
        
        self.sd_setImage(with: imageUrl, placeholderImage: nil, options: [.continueInBackground]) { (image, _, _, _) in
            self.image = image
        }
    }
}
