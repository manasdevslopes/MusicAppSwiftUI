//
//  ContentView.swift
//  Music App
//
//  Created by MANAS VIJAYWARGIYA on 02/01/21.
//

import SwiftUI
import Firebase

struct Album : Hashable {
    var id = UUID()
    var name: String
    var image: String
    var songs: [Song]
}
struct Song: Hashable {
    var id = UUID()
    var name: String
    var time: String
    var file: String
}

struct ContentView: View {
    @ObservedObject var data: OurData
    
    @State private var currentAlbum: Album?
    
    var body: some View {
        NavigationView {
            ScrollView {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack{
                        ForEach(self.data.album,id:\.self) {album in
                            AlbumArt(album: album, isWithText: true).onTapGesture {
                                self.currentAlbum = album
                            }
                        }
                    }
                }
                LazyVStack {
                    if self.data.album.first == nil {
                        EmptyView()
                    }else {
                        ForEach((self.currentAlbum?.songs ?? self.data.album.first?.songs) ??
                                    [Song(name: "", time: "", file: "")],id: \.self) { song in
                            
                            songCell(album: currentAlbum ?? self.data.album.first!, song: song)
                            
                        }
                    }
                   
                }
            }.navigationBarTitle("My Music")
        }
    }
}
struct AlbumArt: View {
    var album: Album
    var isWithText: Bool
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Image(album.image).resizable().aspectRatio(contentMode: .fill).frame(width: 170, height: 200, alignment: .center)
            if isWithText == true {
                ZStack {
                    Blur(style: .dark)
                    Text(album.name).foregroundColor(.white)
                }.frame(height: 70, alignment: .center)
            }
        }.frame(width: 170, height: 200, alignment: .center).clipped().cornerRadius(20).shadow(radius: 10).padding(20)
    }
}

struct songCell: View {
    var album: Album
    var song: Song
    var body: some View {
        NavigationLink(
            destination: PlayerView(album: album, song: song)) {
            HStack{
                ZStack{
                    Circle().frame(width:50,height:50, alignment: .center).foregroundColor(.blue)
                    Circle().frame(width:20,height:20, alignment: .center).foregroundColor(.white)
                }
                Text(song.name).bold()
                Spacer()
                Text(song.time)
            }
            .padding(20)
        }
        .buttonStyle(PlainButtonStyle())
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(data: OurData())
    }
}
