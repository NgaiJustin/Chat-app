//
//  AddConvoViewController.swift
//  CornellChat
//
//  Created by Abby Levin on 12/13/20.
//

import UIKit

class AddConvoViewController: UIViewController {
    weak var delegate: AddNewConvoDelegate?
    
    var label: UILabel!
    var button1: UIButton!
    var backbutton: UIButton!
    var textField1: UITextField!
    var image: UIImageView!
    
    init(delegate: AddNewConvoDelegate?) {
        super.init(nibName: nil, bundle: nil)
        
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        label = UILabel()
        label.text = "Add New Conversation"
        label.backgroundColor = .clear
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        view.addSubview(label)
        
        image = UIImageView()
        image.image = UIImage(named: "cornellcartoon.jpg")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 12
        view.addSubview(image)
        
        textField1 = UITextField()
        textField1.translatesAutoresizingMaskIntoConstraints = false
        textField1.placeholder = "NetId"
        textField1.borderStyle = .roundedRect
        textField1.backgroundColor = .white
        textField1.textAlignment = .center
        textField1.clearsOnBeginEditing = true
        textField1.layer.cornerRadius = 12
        textField1.layer.borderWidth = 1
        textField1.layer.borderColor = UIColor.lightGray.cgColor
        view.addSubview(textField1)
        
        button1 = UIButton()
        button1.translatesAutoresizingMaskIntoConstraints = false
        button1.setTitle("Start Conversation", for: .normal)
        button1.setTitleColor(.white, for: .normal)
        button1.backgroundColor = .lightGray
        button1.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        button1.addTarget(self, action: #selector (addConvoAndDismissViewController), for: .touchUpInside)
        
        // Prettify
        button1.layer.cornerRadius = 12
        button1.layer.masksToBounds = true
        
        view.addSubview(button1)
        
        backbutton = UIButton()
        backbutton.translatesAutoresizingMaskIntoConstraints = false
        backbutton.setTitle("Back", for: .normal)
        backbutton.setTitleColor(.white, for: .normal)
        backbutton.backgroundColor = .lightGray
        backbutton.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        backbutton.addTarget(self, action: #selector (dismissViewController), for: .touchUpInside)
        
        // Prettify
        backbutton.layer.cornerRadius = 12
        backbutton.layer.masksToBounds = true
        
        view.addSubview(backbutton)
        
        setupConstraints()
        // Do any additional setup after loading the view.
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            label.heightAnchor.constraint(equalToConstant: 45)
            ])
        
        NSLayoutConstraint.activate([
            image.bottomAnchor.constraint(equalTo: textField1.topAnchor, constant: -90),
            image.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            image.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            image.heightAnchor.constraint(equalToConstant: 200)
            ])
        
        NSLayoutConstraint.activate([
            textField1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.height/2),
            textField1.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            textField1.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            textField1.heightAnchor.constraint(equalToConstant: 40)
            ])
        
        NSLayoutConstraint.activate([
            button1.topAnchor.constraint(equalTo: textField1.bottomAnchor, constant: 50),
            button1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button1.heightAnchor.constraint(equalToConstant: 48),
            button1.widthAnchor.constraint(equalToConstant: 300)
            
        ])
        
        NSLayoutConstraint.activate([
            backbutton.topAnchor.constraint(equalTo: button1.bottomAnchor, constant: 25),
            backbutton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backbutton.heightAnchor.constraint(equalToConstant: 48),
            backbutton.widthAnchor.constraint(equalToConstant: 100)
            
        ])
        
    }

    @objc func dismissViewController() {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    @objc func addConvoAndDismissViewController(){
        if textField1.text != "" {
            //check if it is a valid netID and add the real info
            delegate?.addConvo(newConvo: Conversation(id: "12345", name: "Abby Levin", messages: [], recipient: Recipient(imageName: "none", id: "jfkdjfkd", username: textField1.text!)))
            navigationController?.popViewController(animated: true)
            dismiss(animated: true, completion: nil)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
