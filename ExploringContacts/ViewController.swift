//
//  ViewController.swift
//  ExploringContacts
//
//  Created by Nishant Taneja on 13/10/21.
//

import UIKit
import Contacts
import ContactsUI

struct Person {
    let name: String
    let id: String
    let source: CNContact
}

class ViewController: UITableViewController {
    
    // MARK: Properties
    
    private let cellIdentifier = "default_cell"
    
    private var persons = [Person]()
    
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tableView.backgroundColor = .systemBackground
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        let addContactButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAddContact(button:)))
        navigationItem.setRightBarButton(addContactButton, animated: true)
        title = "Contacts"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
}


// MARK: - UITableView

extension ViewController {
    
    // MARK: DataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        persons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = persons[indexPath.row].name
        return cell
    }
    
    
    // MARK: Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let contact = persons[indexPath.row].source
        let contactVC = CNContactViewController(for: contact)
        present(UINavigationController(rootViewController: contactVC), animated: true)
    }
    
}
 

// MARK: - CNContactPicker

extension ViewController: CNContactPickerDelegate {
    
    @objc private func handleAddContact(button: UIBarButtonItem) {
        let contactPickerVC = CNContactPickerViewController()
        contactPickerVC.delegate = self
        present(contactPickerVC, animated: true)
    }
    
    
    // MARK: Delegate
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        print(#function)
    }
    
//    func contactPicker(_ picker: CNContactPickerViewController, didSelect contacts: [CNContact]) {
//        print(#function, contacts)
//    }

    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        print(#function, contact)
        let person = Person(name: contact.givenName + " " + contact.familyName, id: contact.identifier, source: contact)
        persons.append(person)
        tableView.reloadData()
    }

//    func contactPicker(_ picker: CNContactPickerViewController, didSelect contactProperty: CNContactProperty) {
//        print(#function, contactProperty)
//    }

//    func contactPicker(_ picker: CNContactPickerViewController, didSelectContactProperties contactProperties: [CNContactProperty]) {
//        print(#function, contactProperties)
//    }
    
}
