//
//  ZoomingPushTransition.swift
//  ZoomingTransition
//
//  Created by Desong on 2021/2/4.
//

import UIKit
@available(iOS 10.0,*)
public class ZoomingPushTransition: NSObject, UIViewControllerAnimatedTransitioning {
    fileprivate let fromDelegate: ZoomTransitionAnimatorDelegate
    fileprivate let toDelegate: ZoomTransitionAnimatorDelegate

    
    fileprivate let transitionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        if #available(iOS 11.0, *) {
            imageView.accessibilityIgnoresInvertColors = true
        } else {
            // Fallback on earlier versions
        }
        return imageView
    }()

     

   
    public init?(
        fromDelegate: Any,
        toDelegate : Any
    ) {
        guard let fromDelegate = fromDelegate as? ZoomTransitionAnimatorDelegate else {
            return nil
        }
        guard let toDelegate = toDelegate as? ZoomTransitionAnimatorDelegate else {
            return nil
        }
        self.fromDelegate = fromDelegate
        self.toDelegate = toDelegate
    }

    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }

    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        
        let toView = transitionContext.view(forKey: .to)
        let fromView = transitionContext.view(forKey: .from)
        

        let containerView = transitionContext.containerView
        
        [fromView, toView]
            .compactMap { $0 }
            .forEach {
                containerView.addSubview($0)
        }
        
        if let transitionImage = FrameHelper.getScreenshot(with: toView!){
           
            transitionImageView.image = transitionImage
            transitionImageView.frame = fromDelegate.imageFrame()!
                
            containerView.addSubview(self.transitionImageView)

            self.fromDelegate.transitionWillStart()
            self.toDelegate.transitionWillStart()

            let duration = self.transitionDuration(using: transitionContext)
            let spring: CGFloat = 0.95
            
            let animator = UIViewPropertyAnimator(duration: duration, dampingRatio: spring) {
                self.transitionImageView.frame = toView!.frame
              
            }
            animator.addCompletion { (position) in
                assert(position == .end)

                self.transitionImageView.removeFromSuperview()
                self.transitionImageView.image = nil
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                self.toDelegate.transitionDidEnd()
                self.fromDelegate.transitionDidEnd()
            }
           
            animator.startAnimation()
            
        }
        
    }

    
}
