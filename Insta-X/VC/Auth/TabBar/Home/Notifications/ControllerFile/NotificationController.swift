//
//  NotificationController.swift
//  Insta-X
//
//  Created by Youssef Osama on 02/12/2020.
//

import UIKit

class NotificationController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var NotificationsLabel: UILabel!
    @IBAction func backArrowButton(_ sender: Any) {
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationCell
        
        cell.backgroundColor = .white
        
       return cell
          
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "NotificationCell", bundle: .main), forCellReuseIdentifier: "NotificationCell")
        tableView.dataSource = self
        tableView.delegate = self

        // Do any additional setup after loading the view.
    }

}
