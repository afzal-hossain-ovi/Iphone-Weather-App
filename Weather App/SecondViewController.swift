//
//  SecondViewController.swift
//  Weather App
//
//  Created by Afzal Hossain on 12/8/16.
//  Copyright © 2016 Afzal Hossain. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet var humidityLabel: UILabel!
    @IBOutlet var pressureLabel: UILabel!
    @IBOutlet var windSpeedLabel: UILabel!
    @IBOutlet var degLabel: UILabel!
    @IBOutlet var image: UIImageView!
    @IBOutlet var descriptionLabel: UILabel!
    
    @IBOutlet var tempMinLabel: UILabel!
    @IBOutlet var tempMaxlabel: UILabel!
    @IBOutlet var latitudeLabel: UILabel!
    @IBOutlet var longitudeLabel: UILabel!
    @IBOutlet var tempType: UILabel!
    
    
    
    var name = ""
    var latitiude = 0.0
    var longitude = 0.0
    var jsonResult:AnyObject?
    
    @IBAction func doRefresh(_ sender: Any) {
    viewDidLoad()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         descriptionLabel.font = UIFont.boldSystemFont(ofSize: 22.0)
        

        if let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q="+name.replacingOccurrences(of: " ", with: "-")+",&appid=c9193dcd7b421405efd7c87c0e5ce522"){
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil{
                print("error")
            }else{
                if let urlContent = data{
                    do{
                       self.jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        
                        
                        if let description = ((self.jsonResult?["weather"] as! NSArray)[0] as! NSDictionary)["description"] as? String{
                           
                            DispatchQueue.main.sync(execute: {
                                self.descriptionLabel.text = description
                                if description == "clear sky"{
                                   self.image.image = UIImage(named: "w01d.png") 
                                }else if description == "haze"{
                                    self.image.image = UIImage(named: "w50d.png")
                                }else if description == "mist"{
                                self.image.image = UIImage(named: "w50n.png")
                                }else if description == "overcast clouds"{
                                    self.image.image = UIImage(named: "w02d.png")
                                }else if description == "light rain"{
                                    self.image.image = UIImage(named: "w09d.png")
                                }else if description == "scattered clouds"{
                                    self.image.image = UIImage(named: "w03d.png")
                                }else if description == "few clouds"{
                                    self.image.image = UIImage(named: "w02d.png")
                                }else if description == "broken clouds"{
                                    self.image.image = UIImage(named: "w04d.png")
                                }else if description == "rain"{
                                    self.image.image = UIImage(named: "w10d.png")
                                }else if description == "thunderstorm"{
                                    self.image.image = UIImage(named: "w11d.png")
                                }else if description == "snow"{
                                    self.image.image = UIImage(named: "w13d.png")
                                }
                                
                            })
                           
                        }
                        
                        if let humidity = (self.jsonResult?["main"] as AnyObject)["humidity"] as? Int{
                            DispatchQueue.main.sync(execute: {
                                self.humidityLabel.text = String(humidity)
                            })
                        }
                        
                        if let pressure = (self.jsonResult?["main"] as AnyObject)["pressure"] as? Int{
                            DispatchQueue.main.sync(execute: {
                                self.pressureLabel.text = String(pressure)
                            })
                        }
                        
                        if let windSpeed = (self.jsonResult?["wind"] as AnyObject)["speed"] as? Int{
                            DispatchQueue.main.sync(execute: {
                                self.windSpeedLabel.text = String(windSpeed)
                            })
                        }
                        
                        if let deg = (self.jsonResult?["wind"] as AnyObject)["deg"] as? Int{
                            DispatchQueue.main.sync(execute: {
                                self.degLabel.text = String(deg)
                            })
                        }
                        if let latitude = (self.jsonResult?["coord"] as AnyObject)["lat"] as? Double{
                            self.latitiude = latitude
                            DispatchQueue.main.sync(execute: {
                                self.latitudeLabel.text = String(latitude)
                            })
                        }
                        if let longitude = (self.jsonResult?["coord"] as AnyObject)["lon"] as? Double{
                            self.longitude = longitude
                            DispatchQueue.main.sync(execute: {
                                self.longitudeLabel.text = String(longitude)
                            })
                        }
                        if let tempMin = (self.jsonResult?["main"] as AnyObject)["temp_min"] as? Double{
                            DispatchQueue.main.sync(execute: {
                                let kelvinToFarenhitPreDivision = (tempMin * (9/5) - 459.67)
                                let kelvinToFarenhit = Double(round(10 * kelvinToFarenhitPreDivision/10))
                                self.tempMinLabel.text = String(Int(kelvinToFarenhit))+"°c"
                            })
                        }
                        if let tempMax = (self.jsonResult?["main"] as AnyObject)["temp_max"] as? Double{
                            DispatchQueue.main.sync(execute: {
                                let kelvinToFarenhitPreDivision = (tempMax * (9/5) - 459.67)
                                let kelvinToFarenhit = Double(round(10 * kelvinToFarenhitPreDivision/10))
                                self.tempMaxlabel.text = String(Int(kelvinToFarenhit))+"°c"
                            })
                        }
                        if let tempType = (self.jsonResult?["main"] as AnyObject)["temp"] as? Double{
                            DispatchQueue.main.sync(execute: {
                                let kelvinToFarenhitPreDivision = (tempType * (9/5) - 459.67)
                                let kelvinToFarenhit = Double(round(10 * kelvinToFarenhitPreDivision/10))
                                self.tempType.text = String(Int(kelvinToFarenhit))+"°c"
                            })
                        }
                        
             
                        
                        
                        
                    }catch{
                        print("error")
                    }
                    
                }
            }
        }
        task.resume()
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMap"{
            let mapController = segue.destination as! MapViewController
            mapController.latitude = latitiude
            mapController.longitude = longitude
            mapController.cityName = name
            
        }
        
        if segue.identifier == "toTableVC"{
            let tableController = segue.destination as! TableVC
            
            tableController.cityName = name
            
        }
        
        
    }
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

 }




