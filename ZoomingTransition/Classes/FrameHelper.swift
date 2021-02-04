//
//  FrameHelper.swift
//  ZoomingTransition
//
//  Created by Desong on 2021/2/4.
//

import UIKit
public class FrameHelper {
    
   

   public class func getTargerFrame(originalView:UIView,targetView:UIView)->CGRect?{
       
        guard let targetFrame = originalView.superview?.convert(originalView.frame, to: targetView) else {
            return nil
        }
        return targetFrame
    }
    public class func getScreenshot(with view: UIView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        defer { UIGraphicsEndImageContext() }
        if let context = UIGraphicsGetCurrentContext() {
            view.layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            return image
        }
        return nil
    }
    
}
