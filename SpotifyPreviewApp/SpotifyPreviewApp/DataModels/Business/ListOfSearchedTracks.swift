import Foundation

// MARK: - ListOfTrack
struct ListOfSearchedTracks: Codable {
    let tracks: SearchedTracks
}

// MARK: - Tracks
struct SearchedTracks: Codable {
    let items: [Track]
}
