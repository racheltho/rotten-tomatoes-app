//
//  ViewController.swift
//  RottenTomatoes
///Users/racheltho/Downloads/winter_ios_intro_week_1_part_2.mov
//  Created by Rachel Thomas on 2/2/15.
//  Copyright (c) 2015 Rachel Thomas. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var moviesArray: NSArray!
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let RottenTomatoesURLString = "http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=9ecrem4ahjdfjncrzxrqy9qj"
        let request = NSMutableURLRequest(URL: NSURL(string:RottenTomatoesURLString)!)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: { (response, data, error) in
            var errorValue: NSError? = nil
            let dictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &errorValue) as NSDictionary
            self.moviesArray = dictionary["movies"] as NSArray
            self.tableView.reloadData()
        })
        
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
        
        let imagerequest = NSMutableURLRequest(URL: NSURL(string:thumbnail)!)
        
        NSURLConnection.sendAsynchronousRequest(imagerequest, queue: NSOperationQueue.mainQueue(), completionHandler: { (response, data, error) in
            var errorValue: NSError? = nil
            println(data)
            cell.movieImage.image = UIImage(data: data)
            
        })
        
        
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let details = MovieDetailsViewController()
        let movie = self.moviesArray![indexPath.row] as NSDictionary
        details.movieDictionary = movie
        self.navigationController?.pushViewController(details, animated: true)
    }
}

