//
//  GenreSelectedVC.swift
//  GameWO
//
//  Created by Belal medhat on 12/21/20.
//  Copyright © 2020 Belal medhat. All rights reserved.
//

import UIKit

class GenreSelectedVC: BaseViewController,GenreSelectedViewProtocols {
  
    var NextPage:Bool?
    var PreviousPage:Bool?
    func ChangeScrollCollectionBottom(){print("dwadaw")}
    var presenter: GenreSelectedPresenterProtocols?
    var ID:String?
    var Title: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = GenreSelectedPresenter(view: self)
        // Do any additional setup after loading the view.
        GenreCollection.delegate = self
        GenreCollection.dataSource = self
            GenreCollection.register(UINib(nibName: customCellsView.ComingViewCell, bundle: nil), forCellWithReuseIdentifier: customCells.ComingClassCell)
        self.presenter?.handleViewDidLoadGenre(Genre: ID ?? "", showloader: true, pageSize: "20", Page: "1", ordering: "", completionHandler: {})
        self.GenreTitle.text = Title
    }
    
    @IBOutlet weak var GenreTitle: UILabel!
    @IBOutlet weak var GenreCollection: UICollectionView!
    
    @IBAction func dismissSwipe(_ sender: UISwipeGestureRecognizer) {
        self.ReturnVC(Present: false)
    }
    
    func reloadGenreCollection() {
        self.GenreCollection.reloadData()
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
extension GenreSelectedVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

    return self.presenter?.gameGenreList().count ?? 0
  
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard self.presenter?.gameGenreList().count != 0 else { // check if data exists
                    let cell = GenreCollection.dequeueReusableCell(withReuseIdentifier: customCells.ComingClassCell, for: indexPath) as! ComingClassCell
                   return cell
            
    }
            
        let cell = GenreCollection.dequeueReusableCell(withReuseIdentifier: customCells.ComingClassCell, for: indexPath) as! ComingClassCell
        cell.layer.masksToBounds = false
        cell.clipsToBounds = true
            
        cell.GameImage.sd_imageIndicator = IndicatorColor()
        cell.GameImage.sd_setImage(with: URL(string: self.presenter?.gameGenreList()[indexPath.item].background_image ?? ""), completed: nil)
            cell.GameName.text = self.presenter?.gameGenreList()[indexPath.item].name ?? ""
        return cell
     
}

func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    print("hihihihihhihihihiihi")
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

    let cell = GenreCollection.cellForItem(at: indexPath) as! ComingClassCell

        let storyboard = UIStoryboard(name: Storyboards.Home, bundle: nil)
               let vc = storyboard.instantiateViewController(withIdentifier: "DetailsVC") as! DetailsVC
         vc.SingleImage = cell.GameImage.image

        vc.Id = "\(self.presenter?.gameGenreList()[indexPath.item].id ?? 0)"
        self.navigationController?.pushViewController(vc, animated: true)


    }



}
