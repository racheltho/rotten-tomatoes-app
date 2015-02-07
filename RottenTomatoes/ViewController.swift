//
//  ViewController.swift
//  RottenTomatoes
///Users/racheltho/Downloads/winter_ios_intro_week_1_part_2.mov
//  Created by Rachel Thomas on 2/2/15.
//  Copyright (c) 2015 Rachel Thomas. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var pullRefreshControl: UIRefreshControl!
    var moviesArray: NSArray!
    
    @IBOutlet weak var errorView: UIView!
    
    
    func makeRottenTomatoesRequest(){
        let RottenTomatoesURLString = "http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=9ecrem4ahjdfjncrzxrqy9qj"
        let request = NSMutableURLRequest(URL: NSURL(string:RottenTomatoesURLString)!)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: { (response, data, error) in
            if (error != nil) {
                println(error)
                self.errorView.hidden = false
            } else {
                var errorValue: NSError? = nil
                println("request returned")
                let dictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &errorValue) as NSDictionary
                self.moviesArray = dictionary["movies"] as NSArray
                self.tableView.reloadData()
            }
        })
        
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
    
    override func tableView(tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        if let array = moviesArray {
            return array.count
        } else {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
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

