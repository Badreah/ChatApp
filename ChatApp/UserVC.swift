//
//  UserVC.swift
//  ChatApp
//
//  Created by Badreah Saad on 07/12/2021.
//

import UIKit
import Firebase

class UserVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var userTabel: UITableView!
    
    var usersArray: [Users] = []
    let fireStoreURL = Firestore.firestore()
    
    var userIdSend: String?
    var userNameSend: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userTabel.delegate = self
        userTabel.dataSource = self
        getUsersFromFireStore()
    }
    
    
    func getUsersFromFireStore() {
        
        fireStoreURL.collection("Users").getDocuments { snapShot, error in
            for user in snapShot!.documents {
                //                print(id.documentID)
                print(user.data())
                if Auth.auth().currentUser?.uid != user.documentID {
                    self.usersArray.append(Users(name: user.get("Name") as! String, id: user.get("ID") as! String))
                    //                print(id.get("Name"))
                    //                print(id.get("ID"))
                }
                self.userTabel.reloadData()
            }
        }
    }
    
    
    @IBAction func signOut(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            self.dismiss(animated: true, completion: nil)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    
}



extension UserVC {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userTabel.dequeueReusableCell(withIdentifier: "user", for: indexPath) as! UserCell
        
        cell.userName.text = usersArray[indexPath.row].name
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        userNameSend = usersArray[indexPath.row].name
        userIdSend = usersArray[indexPath.row].id
        performSegue(withIdentifier: "cell", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cell" {
            let vc = segue.destination as! ChatVC
            vc.userId = userIdSend
            vc.userName = userNameSend
            
        }
    }
    
    
    
}


struct Users {
    var name: String?
    var id: String?
}
