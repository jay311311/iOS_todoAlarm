//
//  LogInController.swift
//  todoDiary
//
//  Created by Jooeun Kim on 2022/03/04.
//

import UIKit
import Firebase

class LogInController: UIViewController {

    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func clickLoginBtn(_ sender: UIButton) {
       
        guard let email = idTextField.text, let password = passwordTextField.text else { return  }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
          guard let strongSelf = self else { return }
            
            
            if authResult != nil{
                self?.performSegue(withIdentifier: "TodoView", sender: nil)
            }
            print("로그인결과----->\(authResult)")
          // ...
        }
    }
    
}
