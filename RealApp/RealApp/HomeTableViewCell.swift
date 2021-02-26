//
//  HomeTableViewCell.swift
//  RealApp
//
//  Created by user186492 on 23.02.2021.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

 
    @IBOutlet weak var myImage: UIImageView!
    
    @IBOutlet weak var myText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
