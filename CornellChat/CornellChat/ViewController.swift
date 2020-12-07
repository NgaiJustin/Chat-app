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
    let message1 = Message(id: "1", contents: "Hello", direction: .incoming)
    let message2 = Message(id: "2", contents: "Hi", direction: .outgoing)
    let message3 = Message(id: "3", contents: "How are you?", direction: .incoming)
    let message4 = Message(id: "4", contents: "I'm good, how are you?", direction: .outgoing)
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

        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 50
        }
    }

    // MARK: - Table view delegate
    extension ViewController: UITableViewDelegate {
    }



