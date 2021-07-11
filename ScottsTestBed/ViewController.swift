//
//  ViewController.swift
//  ScottsTestBed
//
//  Created by Scott Kriss on 6/16/21.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKUIDelegate {
    var webView: WKWebView!
    private let refreshControl = UIRefreshControl()
    
    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadingDataAnimation()
        NetworkManager.shared.fetchData()
        NotificationCenter.default.addObserver(self, selector: #selector(dataFetched) , name: NetworkManager.dataParseComplete, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(dataFailed) , name: NetworkManager.dataParseFailed, object: nil)
        
        func loadingDataAnimation() {
            
            //*** small alert on load with blur background ***/
            let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = view.bounds
            let alert = UIAlertController(title: nil, message: "Gathering data...", preferredStyle: .alert)
            let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.style = UIActivityIndicatorView.Style.medium
            loadingIndicator.startAnimating()
            view.addSubview(blurEffectView)
            alert.view.addSubview(loadingIndicator)
            present(alert, animated: true, completion: nil)
            
        }
        
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 213/255, green: 220/255, blue: 232/255, alpha: 1)]
        refreshControl.tintColor = UIColor(red: 213/255, green: 220/255, blue: 232/255, alpha: 1)
        refreshControl.backgroundColor = UIColor(red: 120/255, green: 135/255, blue: 171/255, alpha: 1)
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh data ...", attributes: attributes)
        refreshControl.addTarget(self, action: #selector(refreshData), for: UIControl.Event.valueChanged)
        self.mainTableView.addSubview(refreshControl)
    }
    
    @objc func refreshData(sender:AnyObject) {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.refreshControl.beginRefreshing()
        }
        
        NetworkManager.shared.fetchData()
    }
    
    @objc func dataFetched() {
        print("Data has been fetched")
        //now that data is parsed, we can display it
        DispatchQueue.main.async {
            self.dismiss(animated: false, completion: nil)
            self.view.subviews.compactMap { $0 as? UIVisualEffectView }.forEach {
                $0.removeFromSuperview()
            }
            self.mainTableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    @objc func dataFailed() {
        DispatchQueue.main.async {
            //dismiss the alert
            self.dismiss(animated: false, completion: nil)
            
            //display the alert
            let alert = UIAlertController(title: "Error gathering data", message: "Please make sure you're connected to the internet and tap Try Again", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: { action in
                                            switch action.style{
                                            case .default:
                                                
                                                //remove the UIViews
                                                self.view.subviews.compactMap {  $0 as? UIVisualEffectView }.forEach {
                                                    $0.removeFromSuperview()
                                                }
                                                
                                                //initiate the refreshdata call and start the animation
                                                self.refreshData(sender: AnyObject.self as AnyObject)
                                                //                                                self.loadingDataAnimation()
                                                
                                                print("default")
                                                
                                            case .cancel:
                                                print("cancel")
                                                
                                            case .destructive:
                                                print("destructive")
                                                
                                            }}))
            self.present(alert, animated: true, completion: nil)
        }
        
        self.mainTableView.reloadData()
        self.refreshControl.endRefreshing()
    }
}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let dataPointCount = NetworkManager.shared.breeds?.data.count else { return 5 }
        return dataPointCount
        //        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as? MainTableViewCell else {
            return UITableViewCell()
        }
        //        if indexPath.row % 2 == 0 {
        //            cell.contentView.backgroundColor = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1)
        //        }
        
        let dataPoint = NetworkManager.shared.breeds?.data
        
        if let breedName = dataPoint?[indexPath.row].breed {
            cell.breedNameLbl.text = breedName
        }
        
        return cell
    }
}
