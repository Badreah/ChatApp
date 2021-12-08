//
//  SignInVC.swift
//  ChatApp
//
//  Created by Badreah Saad on 07/12/2021.
//

import UIKit
import Firebase

class SignInVC: UIViewController {
    
    let fireStoreURL = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func signIn(_ sender: Any) {
        
        if Auth.auth().currentUser?.uid == nil {
            Auth.auth().signInAnonymously { user, error in
                if error == nil {
                    let userData = ["Name":"User","ID":user?.user.uid]
                    self.fireStoreURL.collection("Users").document((user?.user.uid)!).setData(userData)
                    self.performSegue(withIdentifier: "next", sender: self)
                }
            }
        } else {
            self.performSegue(withIdentifier: "next", sender: self)
        }
    }
    
    
    
}
