//
//  ConversationTableViewCell.swift
//  CornellChat
//
//  Created by Abby Levin on 12/6/20.
//

import UIKit

class ConversationTableViewCell: UITableViewCell {
    
//    var otherPersonImageView: UIImageView!
    var otherPersonNameLabel: UILabel!
    var convoPreviewLabel: UILabel!
    var timeStampLabel: UILabel!
    
    let padding: CGFloat = 8
    let nameLabelHeight: CGFloat = 20
    let previewLabelHeight: CGFloat = 15

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        otherPersonNameLabel = UILabel()
        otherPersonNameLabel.textColor = .black
        otherPersonNameLabel.font = .systemFont(ofSize: 20, weight: .bold)
        otherPersonNameLabel.translatesAutoresizingMaskIntoConstraints = false

        convoPreviewLabel = UILabel()
        convoPreviewLabel.textColor = .gray
        convoPreviewLabel.font = .systemFont(ofSize: 15)
        convoPreviewLabel.translatesAutoresizingMaskIntoConstraints = false

        timeStampLabel = UILabel()
        timeStampLabel.textColor = .gray
        timeStampLabel.font = .systemFont(ofSize: 15)
        timeStampLabel.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(otherPersonNameLabel)
        contentView.addSubview(convoPreviewLabel)
        contentView.addSubview(timeStampLabel)

        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            otherPersonNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            otherPersonNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            otherPersonNameLabel.heightAnchor.constraint(equalToConstant: nameLabelHeight)
            ])

        NSLayoutConstraint.activate([
            convoPreviewLabel.leadingAnchor.constraint(equalTo: otherPersonNameLabel.trailingAnchor, constant: padding),
            convoPreviewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            convoPreviewLabel.topAnchor.constraint(equalTo: otherPersonNameLabel.topAnchor),
            convoPreviewLabel.heightAnchor.constraint(equalToConstant: nameLabelHeight)
            ])

        NSLayoutConstraint.activate([
            timeStampLabel.leadingAnchor.constraint(equalTo: otherPersonNameLabel.leadingAnchor, constant: padding),
            timeStampLabel.topAnchor.constraint(equalTo: otherPersonNameLabel.bottomAnchor, constant: padding),
            timeStampLabel.heightAnchor.constraint(equalToConstant: previewLabelHeight)
            ])
    }
    
    func configure (for conversation: Conversation){
        otherPersonNameLabel.text = conversation.name
        convoPreviewLabel.text = conversation.messages.last?.contents
        timeStampLabel.text = conversation.messages.last?.time
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
