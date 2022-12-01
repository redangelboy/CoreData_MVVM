//
//  MusicTableViewCell.swift
//  Core Data
//
//  Created by Cesar Rojas on 11/28/22.
//

import UIKit

class MusicTableViewCell: UITableViewCell {

    
    @IBOutlet weak var Label1: UILabel!
    
    
    @IBOutlet weak var Label2: UILabel!
    
    
    @IBOutlet weak var Image1: UIImageView!
    
    
    @IBOutlet weak var favs: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
