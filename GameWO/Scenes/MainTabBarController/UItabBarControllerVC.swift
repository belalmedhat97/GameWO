//
//  UItabBarControllerVC.swift
//  GameWO
//
//  Created by Belal medhat on 7/5/20.
//  Copyright © 2020 Belal medhat. All rights reserved.
//

import UIKit
class UItabBarControllerVC: UITabBarController,UITabBarControllerDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view.
    
           
        setTabsControllers()
        tabbarCustomization()
    }
//    override func viewDidLayoutSubviews() { // change tabbar height
//        super.viewDidLayoutSubviews()
//        tabBar.frame.size.height = 80
//        tabBar.frame.origin.y = view.frame.height - 80
//    }



    @IBOutlet weak var TabBar: UITabBar!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    private func tabbarCustomization(){

        TabBar.isTranslucent = true
        TabBar.cornerRadius = 20
        TabBar.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        TabBar.clipsToBounds = true
        TabBar.tintColor = #colorLiteral(red: 0.5401973128, green: 0.9296894073, blue: 0.6209766269, alpha: 1)
        TabBar.barTintColor = #colorLiteral(red: 0.9411764706, green: 0.9568627451, blue: 0.9725490196, alpha: 1)
        TabBar.barStyle = .default
        TabBar.unselectedItemTintColor = #colorLiteral(red: 0.4549019608, green: 0.5411764706, blue: 0.6156862745, alpha: 1)
        TabBar.borderColor = #colorLiteral(red: 0.6509803922, green: 0.737254902, blue: 0.8156862745, alpha: 1)
        TabBar.borderWidth  = 0.5
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : TabBar.unselectedItemTintColor ?? #colorLiteral(red: 0.4549019608, green: 0.5411764706, blue: 0.6156862745, alpha: 1)], for: .selected)
     
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : TabBar.unselectedItemTintColor ?? #colorLiteral(red: 0.4549019608, green: 0.5411764706, blue: 0.6156862745, alpha: 1)], for: .normal)
            // set the color of text in tabbar of selected state

    
        
        
    }
    private func setTabsControllers() {
        let vc = UIStoryboard(name: Storyboards.Home, bundle: nil).instantiateViewController(withIdentifier: ScreenID.MainHomeGamesVC)
        vc.tabBarItem.title = "Home"
        vc.tabBarItem.image = #imageLiteral(resourceName: "icons8-home-500")
    
      let vc1 = UIStoryboard(name: Storyboards.Home, bundle: nil).instantiateViewController(withIdentifier: ScreenID.GamesGenres)
        vc1.tabBarItem.title = "Genre"
        vc1.tabBarItem.image = #imageLiteral(resourceName: "icons8-game-controller-100")
        let vc3 = UIStoryboard(name: Storyboards.Home, bundle: nil).instantiateViewController(withIdentifier: ScreenID.SearchGamesVC)
        vc3.tabBarItem.title = "Search"
        vc3.tabBarItem.image = #imageLiteral(resourceName: "search")
        let vc2 = UIStoryboard(name: Storyboards.Home, bundle: nil).instantiateViewController(withIdentifier: ScreenID.GamesStoreVC)
        vc2.tabBarItem.title = "Stores"
        vc2.tabBarItem.image = #imageLiteral(resourceName: "Stores")
        
      viewControllers = [
        vc,
        vc1,
        vc2,
        vc3
      ]
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        // animation for tabbar items 
        guard let barButtonView = item.value(forKey: "view") as? UIView else { return }
        
        let animationLength: TimeInterval = 0.5
        let propertyAnimator = UIViewPropertyAnimator(duration: animationLength, dampingRatio: 0.5) {
            barButtonView.transform = CGAffineTransform.identity.scaledBy(x: 1.2, y: 1.2)
        }
        propertyAnimator.addAnimations({ barButtonView.transform = .identity }, delayFactor: CGFloat(animationLength))
        propertyAnimator.startAnimation()
    }

}

