// MARK: Keys

public let USER_DEFAULTS_KEY = "SharedCharacterUserDefault"
public let INPUT_EVENT_KEY = "input"
public let URL_SCHEME_INFO_PLIST_KEY = "AppURLScheme"
public let HOST_APP_IDENTIFIER_INFO_PLIST_KEY = "HostAppBundleIdentifier"
public let HOST_URL_SCHEME_INFO_PLIST_KEY = "HostAppURLScheme"

// MARK: Error Messages

public let NO_URL_TYPES_ERROR_MESSAGE = "You have not defined CFBundleURLName in your Info.plist"
public let NO_BUNDLE_ID_ERROR_MESSAGE = "You have not defined CFBundleURLSchemes in your Info.plist"
public let NO_URL_SCHEMES_ERROR_MESSAGE = "You have not defined CFBundleURLSchemes in your Info.plist"
public let NO_SCHEME_ERROR_MESSAGE = "You have not defined a scheme under CFBundleURLSchemes in your Info.plist"
public let NO_APP_GROUP_ERROR = "Failed to get App Group User Defaults. Did you set up an App Group on your App and Share Extension?"
public let NO_INFO_PLIST_INDENTIFIER_ERROR = "You haven't defined \(HOST_APP_IDENTIFIER_INFO_PLIST_KEY) in your Share Extension's Info.plist"
public let NO_INFO_PLIST_URL_SCHEME_ERROR = "You haven't defined \(HOST_URL_SCHEME_INFO_PLIST_KEY) in your Share Extension's Info.plist"
public let NO_INPUT_ERROR = "NO_INPUT_ERROR"
public let COULD_NOT_FIND_STRING_ERROR = "Couldn't find string"
public let COULD_NOT_FIND_URL_ERROR = "Couldn't find url"
public let COULD_NOT_FIND_IMG_ERROR = "Couldn't find image"
public let COULD_NOT_PARSE_IMG_ERROR = "Couldn't parse image"
public let COULD_NOT_SAVE_FILE_ERROR = "Couldn't save file on disk"
public let NO_EXTENSION_CONTEXT_ERROR = "No extension context attached"
public let NO_INPUT_DATA_ERROR = "No input data in UserDefaults with key \(USER_DEFAULTS_KEY)"
public let NO_DELEGATE_ERROR = "No ReactShareViewDelegate attached"
public let COULD_NOT_FIND_ITEMS_ERROR = "Couldn't find items attached to this share"

// MARK: Events
public let SYNC_INPUT_EVENT = "syncInputEvent"
