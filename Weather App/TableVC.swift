//
//  TableVC.swift
//  Weather App
//
//  Created by Afzal Hossain on 1/13/17.
//  Copyright © 2017 Afzal Hossain. All rights reserved.
//

import UIKit

class TableVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var cityName = ""
    var image = [String]()
    var tempLow = [String]()
    var tempHigh = [String]()
    var tempType = [String]()
    var day = [String]()
    
    @IBOutlet var table: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        jsonResultDownload()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempType.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = table.dequeueReusableCell(withIdentifier: "cell") as? weatherCell{
            cell.highTempLabel.text = tempHigh[indexPath.row]
            cell.lowTempLebel.text = tempLow[indexPath.row]
            cell.tempTypeLabel.text = tempType[indexPath.row]
            cell.weatherImage.image = UIImage(named: image[indexPath.row])
            
            return cell
            
        }else{
        
        return UITableViewCell()
        }
    }
    
    func jsonResultDownload() {
        let url = URL(string: "http://api.openweathermap.org/data/2.5/forecast?q="+self.cityName.replacingOccurrences(of: " ", with: "-")+",&appid=c9193dcd7b421405efd7c87c0e5ce522")
        let dataTask = URLSession.shared.dataTask(with: url!) { (data, responce, error) in
            if error != nil {
                print("error")
            }else{
               if let jsonData = data {
                do{
                    let jsonResult = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                    
                    if let listArray = jsonResult["list"] as? NSArray {
                        for list in listArray {
                            if let listDict = list as? NSDictionary {
                                
                                if let main = listDict["main"] as? NSDictionary {
                                    if let temp_min = main["temp_min"] as? Double {
                                        let kelvinToFarenhitPreDivision = (temp_min * (9/5) - 459.67)
                                        let kelvinToFarenhit = Double(round(10 * kelvinToFarenhitPreDivision/10))
                                        self.tempLow.append(String(kelvinToFarenhit))
                                    }
                                    if let temp_max = main["temp_max"] as? Double {
                                        let kelvinToFarenhitPreDivision = (temp_max * (9/5) - 459.67)
                                        let kelvinToFarenhit = Double(round(10 * kelvinToFarenhitPreDivision/10))
                                        self.tempHigh.append(String(kelvinToFarenhit))
                                    }
                                    OperationQueue.main.addOperation({ 
                                        self.table.reloadData()
                                    })
                                }
                                if let tempType = ((listDict["weather"] as! NSArray) [0] as! NSDictionary)["description"] as? String {
                                    self.tempType.append(tempType)
                                }
                                if let imageType = ((listDict["weather"] as! NSArray) [0] as! NSDictionary)["icon"] as? String {
                                   
                                    self.image.append(imageType)
                                }
                                
                                DispatchQueue.main.sync(execute: {
                                    self.table.reloadData()
                                })
                            }
                        }
                    }

                }catch{
                    print(error.localizedDescription)
                }
                }
            }
        }
        dataTask.resume()
    }

  

}
