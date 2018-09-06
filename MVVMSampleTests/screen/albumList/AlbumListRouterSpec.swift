import Quick
import Nimble

@testable import MVVMSample

class AlbumListRouterSpec: QuickSpec {
    
    override func spec() {
        var navVC: UINavigationController!
        var sut: AlbumListRouter!
        
        beforeEach {
            navVC = UINavigationController()
            sut = AlbumListRouter(navigationController: navVC)
            
            UIApplication.shared.keyWindow!.rootViewController = navVC
            let _ = navVC.view
        }
        
        describe("Start") {
            it("should start with a AlbumListViewController") {
                sut.start()
                expect(navVC.topViewController).toEventually(beAnInstanceOf(AlbumListViewController.self))
            }
        }
        
        describe("Navigation") {
            it("should push a ProductDetailViewController when navigateToProductDetail is called") {
                
                sut.navigateToPhotos(forAlbum: albumMock)
                expect(navVC.topViewController).toEventually(beAnInstanceOf(AlbumPhotosViewController.self))
            }
        }
    }
}
