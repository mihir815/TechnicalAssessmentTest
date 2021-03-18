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

class DashboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate, UISearchBarDelegate
{
    var postDataArray : NSMutableArray! = NSMutableArray()
    var filteredArray : NSMutableArray! = NSMutableArray()
    
    
    // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "cell"

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
        self.navigationItem.title = "Posts"
        
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
        
        let apiURL = Constants.environment.current.BASE_URL + Constants.API.posts
      
        var headers: HTTPHeaders = []
        headers.add(name: "Accept", value: "*/*")
        
        AFWrapper.requestGET(apiURL, params: nil, headers: headers, success: { (statusCode, responseJson) in
            
            Utilities.hideActivityIndicator()
            
            self.postDataArray.removeAllObjects()
            self.filteredArray.removeAllObjects()
            
            if(statusCode == 200)
            {
                var finalArray:[Any] = []
                
                print("Here response \(responseJson)")
                
                let responseArray = responseJson.array! as NSArray
                
                for post in responseArray
                {
                    let tempObject = JSON(post)
                   
                    let tempPostModel : PostDataModel = PostDataModel()
                    tempPostModel.userId = tempObject["userId"].intValue
                    tempPostModel.id = tempObject["id"].intValue
                    tempPostModel.title = tempObject["title"].stringValue
                    tempPostModel.body = tempObject["body"].stringValue
                    
                    print("tempPostModel.id \(tempPostModel.id) ==> \(tempPostModel.body!)")
                    finalArray.append(tempPostModel)
                }
                
                if (finalArray.count > 0)
                {
                    let sortedArray = finalArray.sorted
                    {
                        ($0 as! PostDataModel).id < ($1 as! PostDataModel).id
                     }
                    self.postDataArray.addObjects(from: sortedArray)
                    self.filteredArray.addObjects(from: sortedArray)
                    self.initializeSearch()
                }
                self.tableView.emptyDataSetSource = self
                self.tableView.emptyDataSetDelegate = self
                self.tableView.reloadData()
                self.tableView.reloadEmptyDataSet()
            }
            else
            {
                Utilities.hideActivityIndicator()
                Utilities.showAlertMessage(Constants.messages.unknownError)
            }
            
        }) { (error) in
            Utilities.hideActivityIndicator()
            Utilities.showAlertMessage(Constants.messages.unknownError)
        }
    }

    func initializeSearch()
    {
        let searchBar = UISearchBar()
        searchBar.frame = CGRect(x: 0, y: 0, width: Utilities.getWidth(width: 320), height: Utilities.getHeight(height: 44))
        searchBar.delegate = self
        searchBar.showsCancelButton = false
        searchBar.searchBarStyle = .default
        searchBar.placeholder = "Search a post here..."
        
        self.tableView.tableHeaderView = searchBar
    }
    
    // MARK: -
    // MARK: SearchBar Delegate / DataSource Methods
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let searchString = searchText.removeExtraSpaces()
        print(searchString)
            
        if(searchString.length > 0)
        {
            let tempFilteredArray = self.postDataArray.filter { ($0 as! PostDataModel).title.localizedCaseInsensitiveContains(searchString) }
            
            self.filteredArray.removeAllObjects()
            self.filteredArray.addObjects(from: tempFilteredArray)
        }
        else
        {
            self.filteredArray.removeAllObjects()
            self.filteredArray.addObjects(from: self.postDataArray as! [Any])
        }
        
        self.tableView.reloadData()
        self.tableView.reloadEmptyDataSet()
    }
    
    private func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredArray.count
    }

    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell:UITableViewCell = UITableViewCell(style: .subtitle,
                                                   reuseIdentifier: cellReuseIdentifier)
        
        let tempPostModel : PostDataModel = self.filteredArray.object(at: indexPath.row) as! PostDataModel
        
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString?
    {
        let txt = "Posts"
        
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

