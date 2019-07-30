//
//  ViewController.swift
//  NearAirport
//
//  Created by Behera, Nandana (Cognizant) on 30/07/2019.
//  Copyright © 2019 Behera, Nandana (Cognizant). All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController {

    var AirportList = [AirportData]()
    private let apiFetcher = ServiceHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchResults()
        // Do any additional setup after loading the view.
    }
    
    func fetchResults() {
        
        
      
        if Reachability.isConnectedToNetwork() == true
        {
            //Fetch data from URL
            print(" Network Access is there")
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            MakeActivityIndicator.sharedInstance.showActivityIndicator(uiView:self.view)
            apiFetcher.fetchResult(completionHandler: {
                [weak self] results, error in
                if case .failure = error {
                    return
                }
                
                guard let results = results, !results.isEmpty else {
                    return
                }
                
                for status in results {
                    let paramsJSON = JSON(status)
                    let paramsString = paramsJSON.rawString(String.Encoding.utf8, options: JSONSerialization.WritingOptions.prettyPrinted)!
                    
                    let airportData = AirportData(JSONString: paramsString)
                    print("Show the country name \(String(describing: airportData?.name))")
                    self?.AirportList.append(airportData!)
                }
                
                
            })
            
            print("Show the Arrya\(AirportList)")
        }
        else
        {
            //No Netwrok , Fetch data from local DB
            print("No Network Access")
            
        }
        
    }


}

