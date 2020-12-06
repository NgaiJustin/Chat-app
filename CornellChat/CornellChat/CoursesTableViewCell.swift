//
//  CoursesTableViewCell.swift
//  CornellChat
//
//  Created by Justin Ngai on 6/12/2020.
//

import UIKit

class CoursesTableViewCell: UITableViewCell {

    var nameLabel: UILabel!
    var courseNumberLabel: UILabel!
    var instructorLabel: UILabel!

    let padding: CGFloat = 8
    let nameLabelHeight: CGFloat = 16
    let instructorLabelHeight: CGFloat = 14

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        nameLabel = UILabel()
        nameLabel.textColor = .black
        nameLabel.font = .systemFont(ofSize: 14)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        instructorLabel = UILabel()
        instructorLabel.textColor = .gray
        instructorLabel.font = .systemFont(ofSize: 12)
        instructorLabel.translatesAutoresizingMaskIntoConstraints = false

        courseNumberLabel = UILabel()
        courseNumberLabel.textColor = .gray
        courseNumberLabel.font = .systemFont(ofSize: 14)
        courseNumberLabel.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(nameLabel)
        contentView.addSubview(instructorLabel)
        contentView.addSubview(courseNumberLabel)

        setupConstraints()
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            nameLabel.heightAnchor.constraint(equalToConstant: nameLabelHeight)
            ])

        NSLayoutConstraint.activate([
            courseNumberLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: padding),
            courseNumberLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            courseNumberLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor),
            courseNumberLabel.heightAnchor.constraint(equalToConstant: nameLabelHeight)
            ])

        NSLayoutConstraint.activate([
            instructorLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            instructorLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: padding),
            instructorLabel.heightAnchor.constraint(equalToConstant: instructorLabelHeight)
            ])
    }

    func configure(for course: Course) {
        nameLabel.text = course.name
        courseNumberLabel.text = "(CS \(course.code))"
        instructorLabel.text = course.instructor

        // Cool way of doing an if else statement in one line
        contentView.backgroundColor = course.enrolled ? UIColor.green.withAlphaComponent(0.1) : UIColor.red.withAlphaComponent(0.1)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
