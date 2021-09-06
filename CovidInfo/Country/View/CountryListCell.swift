//
//  CountryListCell.swift
//  CovidInfo
//
//  Created by Ajay Yadav on 02/09/21.
//

import UIKit

class CountryListCell: UITableViewCell {

    @IBOutlet weak var vwContentCell: UIView!
    @IBOutlet weak var lblCountryName: UILabel!
    @IBOutlet weak var lblIso2: UILabel!
    @IBOutlet weak var lblSlug: UILabel!
    @IBOutlet weak var lblCountryFlag: UILabel!

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
