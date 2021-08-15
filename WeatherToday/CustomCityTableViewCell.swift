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

//    review: UITableViewCell을 상속받은 클래스에서 awakeFromNib을 override하고 있습니다.
//    그런데 이 메서드안에서 하고 있는 일은 super의 awakeFromNib을 호출하는 것 뿐이에요.
//    이 경우 이 메서드를 통째로 제거해도 똑같이 동작합니다.
//    제거해도 무방한 코드는 가독성을 위해 제거하는 것이 좋습니다.
//    override func awakeFromNib() {
//        super.awakeFromNib()
//    }
//    (마찬가지로 setSelected도 제거해도 똑같이 동작한다.)
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//    }

}
