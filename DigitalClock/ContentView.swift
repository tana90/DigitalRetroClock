//
//  ContentView.swift
//  DigitalClock
//
//  Created by Tudor Octavian Ana on 23.02.2023.
//

import SwiftUI

// MARK: Content View

struct ContentView: View {

    @State private var refreshId: UUID = UUID()
    private let padding: CGFloat = 1
    private let maxScreenPoints: Int = 50
    private let color: Color = Color("AccentColor")
    private var fonts: Fonts = Fonts()
    private let timer = Timer.publish(every: 1,
                                      on: .current, in: .common).autoconnect()

    var body: some View {
        GeometryReader { proxy in
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    ForEach(0 ..< getTime().count, id: \.self) { component in
                        draw(value: getTime()[component],
                             size: proxy.size.width / CGFloat(maxScreenPoints))
                    }
                    Spacer()
                }
                .id(refreshId)
                Spacer()
            }
            .edgesIgnoringSafeArea(.all)
            .background(Color.black)
        }
        .onReceive(timer) { _ in
            refreshId = UUID()
        }
    }
}

// MARK: Helpers

extension ContentView {

    private func draw(value: String, size: CGFloat = 5) -> AnyView {

        func drawPoints(for array: [[Int]], with size: CGFloat) -> AnyView {
            AnyView(VStack(spacing: padding) {
                ForEach(0 ..< array.count, id: \.self) { row in
                    HStack(spacing: padding) {
                        ForEach(0 ..< array[row].count, id: \.self) { column in
                            let point = array[row][column]
                            Rectangle()
                                .fill(point == 0 ? Color.clear : color)
                                .frame(minWidth: 1, maxWidth: size - padding,
                                       minHeight: 1, maxHeight: size - padding)
                        }
                    }
                }
            })
        }

        switch value {
            case "0": return drawPoints(for: fonts.zero, with: size)
            case "1": return drawPoints(for: fonts.one, with: size)
            case "2": return drawPoints(for: fonts.two, with: size)
            case "3": return drawPoints(for: fonts.three, with: size)
            case "4": return drawPoints(for: fonts.four, with: size)
            case "5": return drawPoints(for: fonts.five, with: size)
            case "6": return drawPoints(for: fonts.six, with: size)
            case "7": return drawPoints(for: fonts.seven, with: size)
            case "8": return drawPoints(for: fonts.eight, with: size)
            case "9": return drawPoints(for: fonts.nine, with: size)
            case ":": return drawPoints(for: fonts.separator, with: size)
            default: return AnyView(VStack { })
        }
    }

    private func getTime() -> [String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        let dateString = formatter.string(from: Date())
        return dateString.map { String($0) }
    }
}
