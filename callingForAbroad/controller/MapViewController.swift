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


class MapViewController: UIViewController {
    var mapView: GMSMapView!
    
    let apiKey = KeyManager().getValue(key:"apiKey") as? String
    let viewDetail = UIView() as? SeeDetailView
   
    
    
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
        
        let url = URL(string: "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(locationManager.location!.coordinate.latitude),\(locationManager.location!.coordinate.longitude)&radius=4500&type=cafe&key=\(apiKey!)")!
        
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

 
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        print("\(marker.position.latitude)")
        
        let count = marker.snippet!.split(separator: ",").count
        var word = marker.snippet!.split(separator: ",")
        var words:[String] = []
        var result = ""
        var searchWords = ""
        
        for value in word {
            for char in value {
                var temp = String(char)
                if char == " " {
                    temp = ",+"
                }
                result += temp
            }
        }
         
        
        print(result)
        
         if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
            UIApplication.shared.openURL(URL(string:           "comgooglemaps://?q=\(result)&center=\(marker.position.latitude),\(marker.position.longitude)&zoom=14&views=traffic")!)
         } else {
           print("Can't use comgooglemaps://");
         }
    }

//    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView?
//        let v = (UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 150)) as? SeeDetailView)
//
//        v.backgroundColor = .white
//        let nameLabel = UILabel(frame: CGRect(x: 0, y: 5, width: 150, height: 50))
//        nameLabel.text = "\(marker.title ?? "Can't load")"
//        nameLabel.textAlignment = .center
//        nameLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//        nameLabel.numberOfLines = 0
//        v.addSubview(nameLabel)
//
//        let addressLabel = UILabel(frame: CGRect(x: 10, y: 40, width: 150, height: 50))
//        addressLabel.text = "\(marker.snippet ?? "Can't load")"
//        addressLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//        addressLabel.numberOfLines = 0
//        addressLabel.font = UIFont.systemFont(ofSize: 10.0)
//
//        v.addSubview(addressLabel)
//
//        let seeDetailButton = UIButton(frame: CGRect(x: 5, y: 100, width: 140, height: 50))
//        seeDetailButton.setTitle("See Detail", for: .normal)
//        seeDetailButton.setTitleColor(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1), for: .normal)
//        seeDetailButton.addTarget(self, action: #selector(self.lanuchGoogleMapApp(_ :)), for: .touchUpInside)
//        seeDetailButton.isUserInteractionEnabled = true
//
//        v.addSubview(seeDetailButton)
        
   //     return v
//}
    
//    func showCurrentLocation() {
//        mapView.settings.myLocationButton = true
//        let locationObj = locationManager.location!
//        let coord = locationObj.coordinate
//
//        let center = CLLocationCoordinate2D(latitude: locationObj.coordinate.latitude, longitude: locationObj.coordinate.longitude)
//        let marker = GMSMarker()
//        marker.position = center
//        marker.title = "current location"
//        marker.map = mapView
//    }


    
    private func createMarkers(root: Root) {
        
//        mapView.clear()
        
        
        var markers: [GMSMarker] = []
        let places:[SearchResult] = root.results
        
        for place in places {
            
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: place.geometry.location.lat , longitude: place.geometry.location.lng)
            marker.title = "\(place.name)"
            marker.snippet = "\(place.vicinity)"
            markers.append(marker)
            marker.map = mapView
        }
    }
    
    @objc func lanuchGoogleMapApp(_ sender: UIButton){
        
        print("\(sender.isSelected)")
        

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
//        self.showCurrentLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        locationManager.stopUpdatingLocation()
//        self.showCurrentLocation()
    }
}
