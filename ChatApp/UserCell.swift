//
//  UserCell.swift
//  ChatApp
//
//  Created by Badreah Saad on 07/12/2021.
//

import UIKit

class UserCell: UITableViewCell {
    
    
    @IBOutlet weak var userName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
