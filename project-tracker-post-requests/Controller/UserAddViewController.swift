//
//  UserAddViewController.swift
//  project-tracker-post-requests
//
//  Created by albert coelho oliveira on 9/13/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class UserAddViewController: UIViewController {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var UserDescripTextField: UITextField!
    @IBOutlet weak var userButtonOut: UIButton!
    @IBAction func userButton(_ sender: UIButton) {
        
        userButtonOut.isEnabled = false
        guard let userInfo = createUserFromFields()
            else {
                return
        }
        UserApi.manager.postUser(project: userInfo) { result in
            switch result{
            case .success(_):
                self.navigationController?.popViewController(animated: true)
            case .failure(let error):
                print(error)
            }
            
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    private func createUserFromFields () -> LogoWrapper?{
        guard let name = userNameTextField.text else {
            return nil
        }
        guard let descrip = UserDescripTextField.text else {
            return nil
        }
        return LogoWrapper(About: name, Name: descrip, logo: nil)
    }
}
