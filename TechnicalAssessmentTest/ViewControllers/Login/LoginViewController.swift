//
//  ViewController.swift
//  TechnicalAssessmentTest
//
//  Created by Mihir Thakkar on 15/03/21.
//

import UIKit
import MaterialComponents.MaterialButtons
import SkyFloatingLabelTextField
import Alamofire
import SwiftyUserDefaults
import SwiftyJSON
import Firebase

class LoginViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate
{
    @IBOutlet weak var scrollView: UIScrollView!
    
    var imgLogo: UIImageView!
    var txtEmail: SkyFloatingLabelTextField!
    var txtPassword: SkyFloatingLabelTextField!
    var btnSubmit: MDCButton!
    var btnForgotPassword: MDCButton!
   
    var y_position : CGFloat = 0
    
    // MARK: -
    // MARK: Controller Lifecycle Methods
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        y_position = Utilities.getHeight(height: 140)
        
        addEmail()
        addPassword()
        addSubmitButton()
        
        self.checkLoginValidations()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
        
        UIApplication.shared.statusBarStyle = .lightContent
       
        Utilities.trackScreenForGoogleAnalytics(screenName: Constants.GoogleAnalytics.Login)
        
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.tintColor = UIColor.white
        navigationBar?.setNavigationBarProperties(navigationBar: navigationBar!)
        self.navigationItem.title = "Login"
        
