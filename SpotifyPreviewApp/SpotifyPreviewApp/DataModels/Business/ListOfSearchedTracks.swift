import Foundation

// MARK: - ListOfTrack
struct ListOfSearchedTracks: Codable {
    let tracks: SearchedTracks
}

// MARK: - SearchedTracks
struct SearchedTracks: Codable {
    let items: [Track]
}
