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
    var direction: Direction?
    
    let padding: CGFloat = 8
    let contentsLabelHeight: CGFloat = 16
    let timeStampLabelHeight: CGFloat = 14

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        contentView.backgroundColor = .black
        direction = nil
        
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
        
        if case .incoming = direction {
            setupConstraintsIncoming()
        }
        else {setupConstraintsOutgoing()}
    }
    
    func setupConstraintsIncoming() {
        NSLayoutConstraint.activate([
            contentsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
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
            contentsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentsLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            contentsLabel.heightAnchor.constraint(equalToConstant: contentsLabelHeight),
            contentsLabel.widthAnchor.constraint(equalToConstant: (contentView.width - 200))
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
//        direction = message.direction
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
