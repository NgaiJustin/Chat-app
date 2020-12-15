//
//  MessageTableViewCell.swift
//  Pods
//
//  Created by Abby Levin on 12/7/20.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    var contentsLabel: UILabel!
    var timeStampLabel: UILabel!
    
    var recipient: User?
    let padding: CGFloat = 8
    let contentsLabelHeight: CGFloat = 16
    let timeStampLabelHeight: CGFloat = 14

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        contentView.backgroundColor = .black
        
        contentsLabel = UILabel()
        contentsLabel.numberOfLines = 0
        contentsLabel.textColor = .black
        contentsLabel.font = .systemFont(ofSize: 14)
        contentsLabel.translatesAutoresizingMaskIntoConstraints = false

        timeStampLabel = UILabel()
        timeStampLabel.textColor = .gray
        timeStampLabel.font = .systemFont(ofSize: 14)
        timeStampLabel.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(contentsLabel)
        contentView.addSubview(timeStampLabel)
        
        if recipient?.userId == User.current?.userId{
            contentsLabel.textAlignment = .left
            timeStampLabel.textAlignment = .left
            setupConstraintsIncoming()
        }
        else {
            contentsLabel.textAlignment = .right
            timeStampLabel.textAlignment = .right
            setupConstraintsOutgoing()}
    }
    
    func setupConstraintsIncoming() {
        NSLayoutConstraint.activate([
            contentsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            contentsLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            contentsLabel.heightAnchor.constraint(equalToConstant: contentsLabelHeight),
            contentsLabel.widthAnchor.constraint(equalToConstant: (contentView.width - 20))
            ])

        NSLayoutConstraint.activate([
            timeStampLabel.leadingAnchor.constraint(equalTo: contentsLabel.leadingAnchor),
            timeStampLabel.topAnchor.constraint(equalTo: contentsLabel.bottomAnchor, constant: padding),
            timeStampLabel.heightAnchor.constraint(equalToConstant: timeStampLabelHeight),
            timeStampLabel.widthAnchor.constraint(equalToConstant: (contentView.width - 20))
            ])
    }
    
    func setupConstraintsOutgoing() {
        NSLayoutConstraint.activate([
            contentsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            contentsLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            contentsLabel.heightAnchor.constraint(equalToConstant: contentsLabelHeight),
            contentsLabel.widthAnchor.constraint(equalToConstant: (contentView.width - 20))
            ])

        NSLayoutConstraint.activate([
            timeStampLabel.trailingAnchor.constraint(equalTo: contentsLabel.trailingAnchor),
            timeStampLabel.topAnchor.constraint(equalTo: contentsLabel.bottomAnchor, constant: padding),
            timeStampLabel.heightAnchor.constraint(equalToConstant: timeStampLabelHeight),
            timeStampLabel.widthAnchor.constraint(equalToConstant: (contentView.width - 20))
            ])
    }
    
    func configure (for message: Message){
        contentsLabel.text = message.contents
        timeStampLabel.text = message.time
        recipient = message.to
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
