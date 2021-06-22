//
//  ValidatorHelpers.swift
//  Mizzony
//
//  Created by Mostafa Mohamed on 8/24/19.
//  Copyright © 2019 Mostafa Mohamed. All rights reserved.
//

import Foundation

//class ValidationError: Error {
//    var message: String
//
//    init(_ message: String) {
//        self.message = message
//    }
//}

//protocol ValidatorConvertible {
//    func validated(_ value: String) throws -> String
//}
//
//enum ValidatorType {
//    case email
//    case password
//    case username
//    case requiredField(field: String)
//    case match(password: String)
//}
//
//enum VaildatorFactory {
//    static func validatorFor(type: ValidatorType) -> ValidatorConvertible {
//        switch type {
//        case .email: return EmailValidator()
//        case .password: return PasswordValidator()
//        case .username: return UserNameValidator()
//        case .requiredField(let fieldName): return RequiredFieldValidator(fieldName)
//        case .match(let password): return MatchPasswordValidator(password)
//        }
//    }
//}
//
//
//
//struct RequiredFieldValidator: ValidatorConvertible {
//    private let fieldName: String
//    
//    init(_ field: String) {
//        fieldName = field
//    }
//    
//    func validated(_ value: String) throws -> String {
//        guard !value.isEmpty else {
//            throw ValidationError(NSLocalizedString("validatation_required_field", comment: "") + ": " + fieldName)
//        }
//        return value
//    }
//}
//
//struct MatchPasswordValidator: ValidatorConvertible {
//    var orignalPassword: String
//    
//    init(_ password: String) {
//        orignalPassword = password
//    }
//    func validated(_ value: String) throws -> String {
//         guard value != "" else {
//            throw ValidationError(NSLocalizedString("validatation_required_password", comment: ""))
//        }
//        if orignalPassword != value {
//            throw ValidationError(NSLocalizedString("validatation_password_not_match", comment: ""))
//        }
//        return value
//    }
//    
//}
//struct UserNameValidator: ValidatorConvertible {
//    func validated(_ value: String) throws -> String {
//        guard value.count >= 3 else {
//            throw ValidationError("dawdadawdawdwadawdawdawdawdadawdad")
//        }
//        guard value.count < 18 else {
//            throw ValidationError("dwadkljallllllllllllllllll")
//        }
////        guard value.containsWhitespace == true else {
////             throw ValidationError(NSLocalizedString("need_space_between_firstname_and_lastname", comment:""))
////         }
//
//        do {
//            if try NSRegularExpression(pattern:"^[a-z ]{1,18}$",  options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
//                throw ValidationError("dadnddndndndndnd")
//            }
//        } catch {
//            throw ValidationError("dadnddndndndndnd")
//        }
//        return value
//    }
//}
//
//struct PasswordValidator: ValidatorConvertible {
//    func validated(_ value: String) throws -> String {
//        guard value != "" else {throw ValidationError("dadnddndndndndnd")}
//        guard value.count >= 6 else { throw ValidationError("dadnddndndndndnd") }
//        
//        do {
//            if try NSRegularExpression(pattern: "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,}$",  options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
//                throw ValidationError("dadnddndndndndnd")
//            }
//        } catch {
//            throw ValidationError("dadnddndndndndnd")
//        }
//        return value
//    }
//}
//
//struct EmailValidator: ValidatorConvertible {
//    func validated(_ value: String) throws -> String {
//        do {
//            if try NSRegularExpression(pattern: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$", options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
//                throw ValidationError("Worng Email Format")
//            }
//        } catch {
//            throw ValidationError("Worng Email Format")
//        }
//        return value
//    }
//}
//extension String {
//    var containsWhitespace : Bool {
//        return(self.rangeOfCharacter(from: .whitespacesAndNewlines) != nil)
//    }
//}
