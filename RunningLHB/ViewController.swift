//
//  ViewController.swift
//  RunningLHB
//
//  Created by 刘洪博 on 2021/11/16.
//

import UIKit
import CoreLocation
import MapKit
struct lhb{
    var m :String
    var n:Int
}

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    @IBOutlet var start_button: UIButton!
    
    @IBOutlet var pause_stop_button: UIButton!
    @IBAction func press_start(_ sender: UIButton) {
        switch CLLocationManager.authorizationStatus(){
        case.denied:
            let alert = UIAlertController(title: "定位失败", message: "请打开定位权限", preferredStyle: .alert)
                let confirm = UIAlertAction(title: "确认", style: .default) { (UIAlertAction) in
                    //
                    print("Click Confirm")
                }
                alert.addAction(confirm);
                self.present(alert, animated: true) {
                    print("Show Alert!")
                }
            break
        case .restricted:
            let alert = UIAlertController(title: "定位失败", message: "GPS系统故障", preferredStyle: .alert)
                let confirm = UIAlertAction(title: "确认", style: .default) { (UIAlertAction) in
                    //
                    print("Click Confirm")
                }
                alert.addAction(confirm);
                self.present(alert, animated: true) {
                    print("Show Alert!")
                }
            break
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            let notreminder = UserDefaults.standard.bool(forKey: "reminder")
            if ifhint && !notreminder{
            let alert = UIAlertController(title: "提示", message: "为了更好的体验，请在“设置“中将定位权限改为始终", preferredStyle: .alert)
                let confirm = UIAlertAction(title: "确认", style: .default) { (UIAlertAction) in
                    //
                    print("Click Confirm")
                }
                let notagain = UIAlertAction(title: "不再提醒", style: .default) { (UIAlertAction) in
                    UserDefaults.standard.set(true, forKey: "reminder")
                }
                alert.addAction(confirm);
                alert.addAction(notagain)
                self.present(alert, animated: true) {
                    print("Show Alert!")
                }
                ifhint = false
            }
            break
        case .notDetermined:
            let alert = UIAlertController(title: "定位失败", message: "请设置定位权限", preferredStyle: .alert)
                let confirm = UIAlertAction(title: "确认", style: .default) { (UIAlertAction) in
                    //
                    print("Click Confirm")
                }
                alert.addAction(confirm);
                self.present(alert, animated: true) {
                    print("Show Alert!")
                }
            break
        @unknown default:
            let alert = UIAlertController(title: "定位失败", message: "未知错误", preferredStyle: .alert)
                let confirm = UIAlertAction(title: "确认", style: .default) { (UIAlertAction) in
                    //
                    print("Click Confirm")
                }
                alert.addAction(confirm);
                self.present(alert, animated: true) {
                    print("Show Alert!")
                }
            break
        }
        if CLLocationManager.authorizationStatus() == .authorizedAlways || CLLocationManager.authorizationStatus()  == .authorizedWhenInUse{
            sender.isEnabled = false
            self.pause_stop_button.isEnabled = true
            self.pause_stop_button.setTitle(" Pause", for: .normal)
            self.pause_stop_button.backgroundColor = .systemTeal
            ifstart = true
            self.pause_stop_button.backgroundColor = .systemTeal
        }
    }
    @IBAction func press_pause(_ sender: UIButton) {
        switch CLLocationManager.authorizationStatus(){
        case.denied://用户拒绝了定位请求
            let alert = UIAlertController(title: "定位失败", message: "请打开定位权限", preferredStyle: .alert)
                let confirm = UIAlertAction(title: "确认", style: .default) { (UIAlertAction) in
                    //
                    print("Click Confirm")
                }
                alert.addAction(confirm);
                self.present(alert, animated: true) {
                    print("Show Alert!")
                }
            break
        case .restricted:
            let alert = UIAlertController(title: "定位失败", message: "GPS系统故障", preferredStyle: .alert)
                let confirm = UIAlertAction(title: "确认", style: .default) { (UIAlertAction) in
                    //
                    print("Click Confirm")
                }
                alert.addAction(confirm);
                self.present(alert, animated: true) {
                    print("Show Alert!")
                }
            break
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            let notreminder = UserDefaults.standard.bool(forKey: "reminder")
           
           
            if ifhint && !notreminder{
            let alert = UIAlertController(title: "提示", message: "为了更好的体验，请在“设置“中将定位权限改为始终", preferredStyle: .alert)
                let confirm = UIAlertAction(title: "确认", style: .default) { (UIAlertAction) in
                    //
                    print("Click Confirm")
                }
                let notagain = UIAlertAction(title: "不再提醒", style: .default) { (UIAlertAction) in
                    UserDefaults.standard.set(true, forKey: "reminder")
                }
                alert.addAction(notagain)
                alert.addAction(confirm);
                self.present(alert, animated: true) {
                    print("Show Alert!")
                }
                ifhint = false
            }
            break
        case .notDetermined:
            let alert = UIAlertController(title: "定位失败", message: "请设置定位权限", preferredStyle: .alert)
                let confirm = UIAlertAction(title: "确认", style: .default) { (UIAlertAction) in
                    //
                    print("Click Confirm")
                }
                alert.addAction(confirm);
                self.present(alert, animated: true) {
                    print("Show Alert!")
                }
            break
        @unknown default:
            let alert = UIAlertController(title: "定位失败", message: "未知错误", preferredStyle: .alert)
                let confirm = UIAlertAction(title: "确认", style: .default) { (UIAlertAction) in
                    //
                    print("Click Confirm")
                }
                alert.addAction(confirm);
                self.present(alert, animated: true) {
                    print("Show Alert!")
                }
            break
        }
        if CLLocationManager.authorizationStatus() == .authorizedAlways || CLLocationManager.authorizationStatus()  == .authorizedWhenInUse{
            
            if sender.currentTitle! == " Pause"{
                ifstart = false
                sender.setTitle(" Stop",for: UIControl.State.normal)
                sender.backgroundColor = .red
                self.start_button.backgroundColor = .systemTeal
                self.start_button.isEnabled = true
                
            }
            else if sender.currentTitle! == " Stop"{
                ifstart = false
                self.start_button.backgroundColor = .systemTeal
                self.start_button.isEnabled = true
                sender.setTitle(" Pause", for: UIControl.State.normal)
                sender.isEnabled = false
                sender.backgroundColor = .systemTeal
                map.removeOverlays(map.overlays)
                self.distance = 0
                self.distance_label.text! = "\(Int(self.distance)) m"
                self.speed = 0
                self.speed_label.text! = "\(Int(self.speed)) m/s"
            }
        }
        
    }
    
    @IBOutlet var distance_label: UILabel!
    @IBOutlet var map: MKMapView!
    @IBOutlet var speed_label: UILabel!
    var locations = LocationQueue()
    var last_location_latitude : Double = 0.0
    var last_location_longitude : Double = 0.0
    var current_location_latitude : Double = 0.0
    var current_location_longitude : Double = 0.0
    var start_at_first_time = true
    var origin_location_latitude = 0.0
    var origin_location_longitude = 0.0
    var locationManager = CLLocationManager()
    var ifstart = false
    var ifhint = true
    var speed :Double = 0.0
    var distance : Double = 0.0
    var thread = Thread()
    var start_time = CFAbsoluteTimeGetCurrent()
    var end_time = CFAbsoluteTimeGetCurrent()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.delegate = self  //委派給ViewController
        locationManager.desiredAccuracy = kCLLocationAccuracyBest  //設定為最佳精度
        locationManager.requestWhenInUseAuthorization()  //user授權
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()  //開始update位置
        map.delegate = self
        map.showsUserLocation = true   //顯示user位置
        map.userTrackingMode = .follow  //隨著user移動
        self.last_location_latitude = map.userLocation.coordinate.latitude
        self.last_location_longitude = map.userLocation.coordinate.longitude
        self.current_location_latitude = map.userLocation.coordinate.latitude
        self.current_location_longitude = map.userLocation.coordinate.longitude
        self.origin_location_latitude = map.userLocation.coordinate.latitude
        self.origin_location_longitude = map.userLocation.coordinate.longitude
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let state: UIApplication.State = UIApplication.shared.applicationState
        if self.origin_location_longitude == 0.0 && self.origin_location_latitude == 0.0{
            self.origin_location_latitude = map.userLocation.coordinate.latitude
            self.origin_location_longitude = map.userLocation.coordinate.longitude
        }
        if ifstart{
            //前台模式，对路径渲染
            if state == .active{
                locationManager.desiredAccuracy = kCLLocationAccuracyBest//设为最佳精度
                //将栈中存储的后台运行数据提取出来并绘图
            while(!self.locations.location_stack.isEmpty){
                let last = self.locations.pop()
                if !self.locations.location_stack.isEmpty{
                    let cur = self.locations.pop()
                    if cur.longitude != 0.0 && cur.latitude != 0.0 && last.latitude != 0.0 && last.longitude != 0.0{
                                      let source_location = CLLocationCoordinate2D(latitude: last.latitude, longitude: last.longitude)
                    let destination_location = CLLocationCoordinate2D(latitude: cur.latitude, longitude: cur.longitude)
                let routeLine = MKPolyline(coordinates: [source_location,destination_location], count: 2)
                self.map.addOverlay(routeLine)
                        let curlocation = CLLocation(latitude:cur.latitude, longitude: cur.longitude)
                        let lastlocation = CLLocation(latitude: self.origin_location_latitude, longitude: self.origin_location_longitude)
                        if curlocation.distance(from: lastlocation) > 0.5{
                            self.distance = self.distance + curlocation.distance(from: lastlocation)
                            self.origin_location_latitude = cur.latitude
                            self.origin_location_longitude = cur.longitude
                        }
                        
                }
                }
            }
             //绘制当前运动轨迹
                self.end_time = CFAbsoluteTimeGetCurrent()
                self.current_location_latitude = map.userLocation.coordinate.latitude
                self.current_location_longitude = map.userLocation.coordinate.longitude
                

                if self.current_location_longitude != 0.0 && self.current_location_latitude != 0.0 && self.last_location_longitude != 0.0 && self.last_location_latitude != 0.0{
                    let curlocation = CLLocation(latitude: self.current_location_latitude, longitude: self.current_location_longitude)
                    //self.speed = curlocation.speed > 0 ? curlocation.speed : 0
                    
                    
                    
                    let lastlocation = CLLocation(latitude: self.origin_location_latitude, longitude: self.origin_location_longitude)
                    print(curlocation.distance(from: lastlocation))
                    
                    if curlocation.distance(from: lastlocation) > 0.5{
                        self.distance = self.distance + curlocation.distance(from: lastlocation)
                        self.origin_location_latitude = current_location_latitude
                        self.origin_location_longitude = current_location_longitude
                        self.speed = curlocation.distance(from: lastlocation)/(end_time-start_time)
                        print(self.speed)
                        self.start_time = CFAbsoluteTimeGetCurrent()
                    }
                    distance_label.text = "\(Int(self.distance)) m"
                    speed_label.text = "\(Int(self.speed)) m/s"
                let source_location = CLLocationCoordinate2D(latitude: self.last_location_latitude, longitude: self.last_location_longitude)
                let destination_location = CLLocationCoordinate2D(latitude: self.current_location_latitude, longitude: self.current_location_longitude)
        let routeLine = MKPolyline(coordinates: [source_location,destination_location], count: 2)
        print("drawroute")
        self.map.addOverlay(routeLine)
                }

                self.last_location_latitude = self.current_location_latitude
                self.last_location_longitude = self.current_location_longitude

        }
            else if state == .background{//在后台运行的处理：将位置精度降低，然后将读取到的位置信息存入栈中，等到进入前台再从栈中提取并进行绘图
                print("background")
                locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
                let cur = coordi(latitude: map.userLocation.coordinate.latitude, longitude: map.userLocation.coordinate.longitude)
            self.locations.push(current_location: cur)
            }
        }
    }
    // 渲染overlay的函数
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        //画出两条线：
        let routeLineView = MKPolylineRenderer(overlay: overlay)
          routeLineView.lineWidth = 2.0
        routeLineView.strokeColor = UIColor.red
        
            return routeLineView
    }
}

