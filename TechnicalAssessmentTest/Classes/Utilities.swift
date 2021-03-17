//
//  Utilities.swift
//  TechnicalAssessmentTest
//
//  Created by Mihir Thakkar on 23/10/20.
//  Copyright © 2020 Mihir Thakkar. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD
import Toast
import RMUniversalAlert
import Firebase
import MaterialComponents.MaterialDialogs

class Utilities:NSObject{

    class func size(forText text: String?, font: UIFont?, withinWidth width: CGFloat) -> CGSize {
        let constraint = CGSize(width: width, height: 20000.0)
        var size: CGSize
        var boundingBox: CGSize? = nil
        if let font = font {
            boundingBox = text?.boundingRect(with: constraint, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [
            NSAttributedString.Key.font: font
        ], context: nil).size
        }

        size = CGSize(width: ceil(boundingBox!.width), height: ceil(boundingBox!.height))
        return size
    }
    
    class func getAspectSizeOfImage(imageSize: CGSize, widthToFit: Float) -> CGSize {
        var imageWidth = Float(imageSize.width)
        var imageHeight = Float(imageSize.height)

        var imgRatio = imageWidth / imageHeight

        let width_1 = widthToFit
        let height_1 = MAXFLOAT

        let maxRatio = width_1 / height_1

        if imgRatio != maxRatio {
            if imgRatio < maxRatio {
                imgRatio = height_1 / imageHeight
                imageWidth = imgRatio * imageWidth
                imageHeight = height_1
            } else {
                imgRatio = width_1 / imageWidth
                imageHeight = imgRatio * imageHeight
                imageWidth = width_1
            }
        }

        return CGSize(width: CGFloat(imageWidth), height: CGFloat(imageHeight))
    }
    

    class func getWidth(width : CGFloat) -> CGFloat
       {
           var current_Size : CGFloat = 0.0
           current_Size = (UIScreen.main.bounds.width/320)
           let FinalWidth : CGFloat = width * current_Size
           return FinalWidth
       }
       class func getHeight(height : CGFloat) -> CGFloat
       {
           var current_Size : CGFloat = 0.0
           current_Size = (UIScreen.main.bounds.height/568)
           let FinalHight : CGFloat = height * current_Size
           return FinalHight
       }
       
       class func dynamicFontSizeForIphone(fontSize : CGFloat) -> CGFloat
       {
           var current_Size : CGFloat = 0.0
           current_Size = (UIScreen.main.bounds.width/320)
           let FinalSize : CGFloat = fontSize * current_Size
           return FinalSize
       }
    
    
    class func isEmpty(_ str: String) -> Bool
     {
         var string_str : String  = str
         
         if (string_str as? NSNull) == NSNull() {
             return true
         }
         if string_str == nil {
             return true
         }
         else if string_str.count == 0 {
             return true
         }
         else {
             string_str = string_str.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
             if string_str.count == 0 {
                 return true
             }
         }
         
         if (string_str == "<null>") {
             return true
         }
         return false
    
     }
    class func showToastMessage(_ strMessage: String) {
    
        if !Utilities.isEmpty(strMessage) {
            CSToastManager.setQueueEnabled(false)
            appDelegate.window?.makeToast(strMessage)
            
            /*var messageQueue: RGMessageQueue!
                var presenter: RGMessageSnackBarPresenter?
            
            if let window = UIApplication.shared.keyWindow {
                        presenter = RGMessageSnackBarPresenter(view: window,
                                                               animation: RGMessageSnackBarAnimation.slideUp,
                                                               bottomMargin: 0.0,
                                                               sideMargins: 0.0,
                                                               cornerRadius: 0.0)
                presenter?.snackBarView.backgroundColor = Constants.color.colorPrimary
                        messageQueue = RGMessageQueue(presenter: presenter!)
                    } else {
                        messageQueue = RGMessageQueue(presenter: RGMessageSnackBarPresenter(view: (UIApplication.topViewController()?.view)!, animation: RGMessageSnackBarAnimation.slideUp))
                    }
            
          
            
            if let rgmessage = RGMessage(text: strMessage, image: nil, actions: nil, priority: .verbose, duration: .long) {
                        messageQueue.push(rgmessage)
                    }
            */
        }
    }
    
