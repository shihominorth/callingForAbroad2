//
//  MapViewController.swift
//  checklist
//
//  Created by 北島　志帆美 on 2020-01-30.
//  Copyright © 2020 北島　志帆美. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps
import GooglePlaces
//import Alamofire

class MapViewController: UIViewController {
    var mapView: GMSMapView!
    
    let apiKey = KeyManager().getValue(key:"apiKey") as? String

   
    
    
    private let locationManager = CLLocationManager()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self as! CLLocationManagerDelegate
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
        let camera = GMSCameraPosition.camera(withLatitude: locationManager.location!.coordinate.latitude, longitude: locationManager.location!.coordinate.longitude, zoom: 15);
        mapView = GMSMapView.map(withFrame: self.view.bounds, camera: camera)
        mapView.delegate = self as! GMSMapViewDelegate
        self.view.addSubview(mapView)
        mapView.settings.myLocationButton = true
        mapView.isMyLocationEnabled = true
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        
        if CLLocationManager.locationServicesEnabled() {
            switch (CLLocationManager.authorizationStatus()) {
            case .notDetermined, .restricted, .denied:
                print("No access")
            case .authorizedAlways, .authorizedWhenInUse:
                print("Access")
            }
        } else {
            print("Location services are not enabled")
        }
        
        getSupermarketImformation()
    }
    
    func getSupermarketImformation()  {
           let session = URLSession.shared
           
           let url = URL(string: "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(locationManager.location!.coordinate.latitude),\(locationManager.location!.coordinate.longitude)&radius=1500&type=supermarket&key=\(apiKey!)")!
           
           let task = session.dataTask(with: url) { data, response, error in

               if error != nil || data == nil {
                   print("Client error!")
                   return
               }

               guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                   print("Server error!")
                   return
               }

               guard let mime = response.mimeType, mime == "application/json" else {
                   print("Wrong MIME type!")
                   return
               }

               do {
                   let json = try JSONSerialization.jsonObject(with: data!, options: [])
                   print(json)
               } catch {
                   print("JSON error: \(error.localizedDescription)")
               }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let root = try decoder.decode(Root.self, from: data!)
                print(root)
                self.createMarkers(root: root)
            } catch {
                print(error)
            }
           }
        
        

           task.resume()
        
        
       }

    
    
    func showCurrentLocation() {
        mapView.settings.myLocationButton = true
        let locationObj = locationManager.location as! CLLocation
        let coord = locationObj.coordinate
        let lattitude = coord.latitude
        let longitude = coord.longitude
        
        let center = CLLocationCoordinate2D(latitude: locationObj.coordinate.latitude, longitude: locationObj.coordinate.longitude)
        let marker = GMSMarker()
        marker.position = center
        marker.title = "current location"
        marker.map = mapView
        //let camera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: lattitude, longitude: longitude, zoom: Float(5))
        //self.mapView.animate(to: camera)
        //        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
    }
//
//    private func fetchNearbyPlaces(coordinate: CLLocationCoordinate2D) {
//      // 1
//      mapView.clear()
//
//
//    }

    
    private func createMarkers(root: Root) {
        
        mapView.clear()
        
        
        var markers: [GMSMarker] = []
        let places:[SearchResult] = root.results
        let marker:GMSMarker = GMSMarker()
        
        for place in places {
            
            let marker1 = GMSMarker()
            marker1.position = CLLocationCoordinate2D(latitude: place.geometry.location.lat , longitude: place.geometry.location.lng)
            marker.title = "\(place.name)"
            marker1.snippet = "\(place.name)"
            markers.append(marker1)
            marker1.map = mapView
        }
    }

    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}


extension MapViewController: GMSMapViewDelegate {
    
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else {
            return
        }
        
        locationManager.startUpdatingLocation()
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        self.showCurrentLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        locationManager.stopUpdatingLocation()
        self.showCurrentLocation()
    }
}
