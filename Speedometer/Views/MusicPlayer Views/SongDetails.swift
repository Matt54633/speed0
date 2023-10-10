//
//  SongDetails.swift
//  Speedometer
//
//  Created by Matt Sullivan on 13/10/2023.
//

import SwiftUI
import MediaPlayer

struct SongDetails: View {
    @StateObject private var nowPlayingSong = NowPlayingSong()
    
    var body: some View {
        VStack {
            VStack {
                VStack() {
                    if let albumArtworkData = nowPlayingSong.albumArtwork {
                        Image(uiImage: albumArtworkData)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 75)
                            .clipShape(.rect(cornerSize: CGSize(width: 10, height: 10)))
                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    } else {
                        ZStack {
                            RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                                .fill(.pink.gradient)
                                .frame(width: 75, height: 75)
                                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                            Image(systemName: "music.note")
                                .font(.system(size: 60))
                        }
                    }
                    VStack {
                        Text(nowPlayingSong.songTitle)
                            .font(.title3)
                            .fontDesign(.rounded)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .lineLimit(1)
                            .scrollBounceBehavior(.always)
                        Text(nowPlayingSong.artistName)
                            .fontDesign(.rounded)
                    }   
                    .padding(.vertical, 10)
                }
                
                CustomSlider(
                    value: Binding(
                        get: {
                            Double(nowPlayingSong.currentPlaybackTime ?? 0.0)
                        },
                        set: { newValue in
                            let time = TimeInterval(newValue)
                            MPMusicPlayerController.systemMusicPlayer.currentPlaybackTime = time
                        }
                    ),
                    inRange: 0.0...Double(nowPlayingSong.songLength)
                )
                .frame(height: 12)
            }
        }
    }
}

#Preview {
    SongDetails()
}
