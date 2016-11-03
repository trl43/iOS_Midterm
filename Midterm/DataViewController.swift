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


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let dlabel = self.dataLabel else {
            print("ERROR: The dataLabel is nil")
            return
        }
        dlabel.text = dataObject
    }


}

