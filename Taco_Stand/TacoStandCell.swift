//
//  TacoStandCell.swift
//  Taco_Stand
//
//  Created by Toleen Jaradat on 7/26/16.
//  Copyright © 2016 Toleen Jaradat. All rights reserved.
//

import UIKit

class TacoStandCell: UITableViewCell {
    
    @IBOutlet weak var img: UIImageView!

    @IBOutlet weak var title: UILabel!

    @IBOutlet weak var price: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
