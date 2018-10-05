//
//  ChatViewCell.swift
//  Parse_chat
//
//  Created by Tu Pham on 10/4/18.
//  Copyright © 2018 Van Lao. All rights reserved.
//

import UIKit

class ChatViewCell: UITableViewCell {

    @IBOutlet weak var chatMessage: UILabel!
    
    @IBOutlet weak var UserName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
