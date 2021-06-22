//
//  MainHomeVC.swift
//  GameWO
//
//  Created by Belal medhat on 7/5/20.
//  Copyright © 2020 Belal medhat. All rights reserved.
//

import UIKit
import SDWebImage
class GamesGenres: BaseViewController,GamesGenresViewProtocols{
    var presenter: GamesGenresPresenterProtocols?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = GamesGenresPresenter(view:self)
        Logo.alpha = 0

        // Do any additional setup after loading the view.
        GenresCollection.delegate = self
        GenresCollection.dataSource = self
        GenresCollection.register(UINib(nibName: "GenreViewCell", bundle: nil), forCellWithReuseIdentifier: "GenreClassCell")
//        self.AnimateLogo(LogoView: Logo)

    }
    override func viewWillAppear(_ animated: Bool) {
        self.AnimateLogo(LogoView: Logo)
        self.presenter?.handleViewDidLoad()


    }
    override func viewWillDisappear(_ animated: Bool) {
          Logo.alpha = 0
      }
    @IBOutlet weak var Logo: UIImageView!
    func reloadGenreCollection() {
        self.GenresCollection.reloadData()
    }
    
    
    @IBOutlet weak var GenresCollection: UICollectionView!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension GamesGenres:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.presenter?.GenreList().count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = GenresCollection.dequeueReusableCell(withReuseIdentifier: "GenreClassCell", for: indexPath) as! GenreClassCell
        
        cell.GenreName.text = self.presenter?.GenreList()[indexPath.item].name ?? ""
        cell.GenreImage.sd_imageIndicator = IndicatorColor()
        cell.GenreImage.sd_setImage(with:URL(string: self.presenter?.GenreList()[indexPath.item].image_background ?? ""), completed: nil)
        cell.GamesCount.text = "Games Count :"+" "+"\(self.presenter?.GenreList()[indexPath.item].games_count ?? 0)"
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
        let vc  = UIStoryboard.init(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "GenreSelectedVC") as! GenreSelectedVC
        vc.ID = "\(self.presenter?.GenreList()[indexPath.item].id ?? 0)"
        vc.Title = self.presenter?.GenreList()[indexPath.item].name ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
