//
//  GenreSelectedVC.swift
//  GameWO
//
//  Created by Belal medhat on 12/21/20.
//  Copyright © 2020 Belal medhat. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
class StoreSelectedVC: BaseViewController,StoreSelectedViewProtocols {
    

        var presenter: StoreSelectedPresenterProtocols?
        private let transition = StretchAnimator() // animation object
        private var ComingCase:Bool? // variable to detect if present from scroll or coming collectionviews to make animations
        var ID:String?
        var Title: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        Logo.alpha = 0
        let spinner = UIActivityIndicatorView(style: .gray)
                   spinner.color = UIColor.darkGray
                   spinner.hidesWhenStopped = true

                   NextPage = false
                   PreviousPage = false
                   self.StoreCollection.refreshControl = refreshControlView
        self.presenter = StoreSelectedPresenter(view: self)
        // Do any additional setup after loading the view.
        StoreCollection.delegate = self
        StoreCollection.dataSource = self
        StoreCollection.register(UINib(nibName: customCellsView.ComingViewCell, bundle: nil), forCellWithReuseIdentifier: customCells.ComingClassCell)

        self.GenreTitle.text = Title
        refreshControlView.addTarget(self, action: #selector(refreshContents), for: .valueChanged)

    }
    override func viewWillAppear(_ animated: Bool) {
    self.presenter?.handleViewDidLoadStore(StoreID: ID ?? "0", showloader: true, pageSize: "20", Page: "1", ordering: "-added", completionHandler: {})
        self.AnimateLogo(LogoView: Logo)
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.Logo.alpha = 0
    }
    @IBOutlet weak var Logo: UIImageView!
    @IBOutlet weak var GenreTitle: UILabel!
    @IBOutlet weak var StoreCollection: UICollectionView!
    
    @IBAction func dismissSwipe(_ sender: UISwipeGestureRecognizer) {
        self.ReturnVC(Present: false)
    }
    
    func reloadStoreCollection() {
        self.StoreCollection.reloadData()
     }

    @objc  func refreshContents() {
          if NextPage == false {
              self.showAlert(title: "", message: "There is no other pages")
          }else{
              let refreshView = refreshControlView.viewWithTag(12052018)
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
          self.presenter?.handleViewDidLoadStore(StoreID: ID ?? "0", showloader: false, pageSize: "20", Page: "\(StartPage)", ordering: "-added"){ // go next pagination
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
          self.presenter?.handleViewDidLoadStore(StoreID: ID ?? "0", showloader: true, pageSize: "20", Page: "\(StartPage)", ordering: "-added", completionHandler: {})
      }
      func ChangeScrollCollectionBottom() { // change bottom constraints and add back pagination buttom
          if PreviousPage == false {
              UIView.animate(withDuration: 1) {
              self.StoreListBottomConstraints.constant = 0
                  self.PaginationButton.removeFromSuperview()
              }
          }else{
          UIView.animate(withDuration: 1) {
              self.StoreListBottomConstraints.constant = 50
              self.PaginationButton.setImage(#imageLiteral(resourceName: "Pagination"), for: .normal)
              self.PaginationButton.addTarget(self, action: #selector(self.BackPagination), for: .touchUpInside)
              self.view.addSubview(self.PaginationButton)
              self.PaginationButton.translatesAutoresizingMaskIntoConstraints = false
              self.PaginationButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
              self.PaginationButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
              self.PaginationButton.topAnchor.constraint(equalToSystemSpacingBelow: self.StoreCollection.bottomAnchor, multiplier: 1).isActive = true
              self.PaginationButton.centerXAnchor.constraint(equalTo: self.StoreCollection.centerXAnchor).isActive = true

          }
          }
      }
        
      @IBOutlet weak var StoreListBottomConstraints: NSLayoutConstraint!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension StoreSelectedVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

    return self.presenter?.gameStoreList().count ?? 0
  
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard self.presenter?.gameStoreList().count != 0 else { // check if data exists
                    let cell = StoreCollection.dequeueReusableCell(withReuseIdentifier: customCells.ComingClassCell, for: indexPath) as! ComingClassCell
                   return cell
            
    }
            
        let cell = StoreCollection.dequeueReusableCell(withReuseIdentifier: customCells.ComingClassCell, for: indexPath) as! ComingClassCell
        cell.layer.masksToBounds = false
        cell.clipsToBounds = true
            
        cell.GameImage.sd_imageIndicator = IndicatorColor()
        cell.GameImage.sd_setImage(with: URL(string: self.presenter?.gameStoreList()[indexPath.item].background_image ?? ""), completed: nil)
            cell.GameName.text = self.presenter?.gameStoreList()[indexPath.item].name ?? ""
        return cell
     
}

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2 - 20, height:170)

}
func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    

}
func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
}
func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)

}
    
func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    let cell = StoreCollection.cellForItem(at: indexPath) as! ComingClassCell

        let storyboard = UIStoryboard(name: Storyboards.Home, bundle: nil)
               let vc = storyboard.instantiateViewController(withIdentifier: "DetailsVC") as! DetailsVC
         vc.SingleImage = cell.GameImage.image

        vc.Id = "\(self.presenter?.gameStoreList()[indexPath.item].id ?? 0)"
        self.navigationController?.pushViewController(vc, animated: true)


    }



}
