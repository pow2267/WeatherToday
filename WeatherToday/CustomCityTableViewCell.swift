//
//  CustomCityTableViewCell.swift
//  WeatherToday
//
//  Created by kwon on 2021/08/06.
//

import UIKit

class CustomCityTableViewCell: UITableViewCell {
    
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var rainfallLabel: UILabel!
    var state: Int = 0

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
