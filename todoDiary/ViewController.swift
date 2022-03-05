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
    
    }
    
    override func viewWillDisappear(_ animated: Bool) {
       // Auth.auth().removeStateDidChangeListener(handle!)
    }

    @IBAction func goNewAccount(_ sender: UIButton) {
        performSegue(withIdentifier: "NewAccount", sender: nil)
        
    }
    
    @IBAction func goLoginAccount(_ sender: UIButton) {
        performSegue(withIdentifier: "LogIn", sender: nil)
        
    }
    
    
}

