//
//  ConversationViewController.swift
//  Pods
//
//  Created by Abby Levin on 12/7/20.
//

import UIKit

class ConversationViewController: UIViewController {
    
    var convoName: String
    var messages: [Message]
    var messageView: UITableView
    var writingField: UITextField
    
    let reuseIdentifier = "messageCellReuse"
    
    init(convoName: String, messages: [Message]){
        self.convoName = convoName
        self.messages = messages
        self.messageView = UITableView()
        self.writingField = UITextField()
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        title = convoName
        
        messageView = UITableView()
        messageView.translatesAutoresizingMaskIntoConstraints = false
        messageView.register(ConversationTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.addSubview(messageView)
        
        writingField = UITextField()
        writingField.translatesAutoresizingMaskIntoConstraints = false
        writingField.placeholder = "message..."
        writingField.backgroundColor = .blue
        writingField.borderStyle = .roundedRect
        view.addSubview(writingField)
        

        setupConstraintsConversation()

        // Do any additional setup after loading the view.
    }
    func setupConstraintsConversation() {
        NSLayoutConstraint.activate([
            writingField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            writingField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            writingField.heightAnchor.constraint(equalToConstant: 50),
            writingField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            messageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            messageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            messageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            messageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
            ])
        }
    

}
    
extension ConversationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = messageView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MessageTableViewCell
        let message = messages[indexPath.row]
        cell.configure(for: message)
        return cell
    }
    
    
        func messageView(_ messageView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return messages.count
        }

        func messageView(_ messageView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = messageView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MessageTableViewCell
            let message = messages[indexPath.row]
            cell.configure(for: message)
            return cell
        }
        
        func messageView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 60
        }
    }



