//
//  CityViewController.swift
//  WeatherToday
//
//  Created by kwon on 2021/08/05.
//

import UIKit

class CityViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var koreanName: String?
    var assetName: String?
    let cellIdentifier: String = "cityCell"
    var cities: [City] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: CustomCityTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CustomCityTableViewCell else {
            preconditionFailure("테이블 뷰 셀 가져오기 실패")
        }
        
        var weatherImage: UIImage?
        
        switch self.cities[indexPath.row].state {
        case 10:
            weatherImage = UIImage.init(named: "sunny")!
        case 11:
            weatherImage = UIImage.init(named: "cloudy")!
        case 12:
            weatherImage = UIImage.init(named: "rainy")!
        case 13:
            weatherImage = UIImage.init(named: "snowy")!
        default:
            weatherImage = nil
        }
        
        cell.weatherImage.image = weatherImage
        cell.cityNameLabel.text = self.cities[indexPath.row].cityName
        let celsius: Double = self.cities[indexPath.row].celsius
        let fahrenheit: Double = round((Double(celsius * 9 / 5) + 32) * 10) / 10
        cell.temperatureLabel.text = "섭씨 \(celsius)도 / 화씨 \(fahrenheit)도"
        cell.rainfallLabel.text = "강수확률 \(self.cities[indexPath.row].rainfallProbability)%"
        
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = self.koreanName
        
        guard let cities: NSDataAsset = NSDataAsset(name: self.assetName!) else {
            preconditionFailure("도시별 기온 데이터 가져오기 실패")
        }
        
        let jsonDecoder = JSONDecoder()
        
        do {
            try self.cities = jsonDecoder.decode([City].self, from: cities.data)
        } catch {
            print(error.localizedDescription)
        }
        
        self.tableView.reloadData()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
