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
    
    let padding: CGFloat = 8
    let contentsLabelHeight: CGFloat = 16
    let timeStampLabelHeight: CGFloat = 14

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentsLabel = UILabel()
        contentsLabel.textColor = .black
        contentsLabel.font = .systemFont(ofSize: 14)
        contentsLabel.translatesAutoresizingMaskIntoConstraints = false

        timeStampLabel = UILabel()
        timeStampLabel.textColor = .gray
        timeStampLabel.font = .systemFont(ofSize: 14)
        timeStampLabel.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(contentsLabel)
        contentView.addSubview(timeStampLabel)

        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            contentsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentsLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            contentsLabel.heightAnchor.constraint(equalToConstant: contentsLabelHeight)
            ])

        NSLayoutConstraint.activate([
            timeStampLabel.leadingAnchor.constraint(equalTo: contentsLabel.leadingAnchor),
            timeStampLabel.topAnchor.constraint(equalTo: contentsLabel.bottomAnchor, constant: padding),
            timeStampLabel.heightAnchor.constraint(equalToConstant: timeStampLabelHeight)
            ])
    }
    
    func configure (for message: Message){
        contentsLabel.text = message.contents
        timeStampLabel.text = message.time
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
