//
//  ViewController.swift
//  todoDiary
//
//  Created by Jooeun Kim on 2022/03/03.
//

import UIKit
import Firebase



class ViewController: UIViewController {

    var handle: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener { auth, user in
            dump("auth:\(auth.description)//// user: \(user)")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle!)
    }

    @IBAction func goNewAccount(_ sender: UIButton) {
        performSegue(withIdentifier: "NewAccount", sender: nil)
        
    }
    
    @IBAction func goLoginAccount(_ sender: UIButton) {
        performSegue(withIdentifier: "LogIn", sender: nil)
        
    }
    
    
}

