//
//  NearestAirportListViewController.swift
//  NearAirport
//
//  Created by Behera, Nandana (Cognizant) on 30/07/2019.
//  Copyright © 2019 Behera, Nandana (Cognizant). All rights reserved.
//

import UIKit
import CoreLocation


struct distanceArray {
    var airportName : String
    var runwayLength : String
    var country : String
    var distance : CLLocationDistance
}

class NearestAirportListViewController: UIViewController {

    var SelectedAirportList = [AirportData]()
    var selectedCity : String!
    var detailArray = [distanceArray]()
    var currentLocation:CLLocation!
    @IBOutlet weak var detailtableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
            if let index = SelectedAirportList.firstIndex(where: {$0.city == selectedCity})
            {
                print("print the index...\(index)")
                 //location object
                
                let lat = SelectedAirportList[index].latitude?.toDouble()
                let log = SelectedAirportList[index].longitude?.toDouble()

                currentLocation = CLLocation(latitude:lat ?? 0.0, longitude: log ?? 0.0)


            }
   
          closestLoc(userLocation: currentLocation)
        
    }
    
    
    func closestLoc(userLocation:CLLocation){
        var dis = [distanceArray]()
        var distances = [CLLocationDistance]()
        for location in SelectedAirportList{
            let lat1 = location.latitude?.toDouble()
            let log1 = location.longitude?.toDouble()
            let coord = CLLocation(latitude: lat1 ?? 0.0, longitude: log1 ?? 0.0)
            distances.append(coord.distance(from: userLocation))
            dis.append(distanceArray(airportName: location.name!, runwayLength: location.runwayLength ?? "0.0", country: location.country!, distance: coord.distance(from: userLocation)))
           
            
            print("distance = \(coord.distance(from: userLocation))")
        }
        dis = dis.sorted(by: { $0.distance < $1.distance })
        detailArray = Array(dis.prefix(6))
        
        print("newArray.... \(detailArray)")

    }

    
}
extension NearestAirportListViewController: UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
       
            return detailArray.count
       
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell",for: indexPath) as! DetailTableViewCell
        
        cell.airportName.text = detailArray[indexPath.row].airportName
        cell.runwayLength.text = detailArray[indexPath.row].runwayLength
        cell.city.text = detailArray[indexPath.row].country
        
        DispatchQueue.main.async {
            MakeActivityIndicator.sharedInstance.hideActivityIndicator(uiView: self.view)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
      
    }
}
extension String
{
    /// EZSE: Converts String to Double
    public func toDouble() -> Double?
    {
        if let num = NumberFormatter().number(from: self) {
            return num.doubleValue
        } else {
            return nil
        }
    }
}
