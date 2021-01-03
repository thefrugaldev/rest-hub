//
//  ViewController.swift
//  RESThub
//
//  Created by Clayton Orman on 1/3/21.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var feedTableView: UITableView!
    
    // MARK: Variables
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func createNewGist(_ sender: UIButton) {
    }
    
    // MARK: Utilities
    func showResultAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        
        self.present(alertController, animated: true, completion: nil)
    }
}

// MARK: UITableView Delegate & DataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCellID", for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let starAction = UIContextualAction(style: .normal, title: "Star") { (action, view, completion) in
            
            // TODO: PUT a gist star
            completion(true)
        }
        
        let unstarAction = UIContextualAction(style: .normal, title: "Unstar") { (action, view, completion) in
            
            // TODO: DELETE a gist star
            completion(true)
        }
        
        starAction.backgroundColor = .blue
        unstarAction.backgroundColor = .darkGray
        
        let actionConfig = UISwipeActionsConfiguration(actions: [starAction, unstarAction])
        
        return actionConfig
    }
}