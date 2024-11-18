//
//  EmojiTableViewController.swift
//  EmojiDictionary
//
//  Created by Gwen Thelin on 11/17/24.
//

import UIKit

class EmojiTableViewController: UITableViewController {
	var emojis: [Emoji] = []

    override func viewDidLoad() {
        super.viewDidLoad()

         self.navigationItem.leftBarButtonItem = self.editButtonItem
		
		tableView.rowHeight = UITableView.automaticDimension
		tableView.estimatedRowHeight = 44.0
		
		emojis = Emoji.loadFromFile() ?? Emoji.sampleEmojis()
		
		Emoji.saveToFile(emojis: emojis)
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		tableView.reloadData()
	}

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
		return emojis.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let
				cell = tableView.dequeueReusableCell(withIdentifier: "EmojiCell", for: indexPath)
				as? EmojiTableViewCell else {	return UITableViewCell()	}
		
		cell.update(with: emojis[indexPath.row])

		cell.showsReorderControl = true
        return cell
    }
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let emoji: Emoji = emojis[indexPath.row]
		
		print("\(emoji.symbol) - \(emoji.name)")
	}

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
			emojis.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
			Emoji.saveToFile(emojis: emojis)
        }
    }

    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
		let movedEmoji: Emoji = emojis.remove(at: fromIndexPath.row)
		emojis.insert(movedEmoji, at: to.row)
		Emoji.saveToFile(emojis: emojis)
    }
	
	@IBSegueAction func addEditEmoji(_ coder: NSCoder, sender: Any?) -> AddEditEmojiTableViewController? {
		guard let cell = sender as? UITableViewCell,
			  let indexPath = tableView.indexPath(for: cell)
		else { return AddEditEmojiTableViewController(coder: coder, emoji: nil) }
		
		let emojiToEdit = emojis[indexPath.row]
		return AddEditEmojiTableViewController(coder: coder, emoji: emojiToEdit)
	}
	
	@IBAction func unwindToEmojiTableView(_ segue: UIStoryboardSegue) {
		guard segue.identifier == "SaveUnwind",
			  let sourceViewController = segue.source as? AddEditEmojiTableViewController,
			  let emoji = sourceViewController.emoji
		else { return }
		
		if let indexPath = tableView.indexPathForSelectedRow {
			emojis[indexPath.row] = emoji
			tableView.reloadRows(at: [indexPath], with: .none)
			Emoji.saveToFile(emojis: emojis)
		} else {
			let newIndexPath: IndexPath = .init(row: emojis.count, section: 0)
			emojis.append(emoji)
			tableView.insertRows(at: [newIndexPath], with: .automatic)
			Emoji.saveToFile(emojis: emojis)
		}
	}
	
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
