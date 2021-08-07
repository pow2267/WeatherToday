//
//  DetailViewController.swift
//  WeatherToday
//
//  Created by kwon on 2021/08/07.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var rainfallLabel: UILabel!
    var selectedCellData: CustomCityTableViewCell?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = self.selectedCellData?.cityNameLabel.text

        var weather: String
        
        switch self.selectedCellData?.state {
        case 10:
            weather = "맑음"
        case 11:
            weather = "구름"
        case 12:
            weather = "비"
        case 13:
            weather = "눈"
        default:
            weather = ""
        }
        
        self.weatherImage.image = self.selectedCellData?.weatherImage.image
        self.weatherLabel.text = weather
        self.temperatureLabel.text = self.selectedCellData?.temperatureLabel.text
        self.rainfallLabel.text = self.selectedCellData?.rainfallLabel.text
        
        self.temperatureLabel.textColor = self.selectedCellData?.temperatureLabel.textColor
        self.rainfallLabel.textColor = self.selectedCellData?.rainfallLabel.textColor
    }
}
