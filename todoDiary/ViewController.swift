//
//  ViewController.swift
//  todoDiary
//
//  Created by Jooeun Kim on 2022/03/03.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func goNewAccount(_ sender: UIButton) {
        performSegue(withIdentifier: "NewAccount", sender: nil)
        
    }
    
}

