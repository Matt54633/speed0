//
//  PlaybackControls.swift
//  Speedometer
//
//  Created by Matt Sullivan on 13/10/2023.
//

import SwiftUI
import MediaPlayer

struct PlaybackControls: View {
    @StateObject private var nowPlayingSong = NowPlayingSong()
    @State private var isPlaying: Bool = false
    
    var body: some View {
        HStack {
            Group {
                Button(action: {
                    MPMusicPlayerController.systemMusicPlayer.skipToPreviousItem()
                }) {
                    Image(systemName: "backward.fill")
                        .font(.system(size: 35))
                }
                Button(action: {
                    if isPlaying {
                        MPMusicPlayerController.systemMusicPlayer.pause()
                    } else {
                        MPMusicPlayerController.systemMusicPlayer.play()
                    }
                    isPlaying.toggle()
                }) {
                    Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                        .contentTransition(.symbolEffect(.replace, options: .speed(3)))
                        .font(.system(size: 45))
                        .frame(width: 30)
                }
                
                Button(action: {
                    MPMusicPlayerController.systemMusicPlayer.skipToNextItem()
                }) {
                    Image(systemName: "forward.fill")
                        .font(.system(size: 35))
                }
            }
            .frame(minHeight: 45)
            .padding(.horizontal, 20)
        }
        .padding(.bottom, 20)
        .foregroundStyle(.primary)
        .onAppear {
            isPlaying = MPMusicPlayerController.systemMusicPlayer.playbackState == .playing
            nowPlayingSong.updateNowPlayingInfo()
        }
    }
}

#Preview {
    PlaybackControls()
}
