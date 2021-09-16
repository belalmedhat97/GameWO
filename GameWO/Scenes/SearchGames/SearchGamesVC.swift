//
//  SearchGamesVC.swift
//  GameWO
//
//  Created by Belal medhat on 12/16/20.
//  Copyright © 2020 Belal medhat. All rights reserved.
//

import UIKit

class SearchGamesVC: BaseViewController,SearchGamesViewProtocols {

    
     var presenter: SearchGamesPresenterProtocols?
    
    var SearchField:UITextField = UITextField()
    var leftTextOpen:NSLayoutConstraint!
    var RightTextOpen:NSLayoutConstraint!
    var WidthTextClose:NSLayoutConstraint!
    var RightTextClose:NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = SearchGamesPresenter(view: self)
        Logo.alpha = 0
        // Do any additional setup after loading the view.
        
        SearchButton.cornerRadius = SearchButton.frame.width/2
        SearchButton.layer.masksToBounds = false
        addSearchBar()
        SearchCollcection.register(UINib(nibName: customCellsView.ComingViewCell, bundle: nil), forCellWithReuseIdentifier: customCells.ComingClassCell)
        SearchCollcection.delegate = self
        SearchCollcection.dataSource = self
        Nodata.alpha = 0
    }
    override func viewWillDisappear(_ animated: Bool) {
          Logo.alpha = 0
      }
    @IBOutlet weak var Logo: UIImageView!
    @IBOutlet weak var Nodata: UIView!
    @IBOutlet weak var SearchView: UIView!
    @IBOutlet weak var SearchCollcection: UICollectionView!
    @IBOutlet weak var SearchButton: UIButton!
    override func viewWillAppear(_ animated: Bool) {
        self.AnimateLogo(LogoView: Logo)

        
    }
    func addSearchBar(){
        SearchField = UITextField(frame: CGRect(x: SearchButton.frame.maxX, y: SearchButton.frame.minY, width: SearchButton.frame.width, height: SearchButton.frame.height))
        SearchField.cornerRadius = SearchButton.cornerRadius
        SearchField.layer.masksToBounds = false
        SearchField.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        SearchField.shadowOffset = CGSize(width: -1, height: 1)
        SearchField.shadowRadius = 5
        SearchField.shadowOpacity = 0.3
        SearchField.textColor = #colorLiteral(red: 0.6509803922, green: 0.737254902, blue: 0.8156862745, alpha: 1)
        SearchView.insertSubview(SearchField, belowSubview: SearchButton)
        // set placeholder text place
        SearchField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: self.SearchButton.frame.height))
        SearchField.leftViewMode = UITextField.ViewMode.always
        SearchField.alpha = 0
    }
    @IBAction func SearchButtonAction(_ sender: UIButton) {
         animateSearch()
    }
    @IBAction func CloseSearch(_ sender: UISwipeGestureRecognizer) {
        if SearchButton.tag == 1 {
            RightTextOpen.isActive = false
            leftTextOpen.isActive = false
            
            RightTextClose = self.SearchField.rightAnchor.constraint(equalTo: self.SearchButton.rightAnchor, constant: 0)
            WidthTextClose = self.SearchField.widthAnchor.constraint(equalTo: self.SearchButton.widthAnchor, constant: 0)
            
            RightTextClose.isActive = true
            WidthTextClose.isActive = true


            UIView.animate(withDuration: 1) {
                self.view.layoutIfNeeded()
            }
            SearchButton.tag = 0
        }

    }
    
    
    func animateSearch(){
        if SearchButton.tag == 0 {
        SearchField.translatesAutoresizingMaskIntoConstraints = false
        SearchButton.translatesAutoresizingMaskIntoConstraints = true
        if RightTextClose != nil {
        RightTextClose.isActive = false
        WidthTextClose.isActive = false
        }
        if SearchButton.tag == 0 {}
        RightTextOpen = self.SearchField.rightAnchor.constraint(equalTo: self.SearchButton.leftAnchor, constant: -10 )
        leftTextOpen = self.SearchField.leftAnchor.constraint(equalTo: self.SearchView.leftAnchor, constant: 10)
        RightTextOpen.isActive = true
        leftTextOpen.isActive = true
        self.SearchField.heightAnchor.constraint(equalTo: self.SearchButton.heightAnchor, constant: 0).isActive = true
        self.SearchField.centerYAnchor.constraint(equalTo: self.SearchView.centerYAnchor).isActive = true
           
        UIView.animate(withDuration: 1.5) {
                self.SearchField.alpha = 1
                self.view.layoutIfNeeded()
                self.SearchField.placeholder = "Search Games"
        }
        SearchButton.tag = 1
        }else{
            self.presenter?.handleDidSearch(searchValue: SearchField.text ?? "")
        }
        }
    
      func reloadGamesCollection() {
        SearchCollcection.reloadData()
      }
    func showError(show:Bool){
        if show == true {
        Nodata.alpha = 1
        }else{
        Nodata.alpha = 0
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
extension SearchGamesVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

            return self.presenter?.gameSearchList().count ?? 0
      
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard self.presenter?.gameSearchList().count != 0 else { // check if data exists
                        let cell = SearchCollcection.dequeueReusableCell(withReuseIdentifier: customCells.ComingClassCell, for: indexPath) as! ComingClassCell
                       return cell
                
        }
                
            let cell = SearchCollcection.dequeueReusableCell(withReuseIdentifier: customCells.ComingClassCell, for: indexPath) as! ComingClassCell
            cell.layer.masksToBounds = false
            cell.clipsToBounds = true
                
            cell.GameImage.sd_imageIndicator = IndicatorColor()
            cell.GameImage.sd_setImage(with: URL(string: self.presenter?.gameSearchList()[indexPath.item].background_image ?? ""), completed: nil)
                cell.GameName.text = self.presenter?.gameSearchList()[indexPath.item].name ?? ""
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

        let cell = SearchCollcection.cellForItem(at: indexPath) as! ComingClassCell

            let storyboard = UIStoryboard(name: Storyboards.Home, bundle: nil)
                   let vc = storyboard.instantiateViewController(withIdentifier: "DetailsVC") as! DetailsVC
             vc.SingleImage = cell.GameImage.image

            vc.Id = "\(self.presenter?.gameSearchList()[indexPath.item].id ?? 0)"
            self.navigationController?.pushViewController(vc, animated: true)


        }
     
          

    }