        txtEmail.text = ""
        txtPassword.text = ""
    }
    
    // MARK: -
    // MARK: Screen UI Design
    
    func addEmail()
    {
        let tempView = UIView(frame: CGRect(x: Utilities.getWidth(width: 20), y: y_position, width: Utilities.getWidth(width: 280), height: Utilities.getHeight(height: 40)))
        
        let leftView1 = UIView(frame: CGRect(x: 0, y: 0, width: Utilities.getWidth(width: 30), height: Utilities.getHeight(height: 40)))
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: Utilities.getWidth(width: 15), height: leftView1.frame.size.height));
        imageView.contentMode = .scaleAspectFit
        
        imageView.image = UIImage(named: "username");
        leftView1.addSubview(imageView)

        tempView.addSubview(leftView1)

        txtEmail = SkyFloatingLabelTextField()
    
        txtEmail.tintColor = Constants.color.colorPrimary // the color of the blinking cursor
        txtEmail.textColor = Constants.color.colorPrimary
        txtEmail.delegate = self
        txtEmail.lineColor = Constants.color.colorEditTextLine
        txtEmail.selectedTitleColor = Constants.color.colorPrimary
        txtEmail.selectedLineColor = Constants.color.colorPrimary
        txtEmail.lineHeight = 1.0 // bottom line height in points
        txtEmail.selectedLineHeight = 1.0
        
        txtEmail.keyboardType = .emailAddress
        txtEmail.delegate = self
        txtEmail.frame = CGRect(x: Utilities.getWidth(width: 30), y: 0, width: Utilities.getWidth(width: 250), height: Utilities.getHeight(height: 40))
        txtEmail.placeholder = "Email"
        txtEmail.title = "Email"
        
       // txtEmail.addBottomBorder(color: Constants.color.colorEditTextLine)
        txtEmail.textColor = Constants.color.colorPrimary
        
        txtEmail.font = UIFont.systemFont(ofSize: Utilities.dynamicFontSizeForIphone(fontSize: 12))
        
        tempView.addSubview(txtEmail)
        scrollView.addSubview(tempView)
        
        y_position = tempView.frame.origin.y + tempView.frame.size.height + Utilities.getHeight(height: 10)
        
        scrollView.contentSize = CGSize(width: self.scrollView.frame.size.width, height: y_position)
    }
    
    func addPassword()
    {
        let tempView = UIView(frame: CGRect(x: Utilities.getWidth(width: 20), y: y_position, width: Utilities.getWidth(width: 280), height: Utilities.getHeight(height: 40)))
        
        let leftView1 = UIView(frame: CGRect(x: 0, y: 0, width: Utilities.getWidth(width: 30), height: Utilities.getHeight(height: 40)))
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: Utilities.getWidth(width: 15), height: leftView1.frame.size.height));
        imageView.contentMode = .scaleAspectFit
        
        imageView.image = UIImage(named: "password_icon");
        leftView1.addSubview(imageView)

        tempView.addSubview(leftView1)
        
        txtPassword = SkyFloatingLabelTextField()
        txtPassword.tintColor = Constants.color.colorPrimary // the color of the blinking cursor
        txtPassword.textColor = Constants.color.colorPrimary
        txtPassword.delegate = self
        txtPassword.lineColor = Constants.color.colorEditTextLine
        txtPassword.selectedTitleColor = Constants.color.colorPrimary
        txtPassword.selectedLineColor = Constants.color.colorPrimary

        txtPassword.lineHeight = 1.0 // bottom line height in points
        txtPassword.selectedLineHeight = 1.0
        txtPassword.isSecureTextEntry = true
        txtPassword.delegate = self
        txtPassword.frame = CGRect(x: Utilities.getWidth(width: 30), y: 0, width: Utilities.getWidth(width: 250), height: Utilities.getHeight(height: 40))
        txtPassword.placeholder = "Password"
        txtPassword.title = "Password"
        
        //txtPassword.addBottomBorder(color: Constants.color.colorEditTextLine)
        txtPassword.textColor = Constants.color.colorPrimary
        
        txtPassword.font = UIFont.systemFont(ofSize: Utilities.dynamicFontSizeForIphone(fontSize: 12))
        
        tempView.addSubview(txtPassword)
        scrollView.addSubview(tempView)
        
        y_position = tempView.frame.origin.y + tempView.frame.size.height + Utilities.getHeight(height: 30)
        
        scrollView.contentSize = CGSize(width: self.scrollView.frame.size.width, height: y_position)
    }
    
    func addSubmitButton()
    {
        btnSubmit = MDCButton()
        btnSubmit.frame = CGRect(x: Utilities.getWidth(width: 20), y: y_position, width: Utilities.getWidth(width: 280), height: Utilities.getHeight(height: 45))
        btnSubmit.setTitle("LOGIN", for: .normal)
        btnSubmit.setTitleColor(.white)
        btnSubmit.setBackgroundColor(Constants.color.colorButtonGreen)
        
        btnSubmit.setTitleFont(UIFont.boldSystemFont(ofSize: Utilities.dynamicFontSizeForIphone(fontSize: 16)), for: .normal)
        btnSubmit.isUppercaseTitle = true
        btnSubmit.addTarget(self, action: #selector(onClickSubmit), for: .touchUpInside)
        btnSubmit.layer.cornerRadius = Utilities.getWidth(width: 4)
        
        scrollView.addSubview(btnSubmit)
        
        y_position = btnSubmit.frame.origin.y + btnSubmit.frame.size.height + Utilities.getHeight(height: 15)
        
        scrollView.contentSize = CGSize(width: self.scrollView.frame.size.width, height: y_position)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if let text = textField.text as NSString?
        {
            let txtAfterUpdate = text.replacingCharacters(in: range, with: string)
            print("txtAfterUpdate ==> \(txtAfterUpdate)")
            
            Utilities.run(after: 0.1) {
                self.checkLoginValidations()
            }
        }
        return true
    }
    
    func checkLoginValidations()
    {
        if(txtEmail.text?.isEmpty == false && txtPassword.text?.isEmpty == false)
        {
            if (txtEmail.text?.isEmail() == true)
            {
                let passwordString = txtPassword.text
                
                if (passwordString!.length >= 8 && passwordString!.length <= 15)
                {
                    btnSubmit.isEnabled = true
                    return
                }
            }
        }
        btnSubmit.isEnabled = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    
     @objc func onClickSubmit()
     {
        self.view.endEditing(true)
        Defaults[\.isLogin] = true
        
        let tabViewController = appDelegate.myStoryboard.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController

        self.navigationController?.pushViewController(tabViewController, animated: false)
     }
}

