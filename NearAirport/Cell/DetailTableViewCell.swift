//
//  DetailTableViewCell.swift
//  NearAirport
//
//  Created by Behera, Nandana (Cognizant) on 31/07/2019.
//  Copyright © 2019 Behera, Nandana (Cognizant). All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

     @IBOutlet weak var airportName: UILabel!
     @IBOutlet weak var runwayLength: UILabel!
     @IBOutlet weak var city: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
