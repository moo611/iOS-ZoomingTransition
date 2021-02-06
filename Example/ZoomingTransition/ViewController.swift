//
//  ViewController.swift
//  ZoomingTransition
//
//  Created by lnpjjds@gmail.com on 02/04/2021.
//  Copyright (c) 2021 lnpjjds@gmail.com. All rights reserved.
//

import UIKit
import SnapKit
import ZoomingTransition
class ViewController: ZoomingPushVC,UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slices.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
        
        cell.imageView.image = slices[indexPath.row]
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.lastSelectedIndexPath = indexPath
        let vc = PreviewVC()
        vc.image = self.slices[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
   
    fileprivate var lastSelectedIndexPath: IndexPath? = nil
    
    var collectionView:UICollectionView!
    var slices = [UIImage]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.navigationItem.title = "ZoomingTransition"
        self.navigationController?.navigationBar.backgroundColor = .white
        slices.append(UIImage(named: "a1")!)
        slices.append(UIImage(named: "a2")!)
        slices.append(UIImage(named: "a3")!)
        slices.append(UIImage(named: "a4")!)
        slices.append(UIImage(named: "a5")!)
        slices.append(UIImage(named: "a6")!)
        slices.append(UIImage(named: "a7")!)
        slices.append(UIImage(named: "a8")!)
        
        //SETUPUI
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 2.5
        layout.minimumInteritemSpacing = 2.5
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width/2-2.5, height: UIScreen.main.bounds.width/2-2.5)
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), collectionViewLayout: layout)
        
        view.addSubview(self.collectionView)
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.reloadData()
    }

   

}


extension ViewController: ZoomTransitionAnimatorDelegate{
    func transitionWillStart() {
        guard let lastSelected = self.lastSelectedIndexPath else { return }
        self.collectionView.cellForItem(at: lastSelected)?.isHidden = true
    }
    
    func transitionDidEnd() {
        guard let lastSelected = self.lastSelectedIndexPath else { return }
        self.collectionView.cellForItem(at: lastSelected)?.isHidden = false
    }
    
    func referenceImage() -> UIImage? {
        guard
            let lastSelected = self.lastSelectedIndexPath,
            let cell = self.collectionView.cellForItem(at: lastSelected) as? CustomCell
        else {
            return nil
        }

        return cell.imageView.image
    }
    
    func imageFrame() -> CGRect? {
        guard
            let lastSelected = self.lastSelectedIndexPath,
            let cell = self.collectionView.cellForItem(at: lastSelected) as? CustomCell
        
        else {
            return nil
        }
        
        return FrameHelper.getTargerFrame(originalView: cell.imageView, targetView: self.view)
    
    
    
    }
    
}
