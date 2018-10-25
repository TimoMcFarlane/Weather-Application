//
//  CustomTableViewCell.swift
//  Weather
//
//  Created by Timo McFarlane on 09/10/2018.
//  Copyright © 2018 Timo McFarlane. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var weatherType: UILabel!
    
    @IBOutlet weak var weatherTemp: UILabel!
    
    @IBOutlet weak var weatherDate: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
