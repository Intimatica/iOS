//  Developed by Neosus UAB

import Foundation
import Amplitude
import FBSDKCoreKit

class EventLogger {
    class func logEvent(_ eventName: String!) {
        Amplitude.instance().logEvent(eventName)
        AppEvents.shared.logEvent(AppEvents.Name(eventName))
    }
    
    class func logEvent(_ eventName: String!, _ params: [String:Any]) {
        Amplitude.instance().logEvent(eventName, withEventProperties: params)
        let fbParams = Dictionary(uniqueKeysWithValues:
                                    params.map({ (key: String, value: Any) in
            (AppEvents.ParameterName(key), value)
        }))
        AppEvents.shared.logEvent( AppEvents.Name(eventName), parameters: fbParams)
    }
}
