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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func loadView() {
        let myView = UIView(frame: CGRectZero)
        myView.backgroundColor = UIColor.greenColor()
        self.view = myView
    }

}
