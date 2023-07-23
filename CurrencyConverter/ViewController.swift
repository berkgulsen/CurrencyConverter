import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var eurLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getRatesClicked(_ sender: Any) {
        let apiUrlString = "http://api.exchangeratesapi.io/v1/latest?access_key=a1595ff90471118bbd56b351a31374ea&format=1"
        
        if let apiUrl = URL(string: apiUrlString) {
            
            let session = URLSession(configuration: .default)
            
            let dataTask = session.dataTask(with: apiUrl) { (data, response, error) in
                if error != nil {
                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                    alert.addAction(okButton)
                    self.present(alert,animated: true, completion: nil)
                }
                
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        
                        if let rates = json?["rates"] as? [String: Double] {
                            DispatchQueue.main.async {
                                self.usdLabel.text = "USD: \(rates["USD"] ?? 0.0)"
                                self.eurLabel.text = "EUR: \(rates["EUR"] ?? 0.0)"
                                self.gbpLabel.text = "GBP: \(rates["GBP"] ?? 0.0)"
                                self.cadLabel.text = "CAD: \(rates["CAD"] ?? 0.0)"
                                self.jpyLabel.text = "JPY: \(rates["JPY"] ?? 0.0)"
                            }
                        }
                    } catch {
                        print("JSON çözümleme hatası: \(error.localizedDescription)")
                    }
                }
            }
            dataTask.resume()
        }
    }
}

