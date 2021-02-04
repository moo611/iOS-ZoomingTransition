//
//  ZoomingPopTransition.swift
//  ZoomingTransition
//
//  Created by Desong on 2021/2/4.
//

import UIKit
@available(iOS 10.0,*)
public class ZoomingPopTransition: NSObject,UIViewControllerAnimatedTransitioning {
    fileprivate let toDelegate: ZoomTransitionAnimatorDelegate
    fileprivate let fromDelegate: ZoomTransitionAnimatorDelegate

   
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
        toDelegate: Any,
        fromDelegate: Any
        ) {
        guard let toDelegate = toDelegate as? ZoomTransitionAnimatorDelegate else {
            return nil
        }
        guard let fromDelegate = fromDelegate as? ZoomTransitionAnimatorDelegate else {
            return nil
        }
        self.toDelegate = toDelegate
        self.fromDelegate = fromDelegate
    }

    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }

    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromView = transitionContext.view(forKey: .from)
        let toView = transitionContext.view(forKey: .to)
        //let toVCTabBar = transitionContext.viewController(forKey: .to)?.locketTabBarController
        let containerView = transitionContext.containerView
        let fromReferenceFrame = fromDelegate.imageFrame()!

        let transitionImage = fromDelegate.referenceImage()
        transitionImageView.image = transitionImage
        transitionImageView.frame = fromDelegate.imageFrame()!

        [toView, fromView]
            .compactMap { $0 }
            .forEach { containerView.addSubview($0) }
        containerView.addSubview(transitionImageView)

        //self.photoDetailVC.transitionWillStart()
        self.toDelegate.transitionWillStart()

        let duration = self.transitionDuration(using: transitionContext)
        let spring: CGFloat = 0.9
        let animator = UIViewPropertyAnimator(duration: duration, dampingRatio: spring) {
            fromView?.alpha = 0
        }
        animator.addCompletion { (position) in
            assert(position == .end)

            self.transitionImageView.removeFromSuperview()
            self.transitionImageView.image = nil
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            self.toDelegate.transitionDidEnd()
            //self.photoDetailVC.transitionDidEnd()
        }
        //toVCTabBar?.setTabBar(hidden: false, animated: true, alongside: animator)
        animator.startAnimation()

       
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.005) {
            animator.addAnimations {
                let toReferenceFrame = self.toDelegate.imageFrame() ??
                    ZoomingPopTransition.defaultOffscreenFrameForDismissal(
                        transitionImageSize: fromReferenceFrame.size,
                        screenHeight: containerView.bounds.height
                )
                self.transitionImageView.frame = toReferenceFrame
            }
        }
    }

    
    public static func defaultOffscreenFrameForDismissal(
        transitionImageSize: CGSize,
        screenHeight: CGFloat
    ) -> CGRect {
        return CGRect(
            x: 0,
            y: screenHeight,
            width: transitionImageSize.width,
            height: transitionImageSize.height
        )
    }
}
