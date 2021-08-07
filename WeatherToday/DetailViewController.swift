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
    var selectedCell: CustomCityTableViewCell?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = self.selectedCell?.cityNameLabel.text

        var weather: String
        
        switch self.selectedCell?.state {
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
        
        // 이전 뷰 컨트롤러에서 전달받은 cell의 데이터를 꺼내 뷰에 입력
        self.weatherImage.image = self.selectedCell?.weatherImage.image
        self.weatherLabel.text = weather
        self.temperatureLabel.text = self.selectedCell?.temperatureLabel.text
        self.rainfallLabel.text = self.selectedCell?.rainfallLabel.text
        
        self.temperatureLabel.textColor = self.selectedCell?.temperatureLabel.textColor
        self.rainfallLabel.textColor = self.selectedCell?.rainfallLabel.textColor
    }
}
