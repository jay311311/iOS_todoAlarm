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
                print("uid = \(authResult?.user.uid) && email = \(authResult?.user.email)&& ")

                guard let todoVC = self?.storyboard?.instantiateViewController(withIdentifier: "TodoView") as? TodoController else { return }
                    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(todoVC, animated: false)
            }else{
               
                    print("\(error?.localizedDescription)")
                
            }
            }
       
          // ...
        
    }
    
}
