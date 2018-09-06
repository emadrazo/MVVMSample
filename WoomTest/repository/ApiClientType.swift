import Foundation
import RxSwift

public protocol ApiClientType {
    
    associatedtype Ent
    
    func getEntity(forResource resource: Resource) -> Observable<Ent>
    
    func getEntitiyList(forResource resource: Resource) -> Observable<[Ent]>
}

