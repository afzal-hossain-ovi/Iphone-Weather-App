//
//  ViewController.swift
//  Weather App
//
//  Created by Afzal Hossain on 12/8/16.
//  Copyright © 2016 Afzal Hossain. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    @IBOutlet var label: UILabel!
    @IBOutlet var button: UIButton!
    @IBOutlet var cityTextField: UITextField!
    
        

    @IBAction func weatherCast(_ sender: Any) {
        if cityTextField.text != ""{
            
            performSegue(withIdentifier: "toSecondController", sender: self)
 
        }else{
            label.text = "enter city name"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        label.font = UIFont.boldSystemFont(ofSize: 23.0)
        
      
        
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSecondController"{
            let secondController = segue.destination as! SecondViewController
                secondController.name = cityTextField.text!
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

