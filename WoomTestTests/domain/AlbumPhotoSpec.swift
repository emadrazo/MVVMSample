import Foundation
import Quick
import Nimble

@testable import WoomTest

class AlbumPhotoSpec: QuickSpec {
    
    override func spec() {
        
        describe("Creation") {
            it("shoud create a AlbumPhoto entity") {
                
                let sut = AlbumPhoto(identifier: 1, albumId:12, title: "titulo", url:"http://url", thumbnailUrl: "https://thumbnailUrl")
                
                expect(sut.identifier).to(equal(1))
                expect(sut.albumId).to(equal(12))
                expect(sut.title).to(match("titulo"))
                expect(sut.url).to(match("http://url"))
                expect(sut.thumbnailUrl).to(match("https://thumbnailUrl"))
            }
        }
        
        describe("Parse") {
            it("shoud create a AlbumPhoto from JSON") {
                
                let jsonData = getJSONDictionaryFromFile(named: "albumPhoto", inBundle: Bundle(for: type(of: self)))
                
                let sut = try? AlbumPhoto(dictionary: jsonData)
                
                expect(sut).toNot(beNil())
                if let sut = sut {
                    expect(sut.identifier).to(equal(2))
                    expect(sut.albumId).to(equal(1))
                    expect(sut.title).to(match("reprehenderit est deserunt velit ipsam"))
                    expect(sut.url).to(match("https://via.placeholder.com/600/771796"))
                    expect(sut.thumbnailUrl).to(match("https://via.placeholder.com/150/771796"))
                }
            }
        }
    }
}
