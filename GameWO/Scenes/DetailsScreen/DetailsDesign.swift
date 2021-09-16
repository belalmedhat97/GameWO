//
//  DetailsDesign.swift
//  GameWO
//
//  Created by Belal medhat on 12/16/20.
//  Copyright © 2020 Belal medhat. All rights reserved.
//

import UIKit
extension DetailsVC {
    func ImageViewer(image:String){
        
       
            self.UIimageViewer = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
            self.UIimageViewer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.screenimage = UIImageView(frame: CGRect(x: self.UIimageViewer.frame.minX, y: self.UIimageViewer.frame.minY, width: self.UIimageViewer.frame.width, height: self.UIimageViewer.frame.height))
            self.screenimage.sd_setImage(with: URL(string: image), completed: nil)
        self.screenimage.contentMode = .scaleToFill
            self.CloseButton.setTitle("CLOSE", for: .normal)
            self.CloseButton.setTitleColor(#colorLiteral(red: 0.5401973128, green: 0.9296894073, blue: 0.6209766269, alpha: 1), for: .normal)
            self.CloseButton.borderWidth = 0.5
            self.CloseButton.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            self.CloseButton.addTarget(self, action: #selector(self.closeAction), for: .touchUpInside)
            self.CloseButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.CloseButton.cornerRadius = 10

               

            self.view.addSubview(self.UIimageViewer)
            self.UIimageViewer.addSubview(self.screenimage)
            self.UIimageViewer.addSubview(self.CloseButton)
            
            self.CloseButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([self.CloseButton.centerXAnchor.constraint(equalTo: self.UIimageViewer.centerXAnchor),self.CloseButton.bottomAnchor.constraint(equalTo: self.UIimageViewer.bottomAnchor, constant: -20),self.CloseButton.widthAnchor.constraint(equalToConstant: 100),self.CloseButton.heightAnchor.constraint(equalToConstant: 30)])

               
               
               
        

         
     }
     @objc func closeAction(){
     
            self.UIimageViewer.removeFromSuperview()

        
     }
}
