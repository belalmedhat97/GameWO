//
//  MainHomeGamesVC.swift
//  GameWO
//
//  Created by Belal medhat on 7/12/20.
//  Copyright © 2020 Belal medhat. All rights reserved.
//

import UIKit
import SDWebImage
import SwiftyContextMenu
import NVActivityIndicatorView
class MainHomeGamesVC: BaseViewController,MainHomeGamesViewProtocols {
    
    
    private let transition = StretchAnimator() // animation object
    private var ComingCase:Bool? // variable to detect if present from scroll or coming collectionviews to make animations
    private var isPagniated:Bool = false
    private var pagniationOption:String = ""
    private var setOfFilters:Set<String> = ["name","-name","released","-released","added","-added","created","-created","updated","-updated","rating","-rating","metacritic","-metacritic"]
    
    var presenter: MainHomeGamesPresenterProtocols?
    override func viewDidLoad() {
        super.viewDidLoad()
        Logo.alpha = 0
        let spinner = UIActivityIndicatorView(style: .gray)
        spinner.color = UIColor.darkGray
        spinner.hidesWhenStopped = true
        self.tabBarController?.delegate = self
        NextPage = false
        PreviousPage = false
        self.popularGamesCollection.refreshControl = refreshControlView
        self.presenter = MainHomeGamesPresenter(view:self)
        ComingGamesCollection.delegate = self
        ComingGamesCollection.dataSource = self
        popularGamesCollection.delegate = self
        popularGamesCollection.dataSource = self
        self.presenter?.AddFilterData()
        ComingGamesCollection.register(UINib(nibName: customCellsView.ComingViewCell, bundle: nil), forCellWithReuseIdentifier: customCells.ComingClassCell)
        popularGamesCollection.register(UINib(nibName: customCellsView.ComingViewCell, bundle: nil), forCellWithReuseIdentifier: customCells.ComingClassCell)
        
        
        Filter.addContextMenu((self.presenter?.actionFilterList())!, for: .tap(numberOfTaps: 1))
        transition.dismissCompletion = { [weak self] in
            if self?.ComingCase == true {
                guard let selectedIndexPathCell = self?.ComingGamesCollection.indexPathsForSelectedItems?[0],
                      let selectedCell = self?.ComingGamesCollection.cellForItem(at: selectedIndexPathCell)
                        as? ComingClassCell
                else {
                    return
                }
            }else{
                guard let selectedIndexPathCell = self?.popularGamesCollection.indexPathsForSelectedItems?[0],
                      let selectedCell = self?.popularGamesCollection.cellForItem(at: selectedIndexPathCell)
                        as? ComingClassCell
                else {
                    return
                }
            }
        }
        refreshControlView.addTarget(self, action: #selector(self.refreshContents), for: .valueChanged)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.AnimateLogo(LogoView: Logo)
        
        if isPagniated == false {
            pagniationOption = setOfFilters.randomElement() ?? ""
            self.presenter?.handleViewDidLoadPopular(showloader: true, pageSize: "20", Page: "\(self.StartPage)", ordering:pagniationOption, completionHandler:{})
            self.presenter?.handleViewDidLoadComing()
            
        }else{
            self.presenter?.handleViewDidLoadPopular(showloader: true, pageSize: "20", Page: "\(self.StartPage)", ordering:pagniationOption, completionHandler:{})
            self.presenter?.handleViewDidLoadComing()
            
        }
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        Logo.alpha = 0
    }
    override func viewDidDisappear(_ animated: Bool) {
        self.presenter?.ResetCollectionsList()
    }
    
    
    @objc func refreshContents() {
        if self.NextPage == false {
            self.showAlert(title: "", message: "There is no other pages")
        }else{
            let refreshView = self.refreshControlView.viewWithTag(12052018)
            for vw in (refreshView?.subviews)! {
                if let indicator = vw as? NVActivityIndicatorView {
                    indicator.startAnimating()
                }
            }
            self.perform(#selector(self.ForwardPagination), with: nil, afterDelay: 1.5)
        }
    }
    
    
    @objc func ForwardPagination() {
        StartPage+=1
        self.presenter?.handleViewDidLoadPopular(showloader: false, pageSize: "20", Page: "\(StartPage)", ordering: pagniationOption){ // go next pagination
            let refreshView = self.refreshControlView.viewWithTag(12052018)
            for vw in (refreshView?.subviews)! {
                if let indicator = vw as? NVActivityIndicatorView {
                    indicator.stopAnimating()
                }
            }
            self.refreshControlView.endRefreshing()
            return ()
        }
    }
    @objc func BackPagination(){ // go back pagination
        StartPage-=1
        self.presenter?.handleViewDidLoadPopular(showloader: true, pageSize: "20", Page: "\(StartPage)", ordering: pagniationOption, completionHandler: {})
    }
    func ChangeScrollCollectionBottom() { // change bottom constraints and add back pagination buttom
        if PreviousPage == false {
            UIView.animate(withDuration: 1) {
                self.ScrollBottomConstraints.constant = 0
                self.PaginationButton.removeFromSuperview()
            }
        }else{
            
            
            UIView.animate(withDuration: 1) {
                self.ScrollBottomConstraints.constant = 50
                self.PaginationButton.setImage(#imageLiteral(resourceName: "Pagination"), for: .normal)
                self.PaginationButton.addTarget(self, action: #selector(self.BackPagination), for: .touchUpInside)
                self.view.addSubview(self.PaginationButton)
                self.PaginationButton.translatesAutoresizingMaskIntoConstraints = false
                self.PaginationButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
                self.PaginationButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
                self.PaginationButton.topAnchor.constraint(equalToSystemSpacingBelow: self.popularGamesCollection.bottomAnchor, multiplier: 1).isActive = true
                self.PaginationButton.centerXAnchor.constraint(equalTo: self.popularGamesCollection.centerXAnchor).isActive = true
                
                
            }
        }
    }
    
    @IBOutlet weak var Logo: UIImageView!
    @IBOutlet weak var ScrollBottomConstraints: NSLayoutConstraint!
    @IBOutlet weak var ComingGamesCollection: UICollectionView!
    @IBOutlet weak var popularGamesCollection: UICollectionView!
    @IBOutlet weak var Filter: UIButton!
    @objc func RefeshCaller(){
        print("dawdawdawddadadawdwad")
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    func reloadComingCollection() {
        ComingGamesCollection.reloadData()
    }
    
    func reloadPopularCollection() {
        if NextPage == true && PreviousPage == true {
            popularGamesCollection.reloadData()
            let lastItemIndex = NSIndexPath(item: 0, section: 0)
            self.popularGamesCollection.scrollToItem(at: lastItemIndex as IndexPath, at: .top, animated: true)
            
            
            
        }else{
            popularGamesCollection.reloadData()
            
        }
    }
    
}
extension MainHomeGamesVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == ComingGamesCollection {
            return self.presenter?.ComingList().count ?? 0
        }else{
            return self.presenter?.ScrollList().count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == ComingGamesCollection {
            guard self.presenter?.ComingList().count != 0 else { // check if data exists
                let cell = ComingGamesCollection.dequeueReusableCell(withReuseIdentifier: customCells.ComingClassCell, for: indexPath) as! ComingClassCell
                return cell}
            
            let cell = ComingGamesCollection.dequeueReusableCell(withReuseIdentifier: customCells.ComingClassCell, for: indexPath) as! ComingClassCell
            cell.layer.masksToBounds = false
            cell.clipsToBounds = true
            
            if self.presenter?.ComingList()[indexPath.item].background_image ?? "" != "" {
                cell.GameImage.sd_imageIndicator = IndicatorColor()
                cell.GameImage.sd_setImage(with: URL(string: self.presenter?.ComingList()[indexPath.item].background_image ?? ""), completed: nil)

            } else {
                cell.GameImage.image = #imageLiteral(resourceName: "NoImage")
            }
            cell.GameName.text = self.presenter?.ComingList()[indexPath.item].name ?? "No Name"
            guard self.presenter?.ComingList()[indexPath.item].parent_platforms != nil else {
                
                return cell}
            
            
            return cell
        }else{
            let cell = popularGamesCollection.dequeueReusableCell(withReuseIdentifier: customCells.ComingClassCell, for: indexPath) as! ComingClassCell
            
            cell.clipsToBounds = true
            if self.presenter?.ScrollList()[indexPath.item].background_image ?? "" != "" {
                cell.GameImage.sd_imageIndicator = IndicatorColor()
                cell.GameImage.sd_setImage(with: URL(string: self.presenter?.ScrollList()[indexPath.item].background_image ?? ""), completed: nil)

            } else {
                cell.GameImage.image = #imageLiteral(resourceName: "NoImage")
            }
            cell.GameName.text = self.presenter?.ScrollList()[indexPath.item].name ?? "No Name"
            
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == ComingGamesCollection {
            return CGSize(width: 170, height: collectionView.frame.height)
        }else {
            return CGSize(width: collectionView.frame.width/2 - 10, height:170)
            
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == ComingGamesCollection {
            return 10
        }else {
            return 10
            
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == ComingGamesCollection {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }else{
            return UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
            
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == ComingGamesCollection {
            if let cell = ComingGamesCollection.cellForItem(at: indexPath) as? ComingClassCell {
                
                let storyboard = UIStoryboard(name: Storyboards.Home, bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "DetailsVC") as! DetailsVC
                vc.SingleImage = cell.GameImage.image
                isPagniated = true
                vc.Id = "\(self.presenter?.ComingList()[indexPath.item].id ?? 0)"
                self.navigationController?.pushViewController(vc, animated: true)
                
                
            }
        }else{
            if let cell = popularGamesCollection.cellForItem(at: indexPath) as? ComingClassCell {
                let storyboard = UIStoryboard(name: Storyboards.Home, bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "DetailsVC") as! DetailsVC
                vc.SingleImage = cell.GameImage.image
                isPagniated = true
                vc.Id = "\(self.presenter?.ScrollList()[indexPath.item].id ?? 0)"
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
        }
    }
    
}
    extension MainHomeGamesVC:UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
           let tabBarIndex = tabBarController.selectedIndex
           if tabBarIndex != 0 {
               //do your stuff
            isPagniated = false
           }
      }
}
