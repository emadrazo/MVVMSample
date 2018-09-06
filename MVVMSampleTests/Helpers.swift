import Foundation
import RxSwift

@testable import MVVMSample

func getJSONDictionaryFromFile(named fileName: String, inBundle bundle: Bundle) -> JSONDictionary {
    let path = bundle.path(forResource: fileName, ofType: "json")!
    let data = try? Data(contentsOf: URL(fileURLWithPath: path))
    return try! JSONSerialization.jsonObject(with: data!, options: []) as! JSONDictionary
}

let albumMock = Album(identifier: 1, userId: 2, title: "albumTitle")
let albumPhotoMock = AlbumPhoto(identifier: 3, albumId: 4, title: "albumPhotoTitle", url: "albumPhotoUrl", thumbnailUrl: "albumPhotoThumbnail")

class AlbumListViewModelSpy:AlbumListViewModelType {
    var screenNameObservable: Observable<String> = Observable.of("screenName")
    
    var didLoad: Observable<Error?> = Observable.of(nil)
    
    var presentLoadingView: Observable<Bool> = Observable.of(false)
    
    var presentErrorView: Observable<Bool> = Observable.of(false)
    
    var albumsObservable: Observable<[Album]> = Observable.of([albumMock, albumMock, albumMock, albumMock])
    
    var descriptionText: Observable<String> = Observable.of("")
    
    var buttonText: Observable<String> = Observable.of("")
    
    init() {}
    
    func reload() {
        
    }
    
    func requestData() {
        
    }
    
    func refreshData() {
        
    }
    
    func buttonTaped() {
        
    }
    
    func didSelectCell(indexPath: IndexPath) {
        
    }
}

class AlbumServiceSpy: AlbumServiceType {
    var getAlbumsCallInService = false
    var getPhotosCallInService = false
    func getAlbums() -> Observable<[Album]> {
        getAlbumsCallInService = true
        return Observable.of([albumMock])
    }
    
    func getPhotos(forAlbum album: Album) -> Observable<[AlbumPhoto]> {
        getPhotosCallInService = true
        return Observable.of([albumPhotoMock])
    }
}

class AlbumListRouterSpy: AlbumListRouter {
    var navigateToPhotosCalledInRouter = false

    override func navigateToPhotos(forAlbum album: Album) {
        navigateToPhotosCalledInRouter = true
    }
}
