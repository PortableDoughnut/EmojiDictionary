//
//  Emoji.swift
//  EmojiDictionary
//
//  Created by Gwen Thelin on 11/17/24.
//

import Foundation

struct Emoji {
	var symbol: String
	var name: String
	var description: String
	var usage: String
}

extension Emoji: Codable {
	static func saveToFile(emojis: [Emoji]) {
		let propertyListEncoder: PropertyListEncoder = .init()
		let documentsDirectory: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
		let archiveURL: URL = documentsDirectory.appendingPathComponent("emojis").appendingPathExtension("plist")
		
		guard let encodedEmojis = try? propertyListEncoder.encode(emojis) else {
			print("Failed to encode emojis")
			return
		}
		
		try? encodedEmojis.write(to: archiveURL, options: .noFileProtection)
	}
	
	static func loadFromFile() -> [Emoji]? {
		let propertyListDecoder: PropertyListDecoder = .init()
		let documentsDirectory: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
		let archiveURL: URL = documentsDirectory.appendingPathComponent("emojis").appendingPathExtension("plist")
		
		guard let retrievedEmojiData = try? Data(contentsOf: archiveURL),
			  let decodedEmojis = try? propertyListDecoder.decode([Emoji].self, from: retrievedEmojiData)
		else {	return nil	}
		
		return decodedEmojis
	}
	
	static func sampleEmojis() -> [Emoji] {
		[
			Emoji(symbol: "😩",
				  name: "Weary Face",
				  description: "An exausted face",
				  usage: "Fun nights"),
			Emoji(symbol: "🤔",
				  name: "Thinking Face",
				  description: "A face with a puzzled expression",
				  usage: "When you're not sure what to do"),
			Emoji(symbol: "🙄",
				  name: "Face with Rolling Eyes",
				  description: "A face with an annoyed expression",
				  usage: "When you're so over it"),
			Emoji(symbol: "😬",
				  name: "Grimacing Face",
				  description: "A face with a frowning expression",
				  usage: "When you heard something cringy"),
			Emoji(symbol: "😭",
				  name: "Loudly Crying Face",
				  description: "A face with a crying expression",
				  usage: "When you're really upset"),
			Emoji(symbol: "🎷",
				  name: "Saxaphone",
				  description: "A brass instrument",
				  usage: "When you're having a good time"),
			Emoji(symbol: "🎶",
				  name: "Musical Note",
				  description: "A musical note",
				  usage: "When you're playing music"),
			Emoji(symbol: "🏔️",
				  name: "Snow Capped Mountian",
				  description: "A mountian with snow on top",
				  usage: "When you're creating a Mtech code challenge")
		]
	}
}
