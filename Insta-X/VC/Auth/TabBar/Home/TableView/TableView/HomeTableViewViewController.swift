//
//  HomeTableViewViewController.swift
//  Insta-X
//
//  Created by Youssef Osama on 29/11/2020.
//

import UIKit

class HomeTableViewViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        
        cell.backgroundColor = .white
        
       return cell
          
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
    }
    
    
  
    @IBOutlet weak var collectionViewOutlet: UIButton!
    @IBOutlet weak var tableViewOutlet: UIButton!
    @IBAction func searchButton(_ sender: Any) {}
    @IBAction func tableViewSelBut(_ sender: Any) {
        
        
    }
    @IBAction func collectionViewselBut(_ sender: Any) {}
    @IBOutlet weak var seperator: UILabel!
    @IBOutlet weak var homeLabel: UILabel!
    @IBOutlet weak var countryImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "TableViewCell", bundle: .main), forCellReuseIdentifier: "TableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
}
