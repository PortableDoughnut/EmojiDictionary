//
//  AddEditEmojiTableViewController.swift
//  EmojiDictionary
//
//  Created by Gwen Thelin on 11/17/24.
//

import UIKit

class AddEditEmojiTableViewController: UITableViewController {
	@IBOutlet weak var symbolTextField: UITextField!
	@IBOutlet weak var nameTextField: UITextField!
	@IBOutlet weak var descriptionTextField: UITextField!
	@IBOutlet weak var usageTextField: UITextField!
	@IBOutlet weak var saveButton: UIBarButtonItem!
	
	var emoji: Emoji?

	override func viewDidLoad() {
		super.viewDidLoad()
		
		if let emoji = emoji {
			symbolTextField.text = emoji.symbol
			nameTextField.text = emoji.name
			descriptionTextField.text = emoji.description
			usageTextField.text = emoji.usage
			
			title = "Edit \(emoji.name) Emoji"
		} else {
			title = "Add Emoji"
		}
		
		updateSaveButtonState()
	}
	
	init?(coder: NSCoder, emoji: Emoji? = nil) {
		self.emoji = emoji
		super.init(coder: coder)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	@IBAction func textEditingChanged(_ sender: UITextField) {
		updateSaveButtonState()
	}
	
	func updateSaveButtonState() {
		let symbolText = symbolTextField.text ?? ""
		let nameText = nameTextField.text ?? ""
		let descriptionText = descriptionTextField.text ?? ""
		let usageText = usageTextField.text ?? ""
		
		saveButton.isEnabled = containsSingleEmoji(symbolTextField) &&
			!nameText.isEmpty &&
			!descriptionText.isEmpty &&
			!usageText.isEmpty
	}
	
	func containsSingleEmoji(_ textField: UITextField) -> Bool {
		guard let text = textField.text,
			  text.count == 1
		else { return false }
		
		let isCombinedEmoji = text.unicodeScalars.count > 1 &&
			text.unicodeScalars.first?.properties.isEmoji ?? false
		let isEmojiPresentation = text.unicodeScalars.first?.properties.isEmojiPresentation ?? false
		
		return isEmojiPresentation || isCombinedEmoji
	}
	

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		guard segue.identifier == "SaveUnwind" else {	return	}
		
		let symbol = symbolTextField.text!
		let name = nameTextField.text!
		let description = descriptionTextField.text!
		let usage = usageTextField.text!
		
		emoji = .init(symbol: symbol, name: name, description: description, usage: usage)
    }

}
