//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Tayfur Salih Şen on 26.07.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var chfLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func GetRates(_ sender: Any) {
        
        // 1-) Request and session // Bir web adresi varya oraya gitmek -- İstek yollamak
        // 2-) Response and Data // Bu isteği almak
        // 3-) Bu datayı işlemek ( parsing )
        
        let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/CurrencyData/main/currency.json")
    
        // Veri alışverişi yapmak için kullanıcaz
        let session = URLSession.shared
        
        // Verilen input(url) a göre bir cevap oluşturuyor -- closure
        let task = session.dataTask(with: url!) { data, response, error in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            } else{
                // 2. adım başlıyor datayı işliycez
                if data != nil {
                    do{
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options:
                        JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                    
                    DispatchQueue.main.sync {
                        if let rates = jsonResponse["rates"] as? [String:Any]{
                            
                            if let cad = rates["CAD"] as? Double {
                                self.cadLabel.text = "CAD : \(cad)"
                            }
                            
                            if let chf = rates["CHF"] as? Double {
                                self.chfLabel.text = "CHF : \(chf)"
                            }
                            
                            if let gbp = rates["GBP"] as? Double {
                                self.gbpLabel.text = "GBP : \(gbp)"
                            }
                            
                            
                            if let jpy = rates["JPY"] as? Double {
                                self.jpyLabel.text = "JPY : \(jpy)"
                            }
                            
                            if let usd = rates["USD"] as? Double {
                                self.usdLabel.text = "USD : \(usd)"
                            }
                            
                            if let turkish = rates["TRY"] as? Double {
                                self.tryLabel.text = "TRY : \(turkish)"
                            }
                        }


                    }
                        
                    } catch{
                        print("error")
                    }
                }
            }
        }
        task.resume()
    }
    
}

