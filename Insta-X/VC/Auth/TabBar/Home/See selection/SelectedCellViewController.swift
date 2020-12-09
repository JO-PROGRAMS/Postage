//
//  SelectedCellViewController.swift
//  Insta-X
//
//  Created by Youssef Osama on 09/12/2020.
//

import UIKit
import SDWebImage
class SelectedCellViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    @IBOutlet weak var mainPic: UIImageView!
    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var commentCount: UILabel!
    @IBOutlet weak var shareCount: UILabel!
    @IBOutlet weak var commentSection: UITableView!
    @IBOutlet weak var enterCommenttxt: UITextField!
    @IBOutlet weak var profilePic: UIImageView!
    
    var mainImage: UIImage? = nil {
        didSet {
            mainPic.image = mainImage
        }
    }
    var celluserName: String? = "Michelle" {
        didSet {
            commentSection.reloadData()
        }
    }
    var cellAgo = "2 hours Ago" {
        didSet {
            commentSection.reloadData()
        }
    }
    
    var cellComment: String? = "#fashion #LOL #lol #Code" {
        didSet {
            commentSection.reloadData()
        }
    }
    
    var likesCount: Int? = nil {
        didSet {
            likeCount.text = "\(likesCount)"
        }
    }
    
    var commentsCount: Int? = 1{
        didSet {
            commentCount.text = "\(commentsCount)"
        }
    }
    
    var sharesCount: Int? = nil {
        didSet {
            shareCount.text = "\(sharesCount)"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectedCell", for: indexPath) as! SelectedCell
        
        cell.userName.text = self.celluserName
        cell.timeAgo.text = self.cellAgo
        cell.commentLabel.text = self.cellComment
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentSection.delegate = self
        commentSection.dataSource = self
        commentSection.register(UINib(nibName: "SelectedCell", bundle: .main), forCellReuseIdentifier: "SelectedCell")
        // Do any additional setup after loading the view.
        
    }




}
