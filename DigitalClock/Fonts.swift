//
//  Fonts.swift
//  DigitalClock
//
//  Created by Tudor Octavian Ana on 23.02.2023.
//

import Foundation

struct Fonts: Decodable {

    enum CodingKeys: String, CodingKey {
        case zero = "0"
        case one = "1"
        case two = "2"
        case three = "3"
        case four = "4"
        case five = "5"
        case six = "6"
        case seven = "7"
        case eight = "8"
        case nine = "9"
        case separator = ":"
    }

    var zero: [[Int]] = []
    var one: [[Int]] = []
    var two: [[Int]] = []
    var three: [[Int]] = []
    var four: [[Int]] = []
    var five: [[Int]] = []
    var six: [[Int]] = []
    var seven: [[Int]] = []
    var eight: [[Int]] = []
    var nine: [[Int]] = []
    var separator: [[Int]] = []

    init() {
        guard let value = self.load() else { return }
        self = value
    }

    private func load(from file: String = "fonts") -> Fonts? {
        guard let path = Bundle.main.path(forResource: file, ofType: "json") else { return nil }
        let fileUrl = URL(fileURLWithPath: path)
        if let data = try? Data(contentsOf: fileUrl) {
            return try? JSONDecoder().decode(Fonts.self, from: data)
        }
        return nil
    }
}
