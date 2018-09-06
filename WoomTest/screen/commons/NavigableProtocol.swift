import Foundation


protocol AlbumPhotosNavigable {
    func navigateToPhotos(forAlbum album: Album)
}

protocol ExternalURLNavigable {
    func navigateToURL(_ url: URL)
}
