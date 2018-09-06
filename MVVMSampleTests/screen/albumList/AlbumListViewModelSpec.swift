import Quick
import Nimble
import RxSwift

@testable import MVVMSample

class AlbumListViewModelSpec: QuickSpec {
    
    override func spec() {
        
        let albumService = AlbumServiceSpy()
        
        let router = AlbumListRouterSpy(navigationController: nil)
        
        var sut: AlbumListViewModel!
        
        let bag = DisposeBag()
        
        beforeEach {
            
            sut = AlbumListViewModel(router: router, service: albumService)
            
            waitUntil(timeout: 10) { done in
                sut.didLoad
                    .subscribe(onNext: { error in
                        done()
                    })
                    .disposed(by:bag)
                sut.reload()
            }
        }
        
        describe("getAlbums") {
            it("should execute getHomeUseCase") {
                
                expect(albumService.getAlbumsCallInService).toEventually(beTrue())
            }
        }
        
        describe("Provide data") {
            it("albumsObservable should provide array of Albums on success") {
                
                var response = false
                
                sut.albumsObservable.subscribe(onNext: { _ in
                    
                    response = true
                    
                }).disposed(by:bag)
                
                expect(response).toEventually(equal(true))
            }
        }
    }
}
