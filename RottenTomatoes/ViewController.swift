//
//  ViewController.swift
//  RottenTomatoes
///Users/racheltho/Downloads/winter_ios_intro_week_1_part_2.mov
//  Created by Rachel Thomas on 2/2/15.
//  Copyright (c) 2015 Rachel Thomas. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let RottenTomatoesURLString = "http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=9ecrem4ahjdfjncrzxrqy9qj"
        let request = NSMutableURLRequest(URL: NSURL(string:RottenTomatoesURLString)!)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: { (response, data, error) in
            var errorValue: NSError? = nil
            let dictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &errorValue) as NSDictionary
        })
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        return 10
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("moviecell") as MovieTableViewCell
        cell.movieTitleLabel.text = "Row: \(indexPath.row)"
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        NSLog("Did tap row: \(indexPath.row)")
    }
}

