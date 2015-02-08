//
//  MovieTableView.swift
//  RottenTomatoes
//
//  Created by Rachel Thomas on 2/7/15.
//  Copyright (c) 2015 Rachel Thomas. All rights reserved.
//

import UIKit

class MovieTableView: UIViewController, UITableViewDataSource {
    
    var pullRefreshControl: UIRefreshControl!
    var moviesArray: NSArray!
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var errorView: UIView!
    
    
    func makeRottenTomatoesRequest(){
        let RottenTomatoesURLString = "http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=9ecrem4ahjdfjncrzxrqy9qj"
        let request = NSMutableURLRequest(URL: NSURL(string:RottenTomatoesURLString)!)
        
        SVProgressHUD.showProgress(0.4, status: "Loading")
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: { (response, data, error) in
            if (error != nil) {
                self.errorView.hidden = false
            } else {
                self.errorView.hidden = true
                println(self.errorView.frame.height)
                var errorValue: NSError? = nil
                println("request returned")
                let dictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &errorValue) as NSDictionary
                self.moviesArray = dictionary["movies"] as NSArray
                self.tableView.reloadData()
            }
            SVProgressHUD.dismiss()
        })
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.errorView.hidden = true
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        makeRottenTomatoesRequest()
        pullRefreshControl = UIRefreshControl()
        pullRefreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(pullRefreshControl, atIndex: 0)
    }
    
    func onRefresh() {
        makeRottenTomatoesRequest()
        self.pullRefreshControl.endRefreshing()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        if let array = moviesArray {
            return array.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let movie = self.moviesArray![indexPath.row] as NSDictionary
        let cell = tableView.dequeueReusableCellWithIdentifier("moviecell") as MovieTableViewCell
        cell.movieTitleLabel.text = movie["title"] as NSString
        var posters_dict = movie["posters"] as NSDictionary
        var thumbnail = posters_dict["thumbnail"] as NSString
        //var high_res = thumbnail.stringByReplacingOccurrencesOfString("tmb", withString: "ori")
        cell.movieImage.setImageWithURL(NSURL(string: thumbnail))
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "detailsSegue" {
            let cell = sender as MovieTableViewCell
            if let indexPath = tableView.indexPathForCell(cell) {
                let detailsController = segue.destinationViewController as MovieDetailsViewController
                detailsController.movieDictionary = self.moviesArray![indexPath.row] as? NSDictionary
                tableView.deselectRowAtIndexPath(indexPath, animated: true)
            }
        }
    }
    
}


