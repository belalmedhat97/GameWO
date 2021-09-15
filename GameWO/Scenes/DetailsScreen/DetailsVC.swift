//
//  DetailsVC.swift
//  GameWO
//
//  Created by Belal medhat on 7/18/20.
//  Copyright © 2020 Belal medhat. All rights reserved.
//

import UIKit
import CoreImage
import AVKit
import Cosmos
import SDWebImage
class DetailsVC: BaseViewController,DetailsVCViewProtocols {
    
    var UIimageViewer = UIView()
    var screenimage = UIImageView()
    var CloseButton = UIButton()
    var Id:String?
    var video = AVPlayer()
    let videoPlayerInTotalView = AVPlayerViewController()
    var presenter: DetailsVCPresenterProtocols?
    var SingleImage:UIImage?
    var centerCell:TrailerClassCell!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewCenterLayout()
        layout.estimatedItemSize = CGSize(width: 100, height: 30)
        PlatformCollection.collectionViewLayout = layout
        GameVIewImage.image = SingleImage
        GameVIewImage.layer.masksToBounds = true
        self.presenter = DetailsVCPresenter(view: self)
        // Do any additional setup after loading the view.
        TrailerCollection.delegate = self
        TrailerCollection.dataSource = self
        ScreenShotCollection.delegate = self
        ScreenShotCollection.dataSource = self
        PlatformCollection.delegate = self
        PlatformCollection.dataSource = self
        StoresCollection.dataSource = self
        StoresCollection.delegate = self
        self.presenter?.ViewDidLoadDetails(id: Id ?? "")
        self.presenter?.ViewDidLoadTrailer(id: Id ?? "")
        self.presenter?.ViewDidLoadScreenshots(id: Id ?? "")
        
        TrailerCollection.register(UINib(nibName: "TrailerViewCell", bundle: nil), forCellWithReuseIdentifier: "TrailerClassCell")
        ScreenShotCollection.register(UINib(nibName: "ScreenShotViewCell", bundle: nil), forCellWithReuseIdentifier: "ScreenShotClassCell")
        PlatformCollection.register(UINib(nibName: "PlatformViewCell", bundle: nil), forCellWithReuseIdentifier: "PlatformClassCell")
        
