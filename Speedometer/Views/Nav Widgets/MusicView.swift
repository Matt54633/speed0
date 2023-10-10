//
//  MusicView.swift
//  Speedometer
//
//  Created by Matt Sullivan on 11/10/2023.
//

import SwiftUI

struct MusicView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color(.systemGray6))
            VStack {
                SongDetails()
                    .padding(.bottom, 25)
                PlaybackControls()
            }
            .padding(17.5)
        }
    }
}

#Preview {
    MusicView()
}
