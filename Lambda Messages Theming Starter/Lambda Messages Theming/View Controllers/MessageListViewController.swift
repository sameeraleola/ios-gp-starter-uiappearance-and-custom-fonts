//
//  MessageListViewController.swift
//  UIAppearanceAndAnimation
//
//  Created by Spencer Curtis on 8/20/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class MessageListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(sortMessageArray), name: messagesWereUpdatedNotification, object: nil)
        
        messageController.fetchMessages()
        
        setupAppearances()
    }
    
    private func setupAppearances() {
        view.backgroundColor = AppearanceHelper.backgroundGray
        tableView.backgroundColor = AppearanceHelper.backgroundGray
        tableView.tableHeaderView?.backgroundColor = AppearanceHelper.backgroundGray
        
        AppearanceHelper.style(button: newMessageButton)
        newMessageButton.layer.cornerRadius = newMessageButton.frame.size.width / 2
        newMessageButton.titleLabel!.font = UIFont.systemFont(ofSize: 15)  // The picture on the button is a system emoji.  This is styling the size of it
    }
    
    private func style(cell: UITableViewCell) {
        cell.textLabel?.font = AppearanceHelper.typerighterFont(with: .caption1, pointSize: 30)
        cell.detailTextLabel?.font = AppearanceHelper.typerighterFont(with: .caption2, pointSize: 25)
        cell.textLabel?.backgroundColor = .clear
        cell.detailTextLabel?.backgroundColor = .clear
        
        cell.textLabel?.textColor = .white
        cell.detailTextLabel?.textColor = .white
        
        cell.backgroundColor = AppearanceHelper.backgroundGray
    }
    
    @objc private func sortMessageArray() {
        switch messageSortSegmentedControl.selectedSegmentIndex {
        case 0:
            messageController.messages.sort(by: { $0.timestamp < $1.timestamp })
        case 1:
            messageController.messages.sort(by: { $0.timestamp > $1.timestamp })
        default:
            break
        }
        
        tableView.reloadData()
    }
    
    @IBAction func sortMessages(_ sender: Any) {
        sortMessageArray()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageController.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath)
        
        let message = messageController.messages[indexPath.row]
        
        cell.textLabel?.text = message.text
        cell.detailTextLabel?.text = message.sender
        
        style(cell: cell)
        
        return cell
    }

    let messageController = MessageController()
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        
        formatter.timeStyle = .long
        formatter.dateStyle = .short
        
        return formatter
    }()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CreateMessage" {
            guard let destinationVC = segue.destination as? MessageCreationViewController else { return }
            
            destinationVC.messageController = messageController
        }
    }
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var newMessageButton: UIButton!
    @IBOutlet weak var messageSortSegmentedControl: UISegmentedControl!
}
