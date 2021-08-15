//
//  DetailViewController.swift
//  WeatherToday
//
//  Created by kwon on 2021/08/07.
//

import UIKit

// review: UITableViewCell은 View의 역할을 하는 클래스인데 여기서는 데이터를 전달하는 목적으로 사용되고 있습니다.
// 가급적이면 ViewController 간의 데이터 전달은 Model을 이용하는 것을 권장드립니다.
// 또한 Model에서 데이터를 가공하는 함수를 추가하여 이용한다면 ViewController에서 수행되고 있는 비즈니스로직을 최소화할 수 있습니다.
class DetailViewController: UIViewController {
    
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var rainfallLabel: UILabel!
    var city: City?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = self.city?.cityName

        var weather: String
        
        switch self.city?.state {
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
        
        var weatherImage: UIImage?
        
        switch self.city?.state {
        case 10:
            weatherImage = UIImage.init(named: "sunny")
        case 11:
            weatherImage = UIImage.init(named: "cloudy")
        case 12:
            weatherImage = UIImage.init(named: "rainy")
        default:
            weatherImage = UIImage.init(named: "snowy")
        }
        
        self.weatherImage.image = weatherImage
        self.weatherLabel.text = weather
        self.temperatureLabel.text = self.city?.temperature
        self.rainfallLabel.text = self.city?.rainfall
        
        // 조건에 따른 기상정보 text색 변경
        switch self.city?.celsius ?? 0 {
        case 25.0...:
            self.temperatureLabel.textColor = UIColor.red
        case ..<10:
            self.temperatureLabel.textColor = UIColor.blue
        default:
            self.temperatureLabel.textColor = UIColor.black
        }
        
        if self.city?.rainfallProbability ?? 0 > 50 {
            self.rainfallLabel.textColor = UIColor.orange
        } else {
            self.rainfallLabel.textColor = UIColor.black
        }
    }
}
