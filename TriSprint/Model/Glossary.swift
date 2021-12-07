//
//  Glossary.swift
//  TriSprint
//
//  Created by Nigel Karan on 07.12.21.
//

import SwiftUI

struct Glossary: Identifiable {
    var id = UUID()
    var term: String
    var explanation: String
}

extension Glossary {
    static let glossaryItems = [
    Glossary(term: "fc", explanation: "Front crawl swim stroke."),
    Glossary(term: "pull buoy", explanation: "A figure 8 piece of closed-cell foam, to be placed between thighs while swimming, to create extra buoyancy for your hips to bring your body in line so you are more streamlined."),
    Glossary(term: "paddles", explanation: "Swim hand paddles are used to develop upper body strength, working the back, chest, arms and shoulders. By stopping water flow through your fingers, you pull with more power."),
    Glossary(term: "1&3 breathing", explanation: "While swimming, take a breath on the first and third stroke."),
    Glossary(term: "4 x 25/ 10 x 25 etc", explanation: "No of lengths of a 25m swimming pool"),
    Glossary(term: "R:20/ R:1min", explanation: "Rest time: 20 seconds, rest time: 1 minute"),
    Glossary(term: "scull", explanation: "While swimming, make a back and forth motion with your hands as if you're drawing a figure 8."),
    Glossary(term: "fins", explanation: "Swimming accessory worn on your feet, like flippers. Used to train your upper body to swim at a faster pace."),
    Glossary(term: "HR", explanation: "Heart Rate"),
    Glossary(term: "RPM", explanation: "Revolutions per minute (on the bike).")
    ]
}
