# Read Me

#### 1.区分APP的前后台运行模式

利用UIApplication.State：

```swift
let state: UIApplication.State = UIApplication.shared.applicationState
if state == .active{...}
else if state == .background{...}
```

#### 2.处理APP在前台和后台模式下对定位要求的区别

在前台模式下，设置位置精度为精确定位：

```swift
locationManager.desiredAccuracy = kCLLocationAccuracyBest
```

在后台模式下，设置位置精度为100m误差

```swift
locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
```

#### 3.处理CoreLocation返回的错误信息

利用CLLocationManager.authorizationStatus()，在权限未开启时(.denied)，提醒用户开启定位权限；在权限为仅在使用期间时(.authorizedWhenInUse)，弹出提示框，提醒用户为了更好的体验，最好将定位权限设置为"始终",当GPS不可用(.restricted)，提示用户GPS定位可能存在故障；当用户尚未设置定位权限(.notdetermined)，提醒用户设置定位权限。

```swift
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
        
```

#### 4.处理APP在前台和后台模式下，对路径渲染的区别

当APP处于前台模式，对路径进行实时渲染；当APP处于后台模式，将获取到的位置存入队列中保存，不进行渲染，当APP由后台切换到前台，根据队列中的信息对路径进行渲染。