//
//  PreviewVC.swift
//  ZoomingTransition_Example
//
//  Created by Desong on 2021/2/4.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit
import ZoomingTransition
class PreviewVC:UIViewController {
    
    var image:UIImage?
    var showView = UIImageView()
    var closeButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        self.view.addSubview(showView)
        showView.snp.makeConstraints{(make)in
            
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.width)
            make.centerY.equalToSuperview()
        }
        if image != nil{
            showView.image = image
        }
        showView.contentMode = .scaleAspectFit
        
        self.view.addSubview(self.closeButton)
        self.closeButton.snp.makeConstraints{(make)in
            
            make.top.equalToSuperview().offset(50)
            make.leading.equalToSuperview().inset(15)
            make.width.height.equalTo(25)
        }
        self.closeButton.setImage(UIImage(named: "ic_close"), for: .normal)
        self.closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
    }
    
   


    @objc func close(){
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.popViewController(animated: true)
       
        
    }

}

extension PreviewVC: ZoomTransitionAnimatorDelegate{
    
    func transitionWillStart() {
       // self.imageView.isHidden = true
        self.view.alpha = 0
    }
    
    func transitionDidEnd() {
      //  self.imageView.isHidden = true
        self.view.alpha = 1
    }
    
    func referenceImage() -> UIImage? {
        return FrameHelper.getScreenshot(with: self.view)
    }
    
    func imageFrame() -> CGRect? {
       
        return self.view.frame
    }
    
    

}
