//
//  DirectorySelectorView.swift
//  AppExposeS
//
//  Created by Dave Carlton on 9/7/22.
//

import SwiftUI

public struct DirectorySelectorView: View {
    @State var title: String?
    @State var name: String
    @Binding private var url: URL?

    public init(name: String, url: Binding<URL?>) {
        self.name = name
        _url = url
    }

    private func selectFile() {
        let openPanel = NSOpenPanel()
        openPanel.canChooseDirectories = true
        openPanel.allowsMultipleSelection = false
        openPanel.begin { response in
            if response == .OK {
                self.url = openPanel.url
            }
        }
    }

    /// the view
    public var body: some View {
        VStack(alignment: .leading) {
            if url != nil {
                Text(url!.lastPathComponent).fixedSize()
            } else {
                if let title = title {
                    HStack {
                        Text(title)
                            .fontWeight(.ultraLight)
                            .italic()
                            .padding([.top, .leading], 4.0)
                        
                        Spacer()
                    }
                }
            }
            Button(name) {
                self.selectFile()
            }
        }
    }

}

struct DirectorySelectorView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DirectorySelectorView(name: "Add", url: .constant(nil))
            DirectorySelectorView(name: "Add", url: .constant(URL(fileURLWithPath: "/Applications")))
        }
    }
}
