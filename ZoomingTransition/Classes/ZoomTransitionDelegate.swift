//
//  ZoomTransitionDelegate.swift
//  ZoomingTransition
//
//  Created by Desong on 2021/2/4.
//

import UIKit

public protocol ZoomTransitionAnimatorDelegate: class {

    
    func transitionWillStart()

   
    func transitionDidEnd()

   
    func referenceImage() -> UIImage?

    
    func imageFrame() -> CGRect?
}
