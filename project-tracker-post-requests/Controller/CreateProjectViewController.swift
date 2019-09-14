//
//  CreateProjectViewController.swift
//  project-tracker-post-requests
//
//  Created by albert coelho oliveira on 9/12/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class CreateProjectViewController: UIViewController {

    @IBOutlet weak var inputTextName: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var createButton: UIButton!
    
    @IBAction func buttonAction(_ sender: UIButton) {
        guard let project = createProjectFromFields()
            else {
return
        }
        ProjectAPIClient.manager.postProject(project: project) { result in
            switch result{
            case .success(let success):
                self.navigationController?.popViewController(animated: true)
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func createProjectFromFields () -> Project?{
        guard let name = inputTextName.text else {
            return nil
        }
        return Project(name: name, dueDate: formAirTableData(date: datePicker.date ))
    }
    private func formAirTableData (date: Date)-> String{
        return date.description.components(separatedBy: .whitespaces)[0]
    }
}
