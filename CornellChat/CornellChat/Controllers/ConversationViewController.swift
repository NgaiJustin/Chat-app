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

        setupConstraints()

        // Do any additional setup after loading the view.
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            writingField.topAnchor.constraint(equalTo: view.topAnchor),
            writingField.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            writingField.heightAnchor.constraint(equalToConstant: 20),
            writingField.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            messageView.topAnchor.constraint(equalTo: view.topAnchor),
            messageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            messageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            messageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
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
    
    
//        func messageView(_ messageView: UITableView, numberOfRowsInSection section: Int) -> Int {
//            return messages.count
//        }
//
//        func messageView(_ messageView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//            let cell = messageView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MessageTableViewCell
//            let message = messages[indexPath.row]
//            cell.configure(for: message)
//            return cell
//        }
        
        func messageView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 60
        }
    }



