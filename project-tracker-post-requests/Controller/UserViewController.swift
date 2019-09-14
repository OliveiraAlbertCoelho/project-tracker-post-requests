//
//  UserViewController.swift
//  project-tracker-post-requests
//
//  Created by albert coelho oliveira on 9/13/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
    var user = [LogoWrapper](){
        didSet{
            userTable.reloadData()
        }
    }
    @IBOutlet weak var userTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        userTable.delegate = self
        userTable.dataSource = self
     
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadData()
    }
    private func loadData() {
        UserApi.manager.getUser { result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case let .success(projects):
                    self?.user = projects
                case let .failure(error):
                    self?.displayErrorAlert(with: error)
                }
            }
        }
        
    }
    
    private func displayErrorAlert(with error: AppError) {
        let alertVC = UIAlertController(title: "Error Fetching Data", message: "\(error)", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    

}
extension UserViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userTable.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as? MyUserTableViewCell
        let users = user[indexPath.row]
        if let url = users.logo?[indexPath.row].url{
            print("yo")
            if let newURl = URL(string: url){
                print("no")
            ImageHelper.shared.fetchImage(urlString: newURl) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success(let image):
                        print("j")
                     cell?.userImage.image = image
                    }}}
            }}
        cell?.userNameText.text = users.Name
        print(users.logo?)
        cell?.userDescripText.text = users.About
        
        return cell!
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}
