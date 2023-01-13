import Foundation

struct ValCurs: Decodable {
    let Valute: [Valute]
}

struct Valute: Decodable {
    let NumCode: String
    let CharCode: String
    let Nominal: String
    let Name: String
    let Value: String
}
