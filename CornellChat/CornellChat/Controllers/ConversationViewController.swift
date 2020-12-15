//
//  ConversationViewController.swift
//  Pods
//
//  Created by Abby Levin on 12/7/20.
//

import UIKit

class ConversationViewController: UIViewController {
    
    var convoName: String!
    var messages: [Message]
    var recipient: User
    var messageView: UITableView!
    var writingField: UITextField!
    var sendButton: UIButton!
    
    
    let reuseIdentifier = "messageCellReuse"
    
    init(convoName: String, messages: [Message], recipient: User){
        self.convoName = convoName
        self.recipient = recipient
        self.messages = messages
        self.messageView = UITableView()
        self.writingField = UITextField()
        self.sendButton = UIButton()
//        self.scrollView = UIScrollView()
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = convoName
        
//        scrollView.clipsToBounds = true
//        view.addSubview(scrollView)
        
        messageView.translatesAutoresizingMaskIntoConstraints = false
        messageView.register(MessageTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        messageView.delegate = self
        messageView.dataSource = self
        view.addSubview(messageView)
//        scrollView.addSubview(messageView)
        
//        let img = UIImage(named: "sendbutton2.jpg")!.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0),
//            resizingMode: .stretch)
        sendButton.setImage(UIImage(named: "sendbutton2.jpg"), for: UIControl.State.normal)
//        sendButton.backgroundColor = .red
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.addTarget(self, action: #selector (sendButtonTapped), for: .touchUpInside)
        sendButton.layer.cornerRadius = 15
        sendButton.layer.masksToBounds = true
        view.addSubview(sendButton)
        
        writingField.translatesAutoresizingMaskIntoConstraints = false
        writingField.placeholder = "message..."
        writingField.backgroundColor = .white
        writingField.borderStyle = .roundedRect
        writingField.layer.cornerRadius = 12
        writingField.layer.borderWidth = 1
        writingField.layer.borderColor = UIColor.red.cgColor
        view.addSubview(writingField)
        
//        let buttonView = UIView(frame: CGRect(x: 55, y: 15, width: 30, height: 30))
//        buttonView.addSubview(sendButton)
//        writingField.rightView = buttonView
//        writingField.rightViewMode = .always
//        scrollView.addSubview(writingField)
        
        
        //viewDidLayoutSubviews()
        

        setupConstraintsConversation()
        
        

        // Do any additional setup after loading the view.
    }
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        scrollView.frame = view.bounds
//
//        writingField.frame = CGRect(x: 10,
//                                    y: -30,
//                                  width: scrollView.width - 20,
//                                  height: 50)
//        messageView.frame = CGRect(x: scrollView.width / 2,
//                                   y: (scrollView.height - 30) / 2,
//                                   width: scrollView.width - 20,
//                                   height: 70)
//    }
    
    
    func setupConstraintsConversation() {
        NSLayoutConstraint.activate([
            writingField.widthAnchor.constraint(equalToConstant: view.width - 70),
            writingField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            writingField.heightAnchor.constraint(equalToConstant: 50),
            writingField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            messageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            messageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            messageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            messageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
            ])
        
        NSLayoutConstraint.activate([
            sendButton.topAnchor.constraint(equalTo: writingField.topAnchor, constant: 5),
            sendButton.widthAnchor.constraint(equalToConstant: 40),
            sendButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            sendButton.bottomAnchor.constraint(equalTo: writingField.bottomAnchor, constant: -5)
            ])
        }
    
    @objc private func sendButtonTapped(){
        if writingField.text != "" {
            let date = Date()
            let calendar = Calendar.current
            let hour = calendar.component(.hour, from: date)
            let minutes = calendar.component(.minute, from: date)
            let time1 = String(hour) + ":" + String(minutes)
            messages.append(Message(
                                id: 5,
                                contents: writingField.text!,
                                to: self.recipient,
                                from: User.current!,
                                time: time1))
            writingField.text = ""
            messageView.reloadData()
            }

    }

}
    
extension ConversationViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = messageView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MessageTableViewCell
        let message = messages[indexPath.row]
        cell.configure(for: message)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    
    
//
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
//
//        func messageView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//            return 60
//        }
   }



