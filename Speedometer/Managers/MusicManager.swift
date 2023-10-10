//
//  MusicManager.swift
//  Speedometer
//
//  Created by Matt Sullivan on 11/10/2023.
//

import Foundation
import MediaPlayer
import Combine

class NowPlayingSong: ObservableObject {
    @Published var songTitle: String = ""
    @Published var artistName: String = ""
    @Published var albumTitle: String = ""
    @Published var albumArtwork: UIImage?
    @Published var songLength: TimeInterval = 0.0
    @Published var currentPlaybackTime: TimeInterval?
    
    private var playbackStateObserver: AnyCancellable?
    private var timer: Timer?
    
    init() {
        setupPlaybackStateObserver()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.updateCurrentPlaybackTime()
        }
        timer?.tolerance = 0.1
    }
    
    deinit {
        // Clean up any observers or subscriptions when the object is deallocated.
        playbackStateObserver?.cancel()
        
        timer?.invalidate()
        
    }
    
    private func setupPlaybackStateObserver() {
        // Create a playback state observer to watch for changes.
        playbackStateObserver = NotificationCenter.default.publisher(for: .MPMusicPlayerControllerNowPlayingItemDidChange)
            .sink { [weak self] _ in
                self?.updateNowPlayingInfo()
            }
        
        updateNowPlayingInfo()
    }
    
    func updateNowPlayingInfo() {
        if let nowPlayingItem = MPMusicPlayerController.systemMusicPlayer.nowPlayingItem {
            songTitle = nowPlayingItem.title ?? ""
            artistName = nowPlayingItem.artist ?? ""
            albumTitle = nowPlayingItem.albumTitle ?? ""
            songLength = nowPlayingItem.playbackDuration
            albumArtwork = nowPlayingItem.artwork?.image(at: CGSize(width: 150, height: 150))
            currentPlaybackTime = MPMusicPlayerController.systemMusicPlayer.currentPlaybackTime
        } else {
            songTitle = ""
            artistName = ""
            albumTitle = ""
            albumArtwork = UIImage()
            songLength = 0.0
            currentPlaybackTime = nil
        }
    }
    
    private func updateCurrentPlaybackTime() {
        // Fetch and update the current playback time every second
        currentPlaybackTime = MPMusicPlayerController.systemMusicPlayer.currentPlaybackTime
    }
}
