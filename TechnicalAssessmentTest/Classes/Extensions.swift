//
//  Extensions.swift
//  TechnicalAssessmentTest
//
//  Created by Mihir Thakkar on 23/10/20.
//  Copyright © 2020 Mihir Thakkar. All rights reserved.
//

import Foundation
import UIKit
import MaterialComponents.MaterialButtons
import SwiftyUserDefaults
import SwiftyJSON

extension UINavigationBar{

    func setNavigationBarProperties(navigationBar:UINavigationBar){
      
        navigationBar.isTranslucent = false
        navigationBar.isOpaque = true
        navigationBar.barTintColor = Constants.color.colorPrimary
        navigationBar.tintColor = UIColor.color(string: "#ffffff")
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.color(string: "#ffffff") , NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18.0)]
       //navigationBar.setValue(false, forKey: "hidesShadow")
    }

}
extension UIDevice {
    var iPhoneX: Bool {
        return UIScreen.main.bounds.height >= 812
    }
}
extension MDCButton{
    
    func addButtonProperties(button:MDCButton , title:String , radius:CGFloat , bgColor:UIColor , titleColor:UIColor,fontSize:CGFloat){
        
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor)
        button.setBackgroundColor(bgColor)
        button.setTitleFont(UIFont.systemFont(ofSize: Utilities.dynamicFontSizeForIphone(fontSize: fontSize)), for: .normal)
        button.isUppercaseTitle = false
        
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.textAlignment = .justified
        button.layer.cornerRadius = Utilities.getWidth(width: radius)
        button.layer.shadowRadius = 4.0
        button.layer.shadowColor = Constants.color.colorPrimary.cgColor
        button.layer.shadowOpacity = 0.3
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.layer.masksToBounds = true
        
        button.clipsToBounds = false
        
    }
    
    func underline() {
            guard let text = self.titleLabel?.text else { return }
            let attributedString = NSMutableAttributedString(string: text)
            //NSAttributedStringKey.foregroundColor : UIColor.blue
            attributedString.addAttribute(NSAttributedString.Key.underlineColor, value: self.titleColor(for: .normal)!, range: NSRange(location: 0, length: text.count))
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: self.titleColor(for: .normal)!, range: NSRange(location: 0, length: text.count))
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: text.count))
            self.setAttributedTitle(attributedString, for: .normal)
        }
    
    
}
extension UITextField {
    func setLeftPadding(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: Utilities.getWidth(width: amount), height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPadding(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: Utilities.getWidth(width: amount), height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }

    func addBottomBorder(color : UIColor){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
        bottomLine.backgroundColor = color.cgColor
        borderStyle = .none
        layer.addSublayer(bottomLine)
    }
}

extension UITextView{
    func addBottomBorder(color : UIColor){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
        bottomLine.backgroundColor = color.cgColor
        layer.addSublayer(bottomLine)
    }
}

extension UIView{
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
          
          if #available(iOS 11.0, *) {
              clipsToBounds = true
              layer.cornerRadius = Utilities.getWidth(width:radius)
              layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
          } else {
              let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: Utilities.getWidth(width:radius), height: Utilities.getHeight(height:radius)))
              let mask = CAShapeLayer()
              mask.path = path.cgPath
              layer.mask = mask
          }
    
      }
    func addShadowView(width:CGFloat=0.7, height:CGFloat=0.7, Opacidade:Float=0.5, maskToBounds:Bool=false, radius:CGFloat=0.5){
        self.layer.shadowColor = UIColor.black.withAlphaComponent(0.8).cgColor
         self.layer.shadowOffset = CGSize(width: width, height: height)
         self.layer.shadowRadius = radius
         self.layer.shadowOpacity = Opacidade
         self.layer.masksToBounds = maskToBounds
    }
    
    
}
extension String{
    
    var length: Int {
        return count
    }
    
    var validEmail:Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    var validatePhone:Bool {
        let phone_RegEx = "^\\d{3}\\d{3}\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phone_RegEx)
        return phoneTest.evaluate(with: self)
    }
    
    var inValidName:Bool {
          let name_RegEx = ".*[^A-Za-z ].*"
          let nameTest = NSPredicate(format: "SELF MATCHES %@", name_RegEx)
          return nameTest.evaluate(with: self)
    }
}

extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
    
    
}

extension DefaultsKeys {
    var isLogin: DefaultsKey<Bool?> { .init("isLogin") }
}

extension Notification.Name {
    
}

extension Sequence {
    func group<GroupingType: Hashable>(by key: (Iterator.Element) -> GroupingType) -> [[Iterator.Element]] {
        var groups: [GroupingType: [Iterator.Element]] = [:]
        var groupsOrder: [GroupingType] = []
        forEach { element in
            let key = key(element)
            if case nil = groups[key]?.append(element) {
                groups[key] = [element]
                groupsOrder.append(key)
            }
        }
        return groupsOrder.map { groups[$0]! }
    }
}

extension CGPoint {
    
    func isInsidePolygon(vertices: [CGPoint]) -> Bool {
        guard vertices.count > 0 else { return false }
        var i = 0, j = vertices.count - 1, c = false, vi: CGPoint, vj: CGPoint
        while true {
            guard i < vertices.count else { break }
            vi = vertices[i]
            vj = vertices[j]
            if (vi.y > y) != (vj.y > y) &&
                x < (vj.x - vi.x) * (y - vi.y) / (vj.y - vi.y) + vi.x {
                c = !c
            }
            j = i
            i += 1
        }
        return c
    }
}

extension Date {

    // Convert local time to UTC (or GMT)
    func toGlobalTime() -> Date {
        let timezone = TimeZone.current
        let seconds = -TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }

    // Convert UTC (or GMT) to local time
    func toLocalTime() -> Date {
        let timezone = TimeZone.current
        let seconds = TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }

}

