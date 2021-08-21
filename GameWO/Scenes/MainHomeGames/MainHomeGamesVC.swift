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

    
    private let refreshControlView = UIRefreshControl() // object of refresh control
    private let transition = StretchAnimator() // animation object
    private var ReservedIDplatform:[Int] = [1,2,3,4,5,6,7,8]
    var PaginationButton = UIButton()

    private var ComingCase:Bool? // variable to detect if present from scroll or coming collectionviews to make animations
    var NextPage:Bool? // detect if there is next page in API
    var PreviousPage:Bool? // detect if there is previous page in API
    var StartPage:Int = 1 // first page of pagination
    var presenter: MainHomeGamesPresenterProtocols?
    override func viewDidLoad() {
        super.viewDidLoad()
        Logo.alpha = 0
        let spinner = UIActivityIndicatorView(style: .gray)
        spinner.color = UIColor.darkGray
        spinner.hidesWhenStopped = true
        NextPage = false
        PreviousPage = false
        self.ScrollGamesCollection.refreshControl = refreshControlView
        self.refreshControlView.addTarget(self, action: #selector(RefeshCaller) , for: .valueChanged)
        self.presenter = MainHomeGamesPresenter(view:self)
        ComingGamesCollection.delegate = self
        ComingGamesCollection.dataSource = self
        ScrollGamesCollection.delegate = self
        ScrollGamesCollection.dataSource = self
        self.presenter?.AddFilterData()
        ComingGamesCollection.register(UINib(nibName: customCellsView.ComingViewCell, bundle: nil), forCellWithReuseIdentifier: customCells.ComingClassCell)
        ScrollGamesCollection.register(UINib(nibName: customCellsView.ComingViewCell, bundle: nil), forCellWithReuseIdentifier: customCells.ComingClassCell)

        
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
            guard let selectedIndexPathCell = self?.ScrollGamesCollection.indexPathsForSelectedItems?[0],
                  let selectedCell = self?.ScrollGamesCollection.cellForItem(at: selectedIndexPathCell)
                    as? ComingClassCell
                  else {
                    return
                }
            }
         }
        addRefreshControl()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.AnimateLogo(LogoView: Logo)
      
        
            self.presenter?.handleViewDidLoadPopular(showloader: true, pageSize: "20", Page: "\(self.StartPage)", ordering:"", completionHandler:{})
            self.presenter?.handleViewDidLoadComing()
        
    


    }
    override func viewWillDisappear(_ animated: Bool) {
          Logo.alpha = 0
      }
    override func viewDidDisappear(_ animated: Bool) {
        self.presenter?.ResetCollectionsList()
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
            refreshView.frame = self.refreshControlView.bounds
            self.refreshControlView.addSubview(refreshView)
            self.refreshControlView.tintColor = UIColor.clear
            self.refreshControlView.backgroundColor = UIColor.clear
            self.refreshControlView.addTarget(self, action: #selector(self.refreshContents), for: .valueChanged)
         
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
        self.presenter?.handleViewDidLoadPopular(showloader: false, pageSize: "20", Page: "\(StartPage)", ordering: ""){ // go next pagination
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
        self.presenter?.handleViewDidLoadPopular(showloader: true, pageSize: "20", Page: "\(StartPage)", ordering: "", completionHandler: {})
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
            self.PaginationButton.topAnchor.constraint(equalToSystemSpacingBelow: self.ScrollGamesCollection.bottomAnchor, multiplier: 1).isActive = true
            self.PaginationButton.centerXAnchor.constraint(equalTo: self.ScrollGamesCollection.centerXAnchor).isActive = true

        
            }
        }
    }
      
    @IBOutlet weak var Logo: UIImageView!
    @IBOutlet weak var ScrollBottomConstraints: NSLayoutConstraint!
    @IBOutlet weak var ComingGamesCollection: UICollectionView!
    @IBOutlet weak var ScrollGamesCollection: UICollectionView!
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
            ScrollGamesCollection.reloadData()
                       let lastItemIndex = NSIndexPath(item: 0, section: 0)
                       self.ScrollGamesCollection.scrollToItem(at: lastItemIndex as IndexPath, at: .top, animated: true)
            
       
            
        }else{
            ScrollGamesCollection.reloadData()

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
                
            cell.GameImage.sd_imageIndicator = IndicatorColor()
//                cell.GameName.text = self.presenter?.ComingList()[indexPath.item].name
                cell.GameImage.sd_setImage(with: URL(string: self.presenter?.ComingList()[indexPath.item].background_image ?? ""), completed: nil)
                cell.GameName.text = self.presenter?.ComingList()[indexPath.item].name ?? "No Name"
                guard self.presenter?.ComingList()[indexPath.item].parent_platforms != nil else {

                    return cell}
//                var PlatformID:[Int] = []
//                for Count in 0...(self.presenter?.ComingList()[indexPath.item].parent_platforms?.count ?? 0) - 1 {
////                    print(self.presenter?.ComingList()[indexPath.item].platforms?[Count].platform?.name ?? "")
//                    PlatformID.append(self.presenter?.ComingList()[indexPath.item].parent_platforms?[Count].platform?.id ?? 0)
//                }

            return cell
         }else{
             let cell = ScrollGamesCollection.dequeueReusableCell(withReuseIdentifier: customCells.ComingClassCell, for: indexPath) as! ComingClassCell

            cell.clipsToBounds = true
//            cell.GameName.text = self.presenter?.ScrollList()[indexPath.item].name
            cell.GameImage.sd_imageIndicator = IndicatorColor()
            cell.GameImage.sd_setImage(with: URL(string: self.presenter?.ScrollList()[indexPath.item].background_image ?? ""), completed: nil)
                cell.GameName.text = self.presenter?.ScrollList()[indexPath.item].name ?? "No Name"


//                var PlatformID:[Int] = []
//                for Count in 0...(self.presenter?.ScrollList()[indexPath.item].parent_platforms?.count ?? 0) - 1 {
//                    print(self.presenter?.ScrollList()[indexPath.item].platforms?[Count].platform?.name ?? "")
//                    PlatformID.append(self.presenter?.ScrollList()[indexPath.item].parent_platforms?[Count].platform?.id ?? 0)
//                }

               

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

            vc.Id = "\(self.presenter?.ComingList()[indexPath.item].id ?? 0)"
            self.navigationController?.pushViewController(vc, animated: true)

            
        }
        }else{
            if let cell = ScrollGamesCollection.cellForItem(at: indexPath) as? ComingClassCell {
               let storyboard = UIStoryboard(name: Storyboards.Home, bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "DetailsVC") as! DetailsVC
                vc.SingleImage = cell.GameImage.image
                vc.Id = "\(self.presenter?.ScrollList()[indexPath.item].id ?? 0)"
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
        }
          }

    }
