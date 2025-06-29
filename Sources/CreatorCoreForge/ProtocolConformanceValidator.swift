protocol Validator {
    func validate() -> Bool
}

struct ProtocolConformanceValidator: Validator {
    let value: String
    func validate() -> Bool {
        return !value.isEmpty
    }
}
