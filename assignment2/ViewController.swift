//
//  ViewController.swift
//  assignment2
//
//  Created by Ashley Whamond on 27/4/17.
//  Copyright © 2017 Deakin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        MainHeader.layer.shadowColor = UIColor.black.cgColor
        MainHeader.layer.shadowOpacity = 1
        MainHeader.layer.shadowOffset = CGSize.zero
        MainHeader.layer.shadowRadius = 3
        
        for button in MainMenu{
            button.layer.borderColor = UIColor.black.cgColor
            button.layer.borderWidth = 0.5
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBOutlet weak var MainHeader: UIImageView!
    @IBOutlet var MainMenu: [UIButton]!
    
    @IBAction func segueBack(sender : UIStoryboardSegue) {
        
    }

    

}

