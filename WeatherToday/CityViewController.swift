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
    var weathers: [UIImage] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: CustomCityTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CustomCityTableViewCell else {
            preconditionFailure("테이블 뷰 셀 가져오기 실패")
        }
        
        cell.state = self.cities[indexPath.row].state
        cell.weatherImage.image = self.weathers[self.cities[indexPath.row].state - 10]
        cell.cityNameLabel.text = self.cities[indexPath.row].cityName
        let celsius: Double = self.cities[indexPath.row].celsius
        let fahrenheit: Double = round((Double(celsius * 9 / 5) + 32) * 10) / 10
        cell.temperatureLabel.text = "섭씨 \(celsius)도 / 화씨 \(fahrenheit)도"
        cell.rainfallLabel.text = "강수확률 \(self.cities[indexPath.row].rainfallProbability)%"
        
        if celsius > 25 {
            cell.temperatureLabel.textColor = UIColor.red
        } else if celsius < 10 {
            cell.temperatureLabel.textColor = UIColor.blue
        } else {
            cell.temperatureLabel.textColor = UIColor.black
        }
        
        if self.cities[indexPath.row].rainfallProbability > 50 {
            cell.rainfallLabel.textColor = UIColor.orange
        } else {
            cell.rainfallLabel.textColor = UIColor.black
        }
        
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
        
        self.weathers = [
            UIImage.init(named: "sunny")!,
            UIImage.init(named: "cloudy")!,
            UIImage.init(named: "rainy")!,
            UIImage.init(named: "snowy")!
        ]
        
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailViewController: DetailViewController = segue.destination as? DetailViewController else {
            return
        }
        
        guard let cell: CustomCityTableViewCell = sender as? CustomCityTableViewCell else {
            return
        }
        
        detailViewController.selectedCellData = cell.self
    }
}
