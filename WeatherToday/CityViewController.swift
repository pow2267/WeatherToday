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
    var cities: [City] = []
    var weathers: Dictionary<Int, UIImage> = [:]
    
    // row 개수 설정
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cities.count
    }
    
    // cell 구성
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: CustomCityTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as? CustomCityTableViewCell else {
            preconditionFailure("커스텀 테이블 뷰 셀 가져오기 실패")
        }
        
        let celsius: Double = self.cities[indexPath.row].celsius // 섭씨
        let fahrenheit: Double = round((Double(celsius * 9 / 5) + 32) * 10) / 10 // 화씨
        
        // cell에 기상정보 입력
        cell.state = self.cities[indexPath.row].state
        cell.weatherImage.image = self.weathers[self.cities[indexPath.row].state]
        cell.cityNameLabel.text = self.cities[indexPath.row].cityName
        cell.temperatureLabel.text = "섭씨 \(celsius)도 / 화씨 \(fahrenheit)도"
        cell.rainfallLabel.text = "강수확률 \(self.cities[indexPath.row].rainfallProbability)%"
        
        // 조건에 따른 기상정보 text색 변경
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
    
    // JSON 데이터 디코딩 및 테이블 뷰 다시 불러오기
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = self.koreanName
        
        guard let cities: NSDataAsset = NSDataAsset(name: self.assetName!) else {
            preconditionFailure("도시별 기온 데이터 불러오기 실패")
        }
        
        let jsonDecoder = JSONDecoder()
        
        do {
            try self.cities = jsonDecoder.decode([City].self, from: cities.data)
        } catch {
            print(error.localizedDescription)
        }
        
        // state 값에 해당하는 날씨 이미지 불러오기
        self.weathers[10] = UIImage.init(named: "sunny")
        self.weathers[11] = UIImage.init(named: "cloudy")
        self.weathers[12] = UIImage.init(named: "rainy")
        self.weathers[13] = UIImage.init(named: "snowy")
        
        self.tableView.reloadData()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailViewController: DetailViewController = segue.destination as? DetailViewController else {
            return
        }
        
        guard let cell: CustomCityTableViewCell = sender as? CustomCityTableViewCell else {
            return
        }
        
        detailViewController.selectedCell = cell
        
        // 이전에 선택했던 cell이 계속 회색으로 표시되는 것 방지
        cell.backgroundColor = UIColor.white.withAlphaComponent(0.5)
    }
}
