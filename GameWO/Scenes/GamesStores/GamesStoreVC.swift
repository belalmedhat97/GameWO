//
//  GamesStoreVC.swift
//  GameWO
//
//  Created by Belal medhat on 9/24/20.
//  Copyright © 2020 Belal medhat. All rights reserved.
//

import UIKit

class GamesStoreVC: BaseViewController, GamesStoreViewProtocol {


    var presenter:GamesStorePresenterProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        Logo.alpha = 0

        self.presenter = GameStorePresenter(view: self)
        // Do any additional setup after loading the view.
        StoreCollection.delegate = self
        StoreCollection.dataSource = self
        StoreCollection.register(UINib(nibName: "StoreViewCell", bundle: nil), forCellWithReuseIdentifier: "StoreClassCell")

    }
    override func viewWillDisappear(_ animated: Bool) {
        Logo.alpha = 0
        
      }
    @IBOutlet weak var Logo: UIImageView!
    override func viewWillAppear(_ animated: Bool) {
        self.AnimateLogo(LogoView: Logo)
        self.presenter?.handleViewDidLoad()



    }
    override func viewDidDisappear(_ animated: Bool) {
        self.presenter?.ResetStoreList()

    }
    func reloadStoreCollection() {
        StoreCollection.reloadData()
    }
    
    @IBOutlet weak var StoreCollection: UICollectionView!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension GamesStoreVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.presenter?.StoreList().count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = StoreCollection.dequeueReusableCell(withReuseIdentifier: "StoreClassCell", for: indexPath) as! StoreClassCell
        
        cell.StoreName.text = self.presenter?.StoreList()[indexPath.item].name ?? ""
        cell.StoreImage.sd_imageIndicator = IndicatorColor()

        cell.StoreImage.sd_setImage(with:URL(string: self.presenter?.StoreList()[indexPath.item].imageBackground ?? ""), completed: nil)
        cell.GamesCount.text = "Games Count :"+" "+"\(self.presenter?.StoreList()[indexPath.item].gamesCount ?? 0)"
        cell.CallButton = {
            if let url = URL(string: "https://" + "\(self.presenter?.StoreList()[indexPath.item].domain ?? "")") {
                UIApplication.shared.open(url)
            }

        }

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2 - 16, height:200)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
               return 10

       }
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
           return 0
       }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 30, right: 10)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc  = UIStoryboard.init(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "StoreSelectedVC") as! StoreSelectedVC
        vc.ID = "\(self.presenter?.StoreList()[indexPath.item].id ?? 0)"
        vc.Title = self.presenter?.StoreList()[indexPath.item].name ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
