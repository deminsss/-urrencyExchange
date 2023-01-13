import Foundation
import XMLParsing

protocol DataParserProtocol {
    func parse<T: Decodable>(data: Data) throws -> T
}

final class DataParser: DataParserProtocol {
    
    private var xmlDecoder: XMLDecoder
    
    init(xmlDecoder: XMLDecoder = XMLDecoder()) {
        self.xmlDecoder = xmlDecoder
    }
    
    func parse<T: Decodable>(data: Data) throws -> T {
        return try xmlDecoder.decode(T.self, from: data)
    }
}
