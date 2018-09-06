import Foundation
import Quick
import Nimble

@testable import WoomTest

class AlbumSpec: QuickSpec {
    
    override func spec() {
        
        describe("Creation") {
            it("shoud create a Album entity") {
                
                let sut = Album(identifier: 1, userId:12, title: "titulo")
                
                expect(sut.identifier).to(equal(1))
                expect(sut.userId).to(equal(12))
                expect(sut.title).to(match("titulo"))
            }
        }
        
        describe("Parse") {
            it("shoud create a Album from JSON") {
                
                let jsonData = getJSONDictionaryFromFile(named: "album", inBundle: Bundle(for: type(of: self)))
                
                let sut = try? Album(dictionary: jsonData)
                
                expect(sut).toNot(beNil())
                if let sut = sut {
                    expect(sut.identifier).to(equal(1))
                    expect(sut.userId).to(equal(1))
                    expect(sut.title).to(match("quidem molestiae enim"))
                }
            }
        }
    }
}
