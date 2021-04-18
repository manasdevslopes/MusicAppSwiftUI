//
//  Music_AppApp.swift
//  Music App
//
//  Created by MANAS VIJAYWARGIYA on 02/01/21.
//

import SwiftUI
import Firebase

@main
struct Music_AppApp: App {
    let data = OurData()
    init() {
        FirebaseApp.configure()
        data.loadAlbums()
    }
    var body: some Scene {
        WindowGroup {
            ContentView(data: data)
        }
    }
}
