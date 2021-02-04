//
//  ZoomingPushVC.swift
//  ZoomingTransition
//
//  Created by Desong on 2021/2/4.
//

import UIKit
@available(iOS 10.0,*)
open class ZoomingPushVC: UIViewController {

    fileprivate var lastSelectedIndexPath: IndexPath? = nil
    fileprivate var currentAnimationTransition: UIViewControllerAnimatedTransitioning? = nil
    
    
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.delegate = self
        
    }
    


}


@available(iOS 10.0, *)
extension ZoomingPushVC: UINavigationControllerDelegate{
    
    public func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        
        let result: UIViewControllerAnimatedTransitioning?
        if
            
            operation == .push
        {
            result = ZoomingPushTransition(fromDelegate: fromVC, toDelegate: toVC)
        } else if
           
            operation == .pop
        {
            
            result = ZoomingPopTransition(toDelegate: toVC, fromDelegate: fromVC)
        } else {
            result = nil
        }
        self.currentAnimationTransition = result
        return result
    }
    
    public func navigationController(
        _ navigationController: UINavigationController,
        interactionControllerFor animationController: UIViewControllerAnimatedTransitioning
    ) -> UIViewControllerInteractiveTransitioning? {
        return self.currentAnimationTransition as? UIViewControllerInteractiveTransitioning
    }
    
    public func navigationController(
        _ navigationController: UINavigationController,
        didShow viewController: UIViewController,
        animated: Bool
    ) {
        self.currentAnimationTransition = nil
    }
    
   
    
}



