//
//  Emoji.swift
//  EmojiDictionary
//
//  Created by Gwen Thelin on 11/17/24.
//

struct Emoji {
	var symbol: String
	var name: String
	var description: String
	var usage: String
}

var emojis: [Emoji] = [
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
