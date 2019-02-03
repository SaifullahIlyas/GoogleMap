//
//  ViewController.swift
//  GoogleMap Test
//  Created by MAC on 24/12/2018.
//  Copyright © 2018 MAC. All rights reserved.
//
//

import UIKit
import GoogleMaps
import GooglePlaces


class ViewController: UIViewController,GMSMapViewDelegate {
    var mapView:GMSMapView?
    @IBOutlet weak var mapVIEW: UIView!
    
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var optionmap: UISegmentedControl!
    var locationManger=CLLocationManager()
    override func loadView() {
        // Create a GMSCameraPosition that tells the map to display the
        mapView?.delegate = self
      
      
    
        // coordinate -33.86,151.20 at zoom level 6.
        setMapType(type: GMSMapViewType.normal)
        addSegment()
        
       
}
    
   
    
    
    func setMapType(type:GMSMapViewType)
    {
        
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        mapView = GMSMapView()
        mapView!.frame = CGRect.zero
        mapView!.camera = camera
        mapView!.settings.myLocationButton = true
        mapView!.mapType=type
    
        
       view = mapView
        locationManger.delegate=self
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
        let marker1=GMSMarker()
        marker1.position=CLLocationCoordinate2D(latitude: -33.00, longitude: 151.24)
        marker1.title="marker1"
        marker1.snippet="this is my marker"
        //marker1.icon=GMSMarker.markerImage(with:.black)
        //marker1.icon=UIImage(named:"login")
        
        marker1.map=mapView;
        
    }
    func addSegment()
    {let x = UIScreen.main.bounds.size.width-50
       
        let y = self.view.bounds.minY+100
        
        let items = ["Normal","Setlite","Hybrid","Terrain"]
        let segment = UISegmentedControl(items: items)
        let frame = CGRect(x: x, y: y, width: 40, height: 200)
        segment.transform = CGAffineTransform.init(rotationAngle:CGFloat(M_PI/2.0))
        segment.frame = frame
        segment.backgroundColor = UIColor.lightGray
        segment.layer.zPosition = 1
        segment.addTarget(self,action:  #selector(segmentVal), for: .valueChanged)
        
        self.view.addSubview(segment)
        addSearchBar()
        
    }
    func addSearchBar()
    {
        let frame = CGRect(x: view.bounds.minX+20, y: self.view.bounds.minY+15, width: UIScreen.main.bounds.size.width-60, height: 50)
        
       let   searchBar = UISearchBar(frame: frame)
        searchBar.layer.zPosition = 1
        searchBar.setNeedsFocusUpdate()
    self.view.addSubview(searchBar)
    }
    @IBAction func segmentVal(sender: UISegmentedControl!)  {
  
   let index = sender.selectedSegmentIndex
    switch index {
    case 0:
    setMapType(type: GMSMapViewType.normal)
    addSegment()
    break
    case 1:
    setMapType(type: GMSMapViewType.satellite)
    addSegment()
    break
    case 2:
    setMapType(type: GMSMapViewType.hybrid)
    addSegment()
    break
    case 3:
    setMapType(type:  GMSMapViewType.terrain)
    addSegment()
    break
    default:
    break
    }
    }
    
    

}
extension ViewController:CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let  location = locations.last;
        let camera=GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)! ,zoom: 17.0)
        
    }
    func mapView(_ mapView: GMSMapView, didTap overlay: GMSOverlay) {
        print("you tapped on the  map")
    }
}
extension ViewController:UISearchBarDelegate,UISearchControllerDelegate,UISearchResultsUpdating
{
    func updateSearchResults(for searchController: UISearchController) {
        print("update")
    }
    
    
    
    
}


