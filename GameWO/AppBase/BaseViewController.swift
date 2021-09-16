//
//  BaseViewcontroller.swift
//  GameWO
//
//  Created by Belal medhat on 6/7/20.
//  Copyright © 2020 Belal medhat. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import Network
import SDWebImage
class BaseViewController: UIViewController,BaseViewProtocol {

    

     let refreshControlView = UIRefreshControl() // object of refresh control
     var NextPage:Bool? // detect if there is next page in API
     var PreviousPage:Bool? // detect if there is previous page in API
     var StartPage:Int = 1 // first page of pagination
     var PaginationButton = UIButton()

     let radarAnimation = "radarAnimation"
     var animationLayer: CALayer?
     var animationGroup: CAAnimationGroup?
    let ViewCenter = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    let Indicator = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), type: .circleStrokeSpin, color: #colorLiteral(red: 0.5401973128, green: 0.9296894073, blue: 0.6209766269, alpha: 1), padding: .some(100))
    var NetworkView = UIView()
    private let monitor = NWPathMonitor()

  private let queue = DispatchQueue.global(qos: .background)
   
    override func viewDidLoad() {
        super.viewDidLoad()

        NetworkView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        // Do any additional setup after loading the view.
        SystemModeCheck()
        NetworkAvailability()
        // to get notifcation when user foreground to the app
        NotificationCenter.default.addObserver(self, selector: #selector(checknetwork), name: Notification.Name("userReturnBack"), object: nil)
        addRefreshControl()

    }
  
    func AnimateLogo(LogoView:UIView){
        DispatchQueue.main.async {
            UIView.transition(with: self.view, duration: 1, options: [.transitionCrossDissolve], animations: {
             LogoView.alpha = 1
         }, completion: nil)
        }
     }
    @objc func checknetwork(){
        NetworkAvailability()

    }

    
    func IndicatorColor() -> SDWebImageActivityIndicator{ // Activity indicator check if dark mode or not and change color
          switch traitCollection.userInterfaceStyle {
                      case .dark:
                      return SDWebImageActivityIndicator.whiteLarge
                      case .light:
                      return SDWebImageActivityIndicator.grayLarge
                      default:
                      return SDWebImageActivityIndicator.grayLarge
          }
      }
    func SystemModeCheck(){
        switch traitCollection.userInterfaceStyle {
        case .dark:
            self.view?.backgroundColor = UIColor.init(named: "BackGroundApp")
        case .light:
             self.view?.backgroundColor = UIColor.init(named: "BackGroundApp")
        default:
            print("")
        }
    }
    
    // @@@@@ define the custom refresh indicator @@@@@ //

    func addRefreshControl() {
     
        guard let customView = Bundle.main.loadNibNamed("CustomRefreshControl", owner: self, options: nil) else {
            return
        }
        guard let refreshView = customView[0] as? UIView else {
            return
        }
         refreshView.tag = 12052018
         refreshView.frame = refreshControlView.bounds
        refreshControlView.addSubview(refreshView)
        refreshControlView.tintColor = UIColor.clear
        refreshControlView.backgroundColor = UIColor.clear
      
    }
//    @objc func refreshContents() {
//
//            if NextPage == false {
//            self.showAlert(title: "", message: "There is no other pages")
//        }else{
//            let refreshView = refreshControlView.viewWithTag(12052018)
//                   for vw in (refreshView?.subviews)! {
//                           if let indicator = vw as? NVActivityIndicatorView {
//                             indicator.startAnimating()
//                           }
//                   }
////            self.perform(#selector(self.ForwardPagination), with: nil, afterDelay: 1.5)
//        }
//        }
    
    

    func showLoading() {
        DispatchQueue.main.async {
            self.Loader(removeFromView: false)
            self.Indicator.startAnimating()

        }
       }
       
       func hideLoading() {
        DispatchQueue.main.async {
            self.Loader(removeFromView: true)
            self.Indicator.stopAnimating()

        }
       }
    
    func GoVC(Storyboard: String, Screen: String,Present:Bool) {
        let vc = UIStoryboard(name: Storyboard, bundle: nil).instantiateViewController(withIdentifier: Screen)
        guard Present == true else {
            self.navigationController?.pushViewController(vc, animated: true)
            return
        }
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    func ReturnVC(Present:Bool) {
        guard Present == true else {
            self.navigationController?.popViewController(animated: true)
            return
        }
        self.dismiss(animated: true, completion: nil)
      }
    
    func NetworkAvailability() {
        let queue = DispatchQueue.global(qos: .background)

        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            if path.status == .satisfied {
                DispatchQueue.main.async {
                    self?.NetworkViewIntializer(show: false)
            
                }
                print("We're connected!")
            } else {
                DispatchQueue.main.async {
                    self?.NetworkViewIntializer(show: true)

                    print("No connection.")
                }
               
            }
            print(path.status)
        }
     
      }
      
       
 
       
    func showAlert(title: String?, message: String) {
        DispatchQueue.main.async {
            
           let titleTxt = NSLocalizedString(title ?? "", comment: "")
                let messageTxt = NSLocalizedString(message, comment: "")
                let alertController = UIAlertController(title: titleTxt, message: messageTxt, preferredStyle: UIAlertController.Style.alert)
                let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(alertAction)
            self.present(alertController, animated: true, completion: nil)
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
