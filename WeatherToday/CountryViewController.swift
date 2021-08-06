//
//  ViewController.swift
//  WeatherToday
//
//  Created by kwon on 2021/08/04.
//

import UIKit

class CountryViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    let cellIdentifier: String = "countryCell"
    var countries: [Country] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        cell.textLabel?.text = countries[indexPath.row].koreanName
        cell.imageView?.image = UIImage.init(named: "flag_\(countries[indexPath.row].assetName)")
        cell.detailTextLabel?.text = countries[indexPath.row].assetName
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let countries: NSDataAsset = NSDataAsset(name: "countries") else {
            return
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

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let cityViewController: CityViewController = segue.destination as? CityViewController else {
            return
        }
        
        guard let cell: UITableViewCell = sender as? UITableViewCell else {
            return
        }
        
        cityViewController.koreanName = cell.textLabel?.text
        cityViewController.assetName = cell.detailTextLabel?.text
    }
}

