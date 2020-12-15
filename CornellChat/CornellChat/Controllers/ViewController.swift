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
    var conversations = [Conversation]()
    
    //MARK: Fake Data Variables
    var user1: User!
    var user2: User!
    var user3: User!
    var user4: User!
    var message1A: Message!
    var message1B: Message!
    var message1C: Message!
    var message1D: Message!
    var message2A: Message!
    var message2B: Message!
    var message2C: Message!
    var message3A: Message!
    var message3B: Message!
    var message4A: Message!
    var message4B: Message!
    var message4C: Message!
    var message4D: Message!
    var message4E: Message!
    var convo1: Conversation!
    var convo2: Conversation!
    var convo3: Conversation!
    var convo4: Conversation!
//    var users: [User] = [User]()
    
    
    
    // MARK: Constants
    let reuseIdentifier = "ConversationTableViewCellReuse"
    
    // MARK: Fill-in Data
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        title = "Current Conversations"
        view.backgroundColor = .white
        
        //fake data
        user1 = User(userId: 1, username: "acl97", firstName: "Abby", lastName: "Levin", token: nil)
        user2 = User(userId: 2, username: "jn537", firstName: "Justin", lastName: "Ngai", token: nil)
        user3 = User(userId: 3, username: "ay934", firstName: "Aryan", lastName: "Yadav", token: nil)
        user4 = User(userId: 4, username: "hw424", firstName: "Austin", lastName: "Wu", token: nil)
//        users = [user1, user2, user3, user4]
        
        message1A = Message(id: 1, contents: "Hi, how are you?", to: User.current!, from: user1, time: "16:05")
        message1B = Message(id: 2, contents: "I'm good, how are you?", to: user1, from: User.current!, time: "19:06")
        message1C = Message(id: 3, contents: "I'm good! Do you want to get lunch sometime this week?", to: User.current!, from: user1, time: "16:10")
        message1D = Message(id: 4, contents: "Sure that sounds great!", to: user1, from: User.current!, time: "16:15")
        message2A = Message(id: 5, contents: "Hey", to: User.current!, from: user2, time: "18:15")
        message2B = Message(id: 6, contents: "What's up?", to: User.current!, from: user2, time: "18:15")
        message2C = Message(id: 7, contents: "Homework sadly", to: user2, from: User.current!, time: "18:20")
        message3A = Message(id: 8, contents: "What happens to a frog's car when it breaks down?", to: User.current!, from: user3, time: "19:02")
        message3B = Message(id: 9, contents: "It gets toad away!", to: User.current!, from: user3, time: "19:03")
        message4A = Message(id: 10, contents: "Hey what do you want for dinner tonight?", to: User.current!, from: user4, time: "19:15")
        message4B = Message(id: 11, contents: "Oooh can you get a pizza?", to: user4, from: User.current!, time: "19:16")
        message4C = Message(id: 12, contents: "Yeah sure what toppings do you want?", to: User.current!, from: user4, time: "19:18")
        message4D = Message(id: 13, contents: "Just pepperoni please! Thank you", to: user4, from: User.current!, time: "19:20")
        message4E = Message(id: 14, contents: "No problem", to: User.current!, from: user4, time: "19:25")

        convo1 = Conversation(id: 1, name: "\(user1.firstName!)  \(user1.lastName!)", messages: [message1A, message1B, message1C, message1D], recipient: user1)
        convo2 = Conversation(id: 2, name: "\(user2.firstName!)  \(user2.lastName!)", messages: [message2A, message2B, message2C], recipient: user2)
        convo3 = Conversation(id: 3, name: "\(user3.firstName!)  \(user3.lastName!)", messages: [message3A, message3B], recipient: user3)
        convo4 = Conversation(id: 4, name: "\(user4.firstName!)  \(user4.lastName!)", messages: [message4A, message4B, message4C, message4D, message4E], recipient: user4)
        
        conversations = [convo1, convo2, convo3, convo4]
        
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
        
//        register(username: "2", pw: "somepassword", first: "this", last: "that")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        validateAuth()
    }
    
    // Checks if user exists in Database
//    private func validateAuth(){
//        if FirebaseAuth.Auth.auth().currentUser == nil {
//            let vc = LoginViewController()
//            let n = UINavigationController(rootViewController: vc)
//            n.modalPresentationStyle = .fullScreen
//            present(n, animated: false)
//        }
//    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
//    func register(username: String, pw: String, first: String, last: String) {
//        return NetworkManager.signin(username: username, pw: pw, first: first, last: last, completion: { user in
//            self.dummyUser = user
//        })
//    }
    
    @objc func logOut(){
        let actionSheet = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: {
            [weak self] _ in
            
            guard let strongSelf = self else {
                return
            }
                User.current = nil
                let vc = LoginViewController()
                let n = UINavigationController(rootViewController: vc)
                n.modalPresentationStyle = .fullScreen
                strongSelf.present(n, animated: true)
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
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let conversation = conversations[indexPath.row]
        let vc = ConversationViewController( convoName: conversation.name, messages : conversation.messages, recipient : conversation.recipient)
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


