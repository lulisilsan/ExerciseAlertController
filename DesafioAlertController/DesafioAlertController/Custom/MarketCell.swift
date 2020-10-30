//
//  MarketCell.swift
//  DesafioAlertController
//
//  Created by Luciana on 29/10/20.
//

import UIKit

class MarketCell: UITableViewCell {
    
    @IBOutlet weak var labelItem: UILabel!
    @IBOutlet weak var labelQuantity: UILabel!
    
    func setup(item: Market) {
        labelItem.text = item.name
        labelQuantity.text = String(item.quantity)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
