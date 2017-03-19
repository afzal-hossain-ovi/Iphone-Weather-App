//
//  MapViewController.swift
//  Weather App
//
//  Created by Afzal Hossain on 12/9/16.
//  Copyright © 2016 Afzal Hossain. All rights reserved.
//

import UIKit
import MapKit


class MapViewController: UIViewController,MKMapViewDelegate {
    
    var latitude = 0.0
    var longitude = 0.0
    var cityName = ""
    
    @IBOutlet var map: MKMapView!
    
    @IBAction func backButton(_ sender: Any) {
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let coordinateLocation = CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude))
        let region = MKCoordinateRegion(center: coordinateLocation, span: span)
        map.setRegion(region, animated: true)
        let annonation = MKPointAnnotation()
        annonation.title = cityName
        annonation.coordinate = coordinateLocation
        map.addAnnotation(annonation)
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSecondController"{
            let secondController = segue.destination as! SecondViewController
            secondController.name = cityName
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    


}
