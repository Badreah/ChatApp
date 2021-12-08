//
//  ViewController.swift
//  ChatApp
//
//  Created by Badreah Saad on 07/12/2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    
    
    @IBOutlet weak var userTabel: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userTabel.delegate = self
        userTabel.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userTabel.dequeueReusableCell(withIdentifier: "user") as! UserCell
        return cell
    }
}

