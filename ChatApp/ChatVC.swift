//
//  ChatCell.swift
//  ChatApp
//
//  Created by Badreah Saad on 07/12/2021.
//

import UIKit
import Firebase

class ChatVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var chatTabel: UITableView!
    @IBOutlet weak var massge: UITextField!
    
    var userId: String?
    var userName: String?
    
    let myID = Auth.auth().currentUser?.uid
    
    let fireStoreURL = Firestore.firestore()
    
    var usersMSGArray: [UsersMSG] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatTabel.delegate = self
        chatTabel.dataSource = self
        
        sendMSG(idUser: userId!)
    }
    
    
    func sendMSG(idUser: String) {
        
        usersMSGArray.removeAll()
        
        fireStoreURL.collection("Users").document(myID!).collection("Messages").document(self.userId!).collection("msg").order(by: "date").addSnapshotListener { snapSot, error in
            self.usersMSGArray.removeAll()
            for id in snapSot!.documents {
                print(id.documentID)
                print("content", id.get("content"))
                
                self.usersMSGArray.append(UsersMSG(id: id.get("idUser")! as! String, content: id.get("content")! as! String))
            }
            self.chatTabel.reloadData()
        }
    }
    
    
    func sendingDate() -> String {
        let format = DateFormatter()
        format.dateFormat = "dd/mm/yyyy hh:mm:ss a"
        let date = format.string(from: Date())
        return date
    }
    
    
    @IBAction func sendMassge(_ sender: Any) {
        let msg = [ "idUser": myID, "date": sendingDate(), "content": massge.text! ]
        
        fireStoreURL.collection("Users").document(myID!).collection("Messages").document(userId!).collection("msg").document().setData(msg)
        
        fireStoreURL.collection("Users").document(userId!).collection("Messages").document(myID!).collection("msg").document().setData(msg)
        
        sendMSG(idUser: userId!)
        
    }
    
    
    
    
}




extension ChatVC {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersMSGArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = chatTabel.dequeueReusableCell(withIdentifier: "chat", for: indexPath) as! ChatCell
        
        if myID == usersMSGArray[indexPath.row].id {
            cell.user.text = "Me"
            cell.chat.text = usersMSGArray[indexPath.row].content
        } else if userId == usersMSGArray[indexPath.row].id {
            cell.user.text = "other User"
            cell.chat.text = usersMSGArray[indexPath.row].content
        }
        return cell
    }
    
    
}


struct UsersMSG {
    var id: String
    var content: String?
}
