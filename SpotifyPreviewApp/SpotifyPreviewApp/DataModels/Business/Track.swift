import Foundation

// MARK: - ListOfTrack
struct ListOfTrack: Codable {
    let tracks: PlaylistTracks
}

// MARK: - Tracks
struct PlaylistTracks: Codable {
    let href: String
    let items: [Song]
    let limit: Int
    let next: String
    let offset: Int
    let total: Int
}

// MARK: - Item
struct Song: Codable {
    let album: SongAlbum
    let artists: [SongArtist]
    let availableMarkets: [String]
    let discNumber, durationMS: Int
    let explicit: Bool
    let externalIDS: TrackExternalIDS
    let externalUrls: ExternalUrls
    let href: String
    let identifier: String
    let isLocal: Bool
    let name: String
    let popularity: Int
    let previewURL: String?
    let trackNumber: Int
    let type, uri: String

    enum CodingKeys: String, CodingKey {
        case album, artists
        case availableMarkets = "available_markets"
        case discNumber = "disc_number"
        case durationMS = "duration_ms"
        case explicit
        case externalIDS = "external_ids"
        case externalUrls = "external_urls"
        case href
        case identifier = "id"
        case isLocal = "is_local"
        case name, popularity
        case previewURL = "preview_url"
        case trackNumber = "track_number"
        case type, uri
    }
}

// MARK: - Album
struct SongAlbum: Codable {
    let albumType: String
    let artists: [SongArtist]
    let availableMarkets: [String]
    let externalUrls: ExternalUrls
    let href: String
    let identifier: String
    let images: [SongImage]
    let name, releaseDate, releaseDatePrecision: String
    let totalTracks: Int
    let type, uri: String

    enum CodingKeys: String, CodingKey {
        case albumType = "album_type"
        case artists
        case availableMarkets = "available_markets"
        case externalUrls = "external_urls"
        case href
        case identifier = "id"
        case images, name
        case releaseDate = "release_date"
        case releaseDatePrecision = "release_date_precision"
        case totalTracks = "total_tracks"
        case type, uri
    }
}

// MARK: - Artist
struct SongArtist: Codable {
    let externalUrls: ExternalUrls
    let href: String
    let identifier, name, type, uri: String

    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case href
        case identifier = "id"
        case name, type, uri
    }
}

// MARK: - ExternalUrls
struct ExternalUrls: Codable {
    let spotify: String
}

// MARK: - Image
struct SongImage: Codable {
    let height: Int
    let url: String
    let width: Int
}

// MARK: - ExternalIDS
struct TrackExternalIDS: Codable {
    let isrc: String
}
