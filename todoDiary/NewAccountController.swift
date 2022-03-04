//
//  NewAccountController.swift
//  todoDiary
//
//  Created by Jooeun Kim on 2022/03/04.
//

import UIKit
import Firebase


class NewAccountController: UIViewController {

    @IBOutlet weak var TextFieldBox: UIView!
    
    @IBOutlet weak var IdTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var NameTextField: UITextField!
    
    @IBOutlet weak var signUpBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TextFieldBox.layer.cornerRadius=30
     
        signUpBtn.addTarget(self, action: #selector(touchSignup), for: .touchUpInside)
    }
    
   

    
    
    @objc func touchSignup(){
        guard let email =  IdTextField.text, let password =  PasswordTextField.text  else {
           return  print("정보를 빠짐없이 기입해 주세요")
        }
        
        Auth.auth().createUser(withEmail:email, password: password) { authResult, error in
            if authResult != nil {
                print("signup success")
            }else{
                print("signup fail---> \(error?.localizedDescription)")

            }
        }
    }
    


}

struct User {
    
}
