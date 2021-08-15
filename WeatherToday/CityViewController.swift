//
//  CityViewController.swift
//  WeatherToday
//
//  Created by kwon on 2021/08/05.
//

import UIKit

// review: 더 이상 상속이 필요없는 class의 경우 final 키워드를 붙여서 최적화할 수 있습니다.
// Swift에서는 override를 위해 class function 호출 시 dynamic dispatch 테크닉을 사용합니다.
// final 키워드를 붙이면 dynamic dispatch 대신 static dispatch를 사용하므로 성능 향상에 도움이 됩니다.
// https://developer.apple.com/swift/blog/?id=27
final class CityViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var koreanName: String?
    var assetName: String?
    var cities: [City] = []
    var weathers: Dictionary<Int, UIImage> = [:]
    
//    review: iOS의 일반적인 UIKit 프로젝트에서는 기본적으로 MVC패턴을 따릅니다. MVC 패턴은 모델과 뷰, 그리고 이 둘 사이를 이어주는 컨트롤러가 존재합니다.
//    컨트롤러는 사용자로 부터 UI 이벤트를 받아 모델을 업데이트하고, 모델의 변경사항을 또 다시 뷰에 반영합니다.
//    즉, 원칙적으로 모델을 가공하는 일은 컨트롤러의 일이 아닙니다. 완전히 분리해내기는 쉽지 않습니다만,
//    가급적이면 이러한 계산은 ViewController 외부에서 처리하는 것이 바람직합니다.
//    City에서 가공해도 되고, 아래와 같이 Temperature에 대한 모델을 만드는 것도 하나의 방법이 될 것 같아요.
//    struct Temparature {
//
//        let fahrenheit: Float
//
//        init(celsius: Float) {
//            self.fahrenheit = celsius * 1.8 + 32.0
//        }
//
//        init(fahrenheit: Float) {
//            self.fahrenheit = fahrenheit
//        }
//
//        var celsius: Float {
//            fahrenheit - 32.0 / 1.8
//        }
//
//        var textColor: UIColor {
//            switch celsius {
//            case ..<10.0:
//                return .blue
//            case 25.0...:
//                return .red
//            default:
//                return .black
//            }
//        }
//    }
    
    // JSON 데이터 디코딩 및 테이블 뷰 다시 불러오기
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = self.koreanName
        
        guard let cityName = self.assetName else {
            preconditionFailure("도시를 찾을 수 없음")
        }
        
        // 강제 언래핑 대신 안전한 옵셔널 바인딩 사용하기
        guard let cities: NSDataAsset = NSDataAsset(name: cityName) else {
            preconditionFailure("도시별 기온 데이터 불러오기 실패")
        }
        
        let jsonDecoder = JSONDecoder()
        
        do {
            try self.cities = jsonDecoder.decode([City].self, from: cities.data)
        } catch {
            // 단순히 print로 콘솔 출력하는 대신 얼럿을 띄워 사용자에게 에러를 알려주는 건 어떨까요?
            let alert = UIAlertController(title: "오류", message: "데이터를 불러오는 데 오류가 발생했습니다.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: NSLocalizedString("다시 시도하기", comment: "try again"), style: .default, handler: { _ in
                self.navigationController?.popToRootViewController(animated: true)
            }))
            
            self.present(alert, animated: true, completion: nil)
            // print(error.localizedDescription)
        }
        
//        review: UIImage를 여러번 생성하는 것을 방지하기 위해 미리 Dictionary에 캐싱해주신 것 같네요~!
//        좋은 아이디어이지만 사실은 UIImage(named:)는 자동으로 캐싱이 되므로 매번 생성해도 괜찮습니다.
//
//        Use the init(named:in:compatibleWith:) method (or the init(named:) method) to create an image from an image asset or image file located in your app’s main bundle (or some other known bundle). Because these methods cache the image data automatically, they are especially recommended for images that you use frequently.
//
//        UIImage(named:)를 이용한 생성은 번들에 있는 이미지를 로딩하기 위해 권장되는 방법입니다.
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
        
        for city in self.cities {
            if cell.cityNameLabel.text == city.cityName {
                detailViewController.city = city
                break
            }
        }
        
        // 이전에 선택했던 cell이 계속 회색으로 표시되는 것 방지
        // cell.backgroundColor = UIColor.white.withAlphaComponent(0.5)
    }
}

extension CityViewController: UITableViewDataSource {
    
    // row 개수 설정
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cities.count
    }
    
    // cell 구성
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: CustomCityTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as? CustomCityTableViewCell else {
            preconditionFailure("커스텀 테이블 뷰 셀 가져오기 실패")
        }
        
        // cell에 기상정보 입력
        cell.state = self.cities[indexPath.row].state
        cell.weatherImage.image = self.weathers[self.cities[indexPath.row].state]
        cell.cityNameLabel.text = self.cities[indexPath.row].cityName
        cell.temperatureLabel.text = self.cities[indexPath.row].temperature
        cell.rainfallLabel.text = self.cities[indexPath.row].rainfall
        
        // 조건에 따른 기상정보 text색 변경
        switch self.cities[indexPath.row].celsius {
        case 25.0...:
            cell.temperatureLabel.textColor = UIColor.red
        case ..<10:
            cell.temperatureLabel.textColor = UIColor.blue
        default:
            cell.temperatureLabel.textColor = UIColor.black
        }
        
        if self.cities[indexPath.row].rainfallProbability > 50 {
            cell.rainfallLabel.textColor = UIColor.orange
        } else {
            cell.rainfallLabel.textColor = UIColor.black
        }
        
        return cell
    }
}

extension CityViewController: UITableViewDelegate {
    
    // review: 이전에 선택했던 cell이 계속 회색으로 표시되는 것 방지
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
