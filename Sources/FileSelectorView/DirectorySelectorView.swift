//
//  DirectorySelectorView.swift
//  AppExposeS
//
//  Created by Dave Carlton on 9/7/22.
//

import SwiftUI

public struct DirectorySelectorView: View {
    @Binding private var url: URL?

    /// the view
    public var body: some View {
        VStack(alignment: .leading) {
            if url != nil {
                Text(url!.lastPathComponent).fixedSize()
            } else {
                HStack {
                    Text("Select...")
                        .fontWeight(.ultraLight)
                        .italic()
                        .padding([.top, .leading], 4.0)
                        
                    Spacer()
                }
            }
            Button("Choose Directory") {
                self.selectFile()
            }
        }
    }

    /// Creates the view
    /// - Parameters:
    ///   - url: Binding of the URL of the selected file
    public init(url: Binding<URL?>) {
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
}

struct DirectorySelectorView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DirectorySelectorView(url: .constant(nil))
            DirectorySelectorView(url: .constant(URL(fileURLWithPath: "/Applications")))
        }
    }
}
