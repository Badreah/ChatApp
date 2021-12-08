//
//  ChatCell.swift
//  ChatApp
//
//  Created by Badreah Saad on 07/12/2021.
//

import UIKit

class ChatCell: UITableViewCell {
    
    
    @IBOutlet weak var user: UILabel!
    @IBOutlet weak var chat: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
    
}
