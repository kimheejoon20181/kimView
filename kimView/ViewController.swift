//
//  ViewController.swift
//  kimView
//
//  Created by dit08 on 2019. 12. 12..
//  Copyright © 2019년 dit. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, XMLParserDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var kimView: MKMapView!
    
    
    var annotation: data?
    var annotations: Array = [data]()
    
    var item: [String:String] = [:]
    var items: [[String:String]] = []
    var currentElement = ""
    
    var name: String?
    var lat: String?
    var lng: String?
    var dLat: Double?
    var dLng: Double?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.kimView.showsUserLocation = true
        
        // Pasing 시작
        if let path = Bundle.main.url(forResource: "data", withExtension: "xml"){
            if let myParser = XMLParser(contentsOf: path) {
                myParser.delegate = self
                
                if myParser.parse() {
                    print("Parsing succed!")
                    for item in items {
                        
                    }
                } else {
                    print("Parsing failed!")
                }
            } else {
                print("file load error")
            }
        } else {
            print("not file")
        }
        
        kimView.delegate = self
        
        //시작 지도 설정
        zoomToRegion()
        
        //xml파일에 있는 정보를 선언
        for item in items {
            
            lat = item["lat"]
            lng = item["lng"]
            name = item["title"]
            
            dLat = Double(lat!)
            dLng = Double(lng!)
            annotation = data(coordinate: CLLocationCoordinate2D(latitude: dLat!, longitude: dLng!), title: name!)
            annotations.append(annotation!)
        }
        //mapView.showAnnotations(annotations, animated: true)
        kimView.addAnnotations(annotations)
        
        
        
    }
    
    func zoomToRegion() {
        //시작할때 지도 위치와 확대 정보
        let location = CLLocationCoordinate2D(latitude: 35.164437, longitude: 129.064962)
        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        let region = MKCoordinateRegion(center: location, span: span)
        kimView.setRegion(region, animated: true)
    }
    
    // XMLParser delegate Method
    // XML 파서가 시작 태그를 만나면 호출
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
    }
    
    // XML 파서가 종료 태그를 만나면 호출
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            items.append(item)
            print(item)
        }
    }
    
    // 현재 테그에 담겨있는 문자열 전달
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        // white char 제거
        let data = string.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        //print(data)
        if !data.isEmpty {
            item[currentElement] = data
        }
        
    }
    
}

