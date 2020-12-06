//
//  ViewController.swift
//  CornellChat
//
//  Created by Justin Ngai on 6/12/2020.
//

import UIKit

class ViewController: UIViewController {

    // MARK: UI components
    var tableView: UITableView!

    // MARK: Data variables
    var courses = [Course]()

    // MARK: Constants
    let reuseIdentifier = "ClassTableViewCellReuse"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Course Shopping Cart"
        view.backgroundColor = .white

        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(tableView)

        setupConstraints()
        getCourses()
    }

    func setupConstraints() {
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
        }

    // TODO: How do we make a call to the internet to load our shopping cart?
    func getCourses() {

    }

}

    // MARK: - Table view data source
    extension ViewController: UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return courses.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! CoursesTableViewCell
            cell.configure(for: courses[indexPath.row])
            return cell
        }

        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 50
        }
    }

    // MARK: - Table view delegate
    extension ViewController: UITableViewDelegate {
        // Why is there nothing here?
    }



