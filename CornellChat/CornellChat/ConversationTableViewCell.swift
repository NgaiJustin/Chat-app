//
//  ConversationTableViewCell.swift
//  CornellChat
//
//  Created by Abby Levin on 12/6/20.
//

import UIKit

class ConversationTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpConstraints() {
        
    }
    
    func configure (for conversation: Conversation){
        
    }


}
