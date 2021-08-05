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
}

