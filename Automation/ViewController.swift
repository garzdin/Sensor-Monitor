//
//  ViewController.swift
//  Automation
//
//  Created by Teodor on 04/11/2016.
//  Copyright © 2016 TeodorGarzdin. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var humidityLabel: UILabel!
    @IBOutlet var lightLabel: UILabel!
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.hidesWhenStopped = true
        getData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func updateAction(_ sender: Any) {
        getData()
    }
    
    func getData() {
        spinner.startAnimating()
        Alamofire.request("https://automationapi.herokuapp.com/api/retrieve").responseJSON { response in
            if let data = response.result.value as? [Any] {
                if let lastEntry = data.last as? [String:Any] {
                    if let temperature = lastEntry["temperature"] as? Int,
                        let humidity = lastEntry["humidity"] as? Int,
                        let light = lastEntry["light"] as? Int {
                        DispatchQueue.main.async {
                            self.temperatureLabel.text = "Temperature: \(temperature) C"
                            self.humidityLabel.text = "Humidity: \(humidity) %"
                            self.lightLabel.text = "Light: \(light) lm"
                        }
                    }
                }
            }
        }
        spinner.stopAnimating()
    }
}

