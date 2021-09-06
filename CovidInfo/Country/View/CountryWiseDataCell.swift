//
//  CountryListCell.swift
//  CovidInfo
//
//  Created by Ajay Yadav on 02/09/21.
//

import UIKit

class CountryWiseDataCell: UITableViewCell {

    @IBOutlet weak var vwContentCell: UIView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblConfirmed: UILabel!
    @IBOutlet weak var lblRecovered: UILabel!
    @IBOutlet weak var lblDeath: UILabel!
    @IBOutlet weak var imgFlag: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        vwContentCell.layer.cornerRadius = 5.0
        vwContentCell.layer.shadowRadius = 5.0
        vwContentCell.layer.shadowOpacity = 0.9
        vwContentCell.layer.shadowOffset = CGSize(width: 0, height: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
