//
//  ViewController.swift
//  CornellChat
//
//  Created by Justin Ngai on 6/12/2020.
//

import UIKit
import FirebaseAuth

protocol AddNewConvoDelegate: class {
    func addConvo(newConvo: Conversation?)
}

class ViewController: UIViewController{
    
    // MARK: UI components
    var tableView: UITableView!
    var addButton: UIBarButtonItem!
    var logOutButton: UIBarButtonItem!
    
    // MARK: Data variables
    // var user: User
    var conversations = [Conversation]()
    

    // MARK: Constants
    let reuseIdentifier = "ConversationTableViewCellReuse"

    // MARK: Fill-in Data
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        title = "Current Conversations"
        view.backgroundColor = .white

        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ConversationTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.addSubview(tableView)
        
        addButton = UIBarButtonItem(title: "New", style: .plain, target: self, action: #selector (newConvoViewController))
        navigationItem.rightBarButtonItems = [addButton]
        
        logOutButton = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector (logOut))
        navigationItem.leftBarButtonItems = [logOutButton]

        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        validateAuth()
    }
    
    // Checks if user exists in Database
    private func validateAuth(){
        if FirebaseAuth.Auth.auth().currentUser == nil {
            let vc = LoginViewController()
            let n = UINavigationController(rootViewController: vc)
            n.modalPresentationStyle = .fullScreen
            present(n, animated: false)
        }
    }

    func setupConstraints() {
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
        }

//    func getConvo() {
//        NetworkManager.getConvo()
//    }
    
    @objc func logOut(){
        let actionSheet = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: {
            [weak self] _ in
            
            guard let strongSelf = self else {
                return
            }
            do {
                try FirebaseAuth.Auth.auth().signOut()
                let vc = LoginViewController()
                let n = UINavigationController(rootViewController: vc)
                n.modalPresentationStyle = .fullScreen
                strongSelf.present(n, animated: true)
            } catch {
                print ("Umm....")
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(actionSheet, animated: true)
    }
    
    @objc func newConvoViewController() {
        let vc = AddConvoViewController(delegate: self)
        present(vc, animated: true, completion: nil)
    }

}

    // MARK: - Table view data source
    extension ViewController: UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return conversations.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ConversationTableViewCell
            cell.configure(for: conversations[indexPath.row])
            return cell
        }

    }

    // MARK: - Table view delegate
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let conversation = conversations[indexPath.row]
        let vc = ConversationViewController( convoName: conversation.name, messages : conversation.messages)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ViewController: AddNewConvoDelegate{
    
    func addConvo(newConvo: Conversation?){
        if newConvo != nil {
            conversations.append(newConvo!)}
        tableView.reloadData()
    }
}


