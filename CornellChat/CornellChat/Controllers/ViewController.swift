//
//  ViewController.swift
//  CornellChat
//
//  Created by Justin Ngai on 6/12/2020.
//

import UIKit

class ViewController: UIViewController {

    // MARK: UI components
    var tableView: UITableView!

    // MARK: Data variables
    // var user: User
    var conversations = [Conversation]()

    // MARK: Constants
    let reuseIdentifier = "ConversationTableViewCellReuse"

    // MARK: Fill-in Data
    // messages
    let message1 = Message(id: "1", contents: "Hello", direction: .incoming, time: "1:25 pm")
    let message2 = Message(id: "2", contents: "Hi", direction: .outgoing, time: "1:26 pm")
    let message3 = Message(id: "3", contents: "How are you?", direction: .incoming, time: "2:01 pm")
    let message4 = Message(id: "4", contents: "I'm good, how are you?", direction: .outgoing, time: "2:12 pm")
    var messages = [Message]()
    
    //recipients
    let sampleUser = Recipient(imageName: "none", id: "1234", username: "sampleuser123")
    
    //conversations
    //    let sampleConversation = Conversation(id: "conversation1", name: "John Smith", messages: [message1, message2, message3, message4], recipient: sampleUser)
    
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

        setupConstraints()
        
        // Hard coding stuff for now
        let sampleConversation = Conversation(id: "conversation1", name: "John Smith", messages: [message1, message2, message3, message4], recipient: sampleUser)
        conversations = [sampleConversation, sampleConversation, sampleConversation]
    
        //        getConvo() won't work until we have the endpoint
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let isLoggedIn = UserDefaults.standard.bool(forKey: "logged_in")
        
        if !isLoggedIn {
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

    func getConvo() {
        NetworkManager.getConvo()
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
        let vc = ConversationViewController( convoName: conversation.recipient.username, messages : conversation.messages)
        navigationController?.pushViewController(vc, animated: true)
    }
}


