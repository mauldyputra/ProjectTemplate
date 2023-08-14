//
//  Profiles.swift
//  ProjectTemplate
//
//  Created by Mauldy Putra on 14/08/23.
//

import Foundation
import RealmSwift

class Profiles {
    static let userProfileKey = "user_profile"
    static let userDetailProfileKey = "user_detail_profile_key"
    static let isUserLogin = "user_already_login"
    
    static func setUser(/*_ user: AuthOTPResponse.User?*/) {
//        if let user = user {
//            UserDefaults.standard.set(user.toJSONString(), forKey: userProfileKey)
//        } else {
//            UserDefaults.standard.removeObject(forKey: userProfileKey)
//        }
    }
    
    static func getUser()/* -> AuthOTPResponse.User?*/ {
//        if let json = UserDefaults.standard.string(forKey: userProfileKey),
//            let model = AuthOTPResponse.User(JSONString: json) {
//            return model
//        }
//        return nil
    }
    
    static func setUserDetail(/*_ user: User?*/) {
//        if let user = user {
//            UserDefaults.standard.set(user.toJSONString(), forKey: userDetailProfileKey)
//        } else {
//            UserDefaults.standard.removeObject(forKey: userDetailProfileKey)
//        }
    }
    
    static func getUserDetail()/*id: Int? = Credentials.getAuth()?.userTada?.tadaAccountId) -> User?*/ {
//        // Get from userdefaults
//         if let json = UserDefaults.standard.string(forKey: userDetailProfileKey),
//            let user = User(JSONString: json) {
//            return user
//        }
//        // Get from database
//        guard let id = id else { return nil }
//        do {
//            let realm = try Realm()
//            if let user = Array(realm.objects(User.self)).filter({ $0.id == id }).first {
//                return user
//            }
//        } catch _ as NSError {
//            return nil
//        }
//        return nil
    }
    
    static func setUserLoginBool(/*_ userLogin: Bool*/) {
//        UserDefaults.standard.set(userLogin, forKey: isUserLogin)
    }
    
    static func userIsLoggin() -> Bool? {
//        if UserDefaults.standard.bool(forKey: isUserLogin) == false  {
//            return false
//        }
        return true
    }
    
    static func reset() {
//        setUser(nil)
//        setUserDetail(nil)
//        setUserLoginBool(false)
    }
}
