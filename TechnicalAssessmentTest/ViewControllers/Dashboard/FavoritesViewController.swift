//
//  ViewController.swift
//  TechnicalAssessmentTest
//
//  Created by Mihir Thakkar on 15/03/21.
//

import UIKit
import SwiftyUserDefaults
import Alamofire
import SwiftyJSON
import DZNEmptyDataSet

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate
{
    var postDataArray : NSMutableArray! = NSMutableArray()
    
    // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "cell"

    private var viewModel: DashboardViewModel = DashboardViewModel()
    
    // don't forget to hook this up from the storyboard
    @IBOutlet var tableView: UITableView!

    // MARK: -
    // MARK: Controller Lifecycle Methods
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Register the table view cell class and its reuse id
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)

        // (optional) include this line if you want to remove the extra empty cell divider lines
        // self.tableView.tableFooterView = UIView()

        // This view controller itself will provide the delegate methods and row data for the table view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.tableFooterView = UIView()

        self.getPostDataFromAPI()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
        
        UIApplication.shared.statusBarStyle = .lightContent
       
        Utilities.trackScreenForGoogleAnalytics(screenName: Constants.GoogleAnalytics.Dashboard)
        
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.tintColor = UIColor.white
        navigationBar?.setNavigationBarProperties(navigationBar: navigationBar!)
        self.navigationItem.title = "Favorites"
        
        let rightBarButton = UIBarButtonItem()
        rightBarButton.target = self
        rightBarButton.action = #selector(onClickLogout)
        rightBarButton.title = "Logout"
        rightBarButton.style = .done
        rightBarButton.tintColor = Constants.color.colorWhite
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        self.navigationItem.hidesBackButton = true
    }
    
    // MARK: -
    // MARK: API Methods
    
    func getPostDataFromAPI()
    {
        print("getPostDataFromAPI")
        
        Utilities.showActivityIndicator()
        
        viewModel.fetch { [weak self] in
            Utilities.hideActivityIndicator()
            
            if(self?.viewModel.error == nil)
            {
                if(self?.viewModel.items.count != 0)
                {
                    self?.postDataArray.addObjects(from: self?.viewModel.items as! [Any])
                }
                self?.tableView.emptyDataSetSource = self
                self?.tableView.emptyDataSetDelegate = self
                self?.tableView.reloadData()
                self?.tableView.reloadEmptyDataSet()
            }
            else{
                Utilities.showAlertMessage(Constants.messages.unknownError)
            }
        }
    }

    private func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.postDataArray.count
    }

    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell:UITableViewCell = UITableViewCell(style: .subtitle,
                                                   reuseIdentifier: cellReuseIdentifier)
        
        let tempPostModel : PostDataModel = self.postDataArray.object(at: indexPath.row) as! PostDataModel
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = Constants.color.colorPrimary.withAlphaComponent(0.2)
        cell.selectedBackgroundView = bgColorView
        
        // set the text from the data model
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.textLabel?.text = tempPostModel.title
        
        cell.detailTextLabel?.numberOfLines = 0
        cell.detailTextLabel?.lineBreakMode = .byWordWrapping
        cell.detailTextLabel?.text = tempPostModel.body
        
        return cell
    }

    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString?
    {
        let txt = "Favorites"
        
        let attrs1 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: Utilities.dynamicFontSizeForIphone(fontSize: 16.0)) , NSAttributedString.Key.foregroundColor : Constants.color.colorPrimary]
        let attributedString1 = NSMutableAttributedString(string:"\(txt)", attributes:attrs1 as [NSAttributedString.Key : Any])
        return attributedString1
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let txt = "No record(s) found."
        
        let attrs1 = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: Utilities.dynamicFontSizeForIphone(fontSize: 12.0)) , NSAttributedString.Key.foregroundColor : UIColor.black]
        let attributedString1 = NSMutableAttributedString(string:"\(txt)", attributes:attrs1 as [NSAttributedString.Key : Any])
        return attributedString1
    }
    
    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView) -> Bool
    {
        return true
    }
    
    // MARK: -
    // MARK: Buttons Click Events
    
    @objc func onClickLogout()
    {
        Defaults[\.isLogin] = false
        
        let viewController =  appDelegate.myStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        let navigationController = UINavigationController(rootViewController: viewController)
        appDelegate.window?.rootViewController = navigationController
    }
}

