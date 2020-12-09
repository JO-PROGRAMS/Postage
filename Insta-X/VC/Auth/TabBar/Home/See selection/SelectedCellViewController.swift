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
    
    var postData: Datum?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectedCell", for: indexPath) as! SelectedCell
        
//        cell.userName.text = self.celluserName
//        cell.timeAgo.text = self.cellAgo
//        cell.commentLabel.text = self.cellComment
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentSection.delegate = self
        commentSection.dataSource = self
        commentSection.register(UINib(nibName: "SelectedCell", bundle: .main), forCellReuseIdentifier: "SelectedCell")
        // Do any additional setup after loading the view.
        configView()
    }

    func configView() {
        mainPic.loadWebImage(url: postData?.file)
        
        guard let id = postData?.id else { return }
        
        let url = "https://alfreeej-store.com/insta/api/posts/\(id)"
        
        Network.Request(String.self, url: url) { (data) in
            print(data)
        } onFailure: { (_) in
            
        }

    }


}
