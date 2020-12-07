//
//  HomeTableViewViewController.swift
//  Insta-X
//
//  Created by Youssef Osama on 29/11/2020.
//

import UIKit

class HomeTableViewViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func NKPlaceholderImage(image:UIImage?, imageView:UIImageView?,imgUrl:String,compate:@escaping (UIImage?) -> Void){
        
        if image != nil && imageView != nil {
            imageView!.image = image!
        }
        
        var urlcatch = imgUrl.replacingOccurrences(of: "/", with: "#")
        let documentpath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        urlcatch = documentpath + "/" + "\(urlcatch)"
        
        let image = UIImage(contentsOfFile:urlcatch)
        if image != nil && imageView != nil
        {
            imageView!.image = image!
            compate(image)
            
        }else{
            
            if let url = URL(string: imgUrl){
                
                DispatchQueue.global(qos: .background).async {
                    () -> Void in
                    let imgdata = NSData(contentsOf: url)
                    DispatchQueue.main.async {
                        () -> Void in
                        imgdata?.write(toFile: urlcatch, atomically: true)
                        let image = UIImage(contentsOfFile:urlcatch)
                        compate(image)
                        if image != nil  {
                            if imageView != nil  {
                                imageView!.image = image!
                            }
                        }
                    }
                }
            }
        }
    }
    
    var latestPosts = [Datum]() {
        didSet{
            tableView.reloadData()
            collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return latestPosts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        let posts = latestPosts[indexPath.row]
        cell.userName.text = posts.user.username
        cell.viewcount.text = "\(posts.viewsCount) views"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 30) / 2
        return CGSize(width: width, height: 350)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    //Seperator
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        latestPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
     
        cell.backgroundColor = .white
        let posts = latestPosts[indexPath.row]
        NKPlaceholderImage(image: UIImage(named: "Image"), imageView: nil, imgUrl: posts.file) { (image) in
            cell.mainPic.image = image
        }
        NKPlaceholderImage(image: UIImage(named: "Image"), imageView: nil, imgUrl: posts.user.image) { (image) in
            cell.profilePic.image = image
        }
        cell.username.text = posts.user.username
        cell.llikeCount.text = "\(posts.likesCount)"
        cell.replyCount.text = "\(posts.commentsCount)"
        cell.shareCount.text = "\(posts.sharesCount)"
       return cell
          
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 245
    }
    

        

  
    @IBOutlet weak var collectionViewOutlet: UIButton!
    @IBOutlet weak var tableViewOutlet: UIButton!
    @IBAction func searchButton(_ sender: Any) {}
    @IBAction func tableViewSelBut(_ sender: Any) {
        
        tableView.isHidden = false
        collectionView.isHidden = true
        tableViewOutlet.setBackgroundImage(#imageLiteral(resourceName: "Icons - List - Selected"), for: .normal)
        collectionViewOutlet.setBackgroundImage(#imageLiteral(resourceName: "Icons - Grid - Normal"), for: .normal)
        
    }
    @IBAction func collectionViewselBut(_ sender: Any) {

        tableView.isHidden = true
        collectionView.isHidden = false
        collectionViewOutlet.setBackgroundImage(#imageLiteral(resourceName: "Icon ionic-ios-checkmark-circle"), for: .normal)
        tableViewOutlet.setBackgroundImage(#imageLiteral(resourceName: "Icons - List - Selected-1"), for: .normal)
        
    }
    @IBOutlet weak var seperator: UILabel!
    @IBOutlet weak var homeLabel: UILabel!
    @IBOutlet weak var countryImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Network.Request(LatestPosts.self, url: "https://alfreeej-store.com/insta/api/posts?page=1&country_id=1") { (model) in
            self.latestPosts = model.data
        } onFailure: { (error) in
            print(error)
        }

        tableViewOutlet.setBackgroundImage(#imageLiteral(resourceName: "Icons - List - Selected"), for: .normal)
        tableView.register(UINib(nibName: "TableViewCell", bundle: .main), forCellReuseIdentifier: "TableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        collectionView.register(UINib.init(nibName: "CollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "CollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
}
