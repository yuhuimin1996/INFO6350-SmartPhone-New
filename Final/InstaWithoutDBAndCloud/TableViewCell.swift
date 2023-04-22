//
//  TableViewCell.swift
//  InstaWithoutDBAndCloud
//
//  Created by 于慧敏 on 4/21/23.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var imageContainer: UIImageView!
    
    
    @IBOutlet weak var lblTitle: UILabel!
    
    
    @IBOutlet weak var lblLocation: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