        StoresCollection.register(UINib(nibName: "GameDetailsStoreViewCell", bundle: nil), forCellWithReuseIdentifier: "GameDetailsStoreClassCell")
    }
    @IBOutlet weak var LeftGreen: UIView!
    @IBOutlet weak var ScreenCollectionHeight: NSLayoutConstraint!
    @IBOutlet weak var Trailertitle: UILabel!
    @IBOutlet weak var RightGreen: UIView!
    @IBAction func Back(_ sender: UISwipeGestureRecognizer) {
        self.ReturnVC(Present: false)
        
    }
    func removeTrailerCollection(){
        TrailerCollection.removeFromSuperview()
        LeftGreen.removeFromSuperview()
        RightGreen.removeFromSuperview()
        Trailertitle.removeFromSuperview()
        ScreenCollectionHeight.constant = 0.13 * self.view.frame.height
        ScrollHeightConstraint.constant = 1000
    }
    
    @IBOutlet weak var StoresCollection: UICollectionView!
    @IBOutlet weak var RateNumber: UILabel!
    @IBOutlet weak var PlatformCollection: UICollectionView!
    @IBOutlet weak var rate: CosmosView!
    @IBOutlet weak var DescriptionData: UILabel!
    @IBOutlet weak var GameVIewImage: UIImageView!
    @IBOutlet weak var GameName: UILabel!
    @IBOutlet weak var TrailerCollection: UICollectionView!
    @IBOutlet weak var ScreenShotCollection: UICollectionView!
    @IBOutlet weak var ScrollHeightConstraint: NSLayoutConstraint!
    
    func reloadScreenshots() {
        ScreenShotCollection.reloadData()
    }
    
    func reloadTrailerVideos() {
        TrailerCollection.reloadData()
    }
    func reloadPlatforms() {
        PlatformCollection.reloadData()
    }
    func reloadStores(){
        StoresCollection.reloadData()
    }
    
    
    func reloadVCDetails(Details: GameDetailsResponse) {
        print(Details.added ?? 0)
        if Details.name == "" {
            GameName.text = "NO NAME FOUND"
            
        }else{
            GameName.text = Details.name ?? "NO NAME FOUND"
            
        }
        if Details.descriptionRaw == "" {
            DescriptionData.text = "NO DESCRIPTION FOUND"
        }else{
            DescriptionData.text = Details.descriptionRaw ?? "NO DESCRIPTION FOUND"
            
        }
        print(Details.platforms ?? "NO PLATFORM FOUND")
        rate.rating = Double(Details.rating ?? 0.0)
        RateNumber.text = "\(Details.rating ?? 0.0)"
        
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
extension DetailsVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == TrailerCollection {
            print(self.presenter?.TrailerList().count ?? 0)
            return self.presenter?.TrailerList().count ?? 0
        }else if collectionView == ScreenShotCollection {
            return self.presenter?.ScreenshotsLists().count ?? 0
        }else if collectionView == PlatformCollection {
            return self.presenter?.Platforms().count ?? 0
        }else{
            return self.presenter?.Stores().count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == TrailerCollection {
            let cell = TrailerCollection.dequeueReusableCell(withReuseIdentifier: "TrailerClassCell", for: indexPath) as! TrailerClassCell
            let indexPath2 = self.TrailerCollection.indexPathForItem(at: self.TrailerCollection.center)
            print(indexPath2 ?? 0)
            cell.AddVideo(TrailerUrl: self.presenter?.TrailerList()[indexPath.item].data?.R480 ?? self.presenter?.TrailerList()[indexPath.item].data?.max ?? "")
            return cell
        }else if collectionView == ScreenShotCollection{
            let cell = ScreenShotCollection.dequeueReusableCell(withReuseIdentifier: "ScreenShotClassCell", for: indexPath) as! ScreenShotClassCell
            cell.ScreenShotImage.sd_imageIndicator = IndicatorColor()
            cell.ScreenShotImage.sd_setImage(with: URL(string: self.presenter?.ScreenshotsLists()[indexPath.item].image ?? ""), completed: nil)
            
            return cell
        }else if collectionView == PlatformCollection{
            let cell = PlatformCollection.dequeueReusableCell(withReuseIdentifier: "PlatformClassCell", for: indexPath) as! PlatformClassCell
            cell.PlatformName.text = self.presenter?.Platforms()[indexPath.row].platform?.name
            
            return cell
        }else{
            let cell = StoresCollection.dequeueReusableCell(withReuseIdentifier: "GameDetailsStoreClassCell", for: indexPath) as! GameDetailsStoreClassCell
            cell.SetStore(name: self.presenter?.Stores()[indexPath.item].store?.name ?? "", id: self.presenter?.Stores()[indexPath.item].store?.id ?? 0)
            
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == TrailerCollection {
            if self.presenter?.TrailerList().count == 1 {
                return CGSize(width: collectionView.frame.width - 20, height:collectionView.frame.height - 20)
                
            }else{
                return CGSize(width: collectionView.frame.width - 100, height:collectionView.frame.height - 20)
                
            }

        }else if collectionView == ScreenShotCollection {
            return CGSize(width: collectionView.frame.width - 20, height:collectionView.frame.height - 30)
            
        }else if collectionView == PlatformCollection{
            
            
            return CGSize(width: 100, height: 40)
            
        }else{
            return CGSize(width: 100, height: 100)
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == ScreenShotCollection {
            
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 10
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == PlatformCollection {
            return 10
        }else{
            return 0
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == TrailerCollection {
            return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            
        }else if collectionView == ScreenShotCollection {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            
        }else if collectionView == StoresCollection && self.presenter?.Stores().count ?? 0 <= 3
        {
            
            let totalCellWidth = 100 * (self.presenter?.Stores().count ?? 0)
            let totalSpacingWidth = 10 * ((self.presenter?.Stores().count ?? 0) - 1)
            
            let leftInset = (StoresCollection.frame.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
            let rightInset = leftInset
            
            return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
        }else{
            return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == StoresCollection {
            print(self.presenter?.Stores()[indexPath.item].url ?? "")
            if let url = URL(string: self.presenter?.Stores()[indexPath.item].url ?? "") {
                UIApplication.shared.open(url)
                
            }
        }else if collectionView == ScreenShotCollection {
            ImageViewer(image: self.presenter?.ScreenshotsLists()[indexPath.item].image ?? "")
            
        }
    }
    
}

