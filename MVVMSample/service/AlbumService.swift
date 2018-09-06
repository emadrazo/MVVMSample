import Foundation
import RxSwift

public struct URLConstants {
    static let albumsURL = "https://jsonplaceholder.typicode.com/albums"
    static let albumPhotosURL = "https://jsonplaceholder.typicode.com/photos"
    //https://jsonplaceholder.typicode.com/photos?albumId=1&userId=1
}

protocol AlbumServiceType {
    func getAlbums() -> Observable<[Album]>
    func getPhotos(forAlbum album:Album) -> Observable<[AlbumPhoto]>
}

class AlbumService: AlbumServiceType {
    var apiClient:ApiClientType
    
    init(apiClient:ApiClientType){
        self.apiClient = apiClient
    }
    
    func getAlbums() -> Observable<[Album]> {
        let albumsURL: URL = URL(string:URLConstants.albumsURL)!
        let resource = Resource(url: albumsURL, parameters: nil)
        return apiClient.getEntitiyList(forResource: resource)
    }
    
    func getPhotos(forAlbum album:Album) -> Observable<[AlbumPhoto]> {
        let albumPhotosURL: URL = URL(string:URLConstants.albumPhotosURL)!
        let parameters: ParametersDictionary = ["albumId":album.identifier, "userId":album.userId]
        let resource = Resource(url: albumPhotosURL, parameters: parameters)
        return apiClient.getEntitiyList(forResource: resource)
    }
}
