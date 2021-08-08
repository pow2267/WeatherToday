//
//  CountryViewController.swift
//  WeatherToday
//
//  Created by kwon on 2021/08/04.
//

import UIKit

class CountryViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var countries: [Country] = []
    
    // row 개수 설정
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countries.count
    }
    
    // cell 구성
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath)
        
        cell.imageView?.image = UIImage.init(named: "flag_\(countries[indexPath.row].assetName)")
        cell.textLabel?.text = countries[indexPath.row].koreanName
        cell.detailTextLabel?.text = countries[indexPath.row].assetName
        
        return cell
    }
    
    // JSON 데이터 디코딩 및 테이블 뷰 다시 불러오기
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let countries: NSDataAsset = NSDataAsset(name: "countries") else {
            preconditionFailure("국가 정보 불러오기 실패")
        }
        
        let jsonDecoder = JSONDecoder()
        
        do {
            try self.countries = jsonDecoder.decode([Country].self, from: countries.data)
        } catch {
            print(error.localizedDescription)
        }
        
        self.tableView.reloadData()
    }
    
    // MARK: - Navigation
    
    // 선택한 국가의 한글 이름과 영문 이니셜 다음 뷰 컨트롤러에 전달
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let cityViewController: CityViewController = segue.destination as? CityViewController else {
            return
        }
        
        guard let cell: UITableViewCell = sender as? UITableViewCell else {
            return
        }
        
        cityViewController.koreanName = cell.textLabel?.text
        cityViewController.assetName = cell.detailTextLabel?.text
        
        // 이전에 선택했던 cell이 계속 회색으로 표시되는 것 방지
        cell.backgroundColor = UIColor.white.withAlphaComponent(0.5)
    }
}

