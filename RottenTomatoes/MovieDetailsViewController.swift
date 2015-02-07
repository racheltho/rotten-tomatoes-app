//
//  MovieDetailsViewController.swift
//  RottenTomatoes
//
//  Created by Rachel Thomas on 2/3/15.
//  Copyright (c) 2015 Rachel Thomas. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    var movieDictionary: NSDictionary?
    
    @IBOutlet weak var MovieTitle: UILabel!
    
    @IBOutlet weak var MovieDescription: UILabel!
    
    @IBOutlet weak var MovieImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        if let movieDictionary = self.movieDictionary? {
            MovieTitle.text = movieDictionary["title"] as NSString
            MovieDescription.text = movieDictionary["synopsis"] as NSString
            var posters_dict = movieDictionary["posters"] as NSDictionary
            var thumbnail = posters_dict["thumbnail"]! as NSString
            var high_res = thumbnail.stringByReplacingOccurrencesOfString("tmb", withString: "ori")
            MovieImage.setImageWithURL(NSURL(string: high_res))
        }
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
