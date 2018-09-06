import Foundation
import RxSwift

public protocol ApiClientType {
    func getEntity<T:JSONDecodable>(forResource resource: Resource) -> Observable<T>
    func getEntitiyList<T:JSONDecodable>(forResource resource: Resource) -> Observable<[T]>
}
