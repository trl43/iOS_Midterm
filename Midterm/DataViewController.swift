//
//  DataViewController.swift
//  Midterm
//
//  Created by Locker,Todd (TRL43) on 11/2/16.
//  Copyright © 2016 Locker,Todd. All rights reserved.
//

import UIKit

class DataViewController: UIViewController {

    @IBOutlet weak var dataLabel: UILabel?
    var dataObject: String = ""
    @IBOutlet weak var innerLabel: UILabel?
    var textData: String = ""

    // This is called immediately after the view successfully loads
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    // This is called right before the view appears. This is where the label's text is actually set.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Guard added by TRL43
        guard let dLabel = self.dataLabel else {
            print("ERROR: Could not unwrap the dataLabel")
            return
        }
        
        // Guard added by TRL43
        guard let iLabel = self.innerLabel else {
            print("ERROR: Could not unwrap the innerLabel")
            return
        }
        
        dLabel.text = dataObject
        iLabel.text = textData
    }
}

