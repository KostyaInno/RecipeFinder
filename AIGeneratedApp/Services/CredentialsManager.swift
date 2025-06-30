import Foundation
import Security

protocol CredentialsManaging {
    func saveCredentials(username: String, password: String)
    func getCredentials() -> (username: String, password: String)?
    func deleteCredentials()
}

final class CredentialsManager: CredentialsManaging {
    private let service = "com.app.recipefinder"

    func saveCredentials(username: String, password: String) {
        let credentials: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: username,
            kSecValueData as String: password.data(using: .utf8) ?? Data()
        ]
        SecItemDelete(credentials as CFDictionary)
        SecItemAdd(credentials as CFDictionary, nil)
    }
    
    func getCredentials() -> (username: String, password: String)? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        guard status == errSecSuccess,
              let existingItem = item as? [String: Any],
              let username = existingItem[kSecAttrAccount as String] as? String,
              let passwordData = existingItem[kSecValueData as String] as? Data,
              let password = String(data: passwordData, encoding: .utf8) else {
            return nil
        }
        return (username, password)
    }
    
    func deleteCredentials() {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service
        ]
        SecItemDelete(query as CFDictionary)
    }
} 
