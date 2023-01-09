//
//  ListTableViewCell.swift
//  PostalMapApp
//
//  Created by 近江伸一 on 2023/01/09.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var Address: UILabel!
    @IBOutlet weak var Phone: UILabel!
    @IBOutlet weak var number: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
