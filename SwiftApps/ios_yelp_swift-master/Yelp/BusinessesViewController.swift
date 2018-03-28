//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchBarItem: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var isMoreDataLoading = false
    var businesses: [Business]!
    
    var filteredData: [Business]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        navigationItem.titleView = searchBarItem
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        // needs to use rowHeight with conjunction witht he method below
        tableView.estimatedRowHeight = 120
       self.navigationController?.navigationBar.barTintColor = UIColor.red
        Business.searchWithTerm(term: "Thai", completion: { (businesses: [Business]?, error: Error?) -> Void in
            
            self.businesses = businesses
            self.filteredData = businesses
            self.tableView.reloadData()
          //  if let businesses = businesses {
           //     for business in businesses {
            //        print(business.name!)
          //          print(business.address!)
           //     }
           // }
            
            }
        )
        
        
        
        /* Example of Yelp search with more search options specified
         Business.searchWithTerm("Restaurants", sort: .distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: Error!) -> Void in
         self.businesses = businesses
         
         for business in businesses {
         print(business.name!)
         print(business.address!)
         }
         }
         */
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !isMoreDataLoading {
           // print("reached scrollViewDidScroll")
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            
            if(scrollView.contentOffset.y > scrollOffsetThreshold && tableView.isDragging) {
                isMoreDataLoading = true
                loadMoreData()
            }
        }
    }
    
    func loadMoreData() {
        print("Reached loadMoreData")
        let urlPath = "https://api.yelp.com/v3/businesses/"
        let url = URL(string: urlPath)
        let request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        //let request1: NSURLRequest = NSURLRequest(url)
        // Configure session so that completion handler is executed on main UI thread
        print("Calling URLsession")
        let session = URLSession(configuration: URLSessionConfiguration.default,
                                 delegate:nil,
                                 delegateQueue:OperationQueue.main
        )
        let task : URLSessionDataTask = session.dataTask(with: request, completionHandler: { (data, response, error) in
            
            // Update flag
            self.isMoreDataLoading = false
            
            // ... Use the new data to update the data source ...
            print("Printing out the data source")
            print(type(of: data!) )
            print(data! ?? "Nothing is here")
            // Reload the tableView now that there is new data
            self.tableView.reloadData()
        })
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredData != nil {
            return filteredData.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath) as! BusinessCell
        
        cell.business = filteredData[indexPath.row]
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = searchText.isEmpty ? businesses : businesses.filter{(item: Business)-> Bool in
            return item.name?.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
          tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Reached prepare for segue")
        let cell = sender as! BusinessCell
        if let indexPath = tableView.indexPath(for: cell){
            let business = filteredData[indexPath.row]
            let detailViewController = segue.destination as! BusinessViewController
            detailViewController.business = business
        }
    }// sending data to another view controller
  
    
}
