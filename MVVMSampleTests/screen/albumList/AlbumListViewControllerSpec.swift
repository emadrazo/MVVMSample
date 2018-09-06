import Foundation
import Quick
import Nimble

@testable import MVVMSample

class AlbumListViewControllerSpec: QuickSpec {
    
    override func spec() {
        var sut: AlbumListViewController!
        
        beforeEach {
            let viewModel = AlbumListViewModelSpy()
            sut = AlbumListViewController(viewModel: viewModel)
            _ = sut.view
        }
        
        describe("Creation") {
            it("should show title") {
                expect(sut.title).to(match("screenName"))
            }
            
            it("should show 4 albums") {
                expect(sut.albumsTableView.numberOfRows(inSection: 0)).to(be(4))
            }
        }
        
        
    }
}