    class func showAlertMessage(_ strMessage: String) {
    
        if !Utilities.isEmpty(strMessage) {
            
            RMUniversalAlert.show(in: UIApplication.topViewController()!, withTitle: "Alert", message: strMessage, cancelButtonTitle: "OK", destructiveButtonTitle: nil, otherButtonTitles: nil) { (alert, index) in
            }
        }
    }
    
    class func showAlertMessage(_ title: String, message: String) {
    
        if !Utilities.isEmpty(message)
        {
            RMUniversalAlert.show(in: UIApplication.topViewController()!, withTitle: title, message: message, cancelButtonTitle: "OK", destructiveButtonTitle: nil, otherButtonTitles: nil) { (alert, index) in
            }
        }
    }
    
    class func run(after wait: TimeInterval, closure: @escaping () -> Void) {
        let queue = DispatchQueue.main
        queue.asyncAfter(deadline: DispatchTime.now() + wait, execute: closure)
    }
    
    class func showActivityIndicator()
    {
        SVProgressHUD.show()
    }

    class func hideActivityIndicator()
    {
        SVProgressHUD.dismiss()
    }
    
    class func showCustomActivityIndicator()
    {
        DispatchQueue.main.async {
            
        let loaderView : UIView = UIView ()
        loaderView.frame = CGRect(x: 0, y: 0, width: Utilities.getWidth(width: 320), height: Utilities.getHeight(height: 568))
        
        let imageWidth : CGFloat = Utilities.getWidth(width: 100)
        let imageHeight : CGFloat = Utilities.getWidth(width: 100)
        
        let imageView : UIImageView = UIImageView ()
        imageView.frame = CGRect(x: (Utilities.getWidth(width: 320) - imageWidth )/2, y: (Utilities.getHeight(height: 568) - imageHeight )/2, width: imageWidth, height: imageHeight)
        imageView.image = UIImage(named: "logo")!
        imageView.contentMode = .scaleAspectFit
        loaderView.addSubview(imageView)
        loaderView.backgroundColor = UIColor.color(string: "000000").withAlphaComponent(0.1)
        loaderView.tag = 012345
        loaderView.alpha = 0.0
        appDelegate.window?.addSubview(loaderView)
       
        animateLoader(imageView: imageView)
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveLinear, animations: {
            loaderView.alpha = 1.0
                }, completion: { finished in
                    
                })
        }
    }
    
    class func animateLoader(imageView : UIImageView)
    {
        DispatchQueue.main.async {
        if(imageView != nil)
        {
            UIView.animate(withDuration: 0.7, delay: 0.0, options: .curveLinear, animations: {
                imageView.layer.transform = CATransform3DMakeRotation(CGFloat(Double.pi / 2), 0.0, 1.0, 0.0);
                    }, completion: { finished in
                        UIView.animate(withDuration: 0.7, delay: 0.0, options: .curveLinear, animations: {
                            imageView.layer.transform = CATransform3DMakeRotation(0.0, 0.0, 1.0, 0.0);
                        }, completion: { finished in
                            animateLoader(imageView: imageView)
                        })
                    })
        }
        }
        
    }
    
    class func hideCustomActivityIndicator()
    {
        DispatchQueue.main.async {
            
            if let tempView : UIView = appDelegate.window?.viewWithTag(012345) {
            
                UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveLinear, animations: {
                    tempView.alpha = 0.0
                        }, completion: { finished in
                            run(after: 0.1) {
                                DispatchQueue.main.async {
                                tempView.removeFromSuperview()
                                }
                            }
                        })
                }
        }
    }
    
    class func trackScreenForGoogleAnalytics(screenName : String)
    {
        //Analytics.setScreenName(screenName, screenClass: screenName)
    }
}
