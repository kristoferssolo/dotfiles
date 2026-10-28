import Carbon
import Foundation

let name = "Solo Layout"
let bundleID = "com.kristians.keyboardlayout.SoloLayout"
let sourceID = bundleID + ".keylayout.SoloLayout"
func property(_ source: TISInputSource, _ key: CFString) -> String {
    guard let raw = TISGetInputSourceProperty(source, key) else { return "" }
    return Unmanaged<CFString>.fromOpaque(raw).takeUnretainedValue() as String
}

let usFilter = [kTISPropertyInputSourceID as String: "com.apple.keylayout.US"] as CFDictionary
let sources = TISCreateInputSourceList(usFilter, true).takeRetainedValue() as! [TISInputSource]
guard let us = sources.first, let raw = TISGetInputSourceProperty(us, kTISPropertyUnicodeKeyLayoutData) else { fatalError("U.S. layout unavailable") }
let data = Unmanaged<CFData>.fromOpaque(raw).takeUnretainedValue()
let layout = UnsafeRawPointer(CFDataGetBytePtr(data)!).assumingMemoryBound(to: UCKeyboardLayout.self)
func translate(_ ptr: UnsafePointer<UCKeyboardLayout>, _ key: UInt16, _ mods: UInt32) -> (String, UInt32) {
    var state: UInt32 = 0; var len = 0; var chars = [UniChar](repeating: 0, count: 16)
    let rc = UCKeyTranslate(ptr, key, UInt16(kUCKeyActionDown), mods, UInt32(LMGetKbdType()), 0, &state, 16, &len, &chars)
    precondition(rc == noErr, "UCKeyTranslate failed")
    return (String(utf16CodeUnits: chars, count: len), state)
}

func base(_ key: UInt16, _ mods: UInt32) -> String {
    var state: UInt32 = 0; var len = 0; var chars = [UniChar](repeating: 0, count: 16)
    let rc = UCKeyTranslate(layout, key, UInt16(kUCKeyActionDown), mods, UInt32(LMGetKbdType()), OptionBits(kUCKeyTranslateNoDeadKeysMask), &state, 16, &len, &chars)
    precondition(rc == noErr)
    return String(utf16CodeUnits: chars, count: len)
}

func escaped(_ s: String) -> String {
    s.unicodeScalars.map { scalar in
        switch scalar.value {
        case 34, 38, 60, 62: return String(format: "&#x%04X;", scalar.value)
        case 0 ... 31: return String(format: "&#x%04X;", scalar.value)
        default: return String(scalar)
        }
    }.joined()
}

/// Linux lv(basic) AltGr levels; ordinary letters retain their QWERTY positions.
let alt: [UInt16: (String, String)] = [
    50: ("´", "~"), 18: ("¹", "¡"), 19: ("²", "⅛"), 20: ("³", "£"), 21: ("€", "¢"), 23: ("½", "⅜"), 22: ("¾", "⅝"),
    26: ("{", "⅞"), 28: ("[", "™"), 25: ("]", "±"), 29: ("}", "°"), 27: ("\\", "¿"), 24: ("–", "—"),
    14: ("ē", "Ē"), 15: ("ŗ", "Ŗ"), 32: ("ū", "Ū"), 34: ("ī", "Ī"), 31: ("ō", "Ō"), 33: ("«", "“"), 30: ("»", "”"),
    0: ("ā", "Ā"), 1: ("š", "Š"), 5: ("ģ", "Ģ"), 40: ("ķ", "Ķ"), 37: ("ļ", "Ļ"), 41: (";", ":"), 39: ("“", "„"),
    6: ("ž", "Ž"), 8: ("č", "Č"), 45: ("ņ", "Ņ"), 43: ("•", "×"), 47: ("·", "÷"), 44: ("/", "˙"), 42: ("`", "˘"), 49: (" ", " "),
]
let letters: Set<UInt16> = [0, 1, 5, 6, 8, 14, 15, 31, 32, 34, 37, 40, 45]
var xml = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<!DOCTYPE keyboard SYSTEM \"file://localhost/System/Library/DTDs/KeyboardLayout.dtd\">\n"
xml += "<!-- U.S. QWERTY with Linux Latvian AltGr characters. No dead keys or synthesized modifier shortcuts. -->\n"
xml += "<keyboard group=\"0\" id=\"16379\" name=\"\(name)\" maxout=\"16\">\n<layouts><layout first=\"0\" last=\"255\" modifiers=\"modifiers\" mapSet=\"maps\"/></layouts>\n<modifierMap id=\"modifiers\" defaultIndex=\"0\">\n"
for index in 0 ..< 32 {
    let names = ["anyShift", "caps", "anyOption", "anyControl", "command"]
    let keys = (0 ..< 5).filter { index & (1 << $0) != 0 }.map { names[$0] }.joined(separator: " ")
    xml += "<keyMapSelect mapIndex=\"\(index)\"><modifier keys=\"\(keys)\"/></keyMapSelect>\n"
}

xml += "</modifierMap>\n<keyMapSet id=\"maps\">\n"
for index in 0 ..< 32 {
    let shift = index & 1 != 0, caps = index & 2 != 0, option = index & 4 != 0, control = index & 8 != 0, command = index & 16 != 0
    let mods: UInt32 = (shift ? 2 : 0) | (caps ? 4 : 0) | (option ? 8 : 0) | (control ? 16 : 0) | (command ? 1 : 0)
    xml += "<keyMap index=\"\(index)\">\n"
    for key: UInt16 in 0 ... 127 {
        var value = base(key, mods)
        if option, !control, !command {
            value = base(key, mods & ~8)
            if let pair = alt[key] {
                let upper = letters.contains(key) ? shift != caps : shift
                value = upper ? pair.1 : pair.0
            }
        }
        xml += "<key code=\"\(key)\" output=\"\(escaped(value))\"/>\n"
    }
    xml += "</keyMap>\n"
}

xml += "</keyMapSet>\n</keyboard>\n"
let bundle = FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent("Library/Keyboard Layouts/SoloLayout.bundle", isDirectory: true)
let dir = bundle.appendingPathComponent("Contents/Resources", isDirectory: true)
try FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
let file = dir.appendingPathComponent(name + ".keylayout")
if FileManager.default.fileExists(atPath: file.path) {
    fatalError("Custom layout already exists; inspect it before replacing")
}

try xml.write(to: file, atomically: true, encoding: .utf8)
let info: [String: Any] = [
    "CFBundleIdentifier": bundleID, "CFBundleName": name, "CFBundleVersion": "1.0.0",
    "CFBundleShortVersionString": "1.0.0", "CFBundlePackageType": "BNDL", "CFBundleDevelopmentRegion": "en",
    "KLInfo_" + name: ["TISInputSourceID": sourceID, "TISIntendedLanguage": "lv"],
]
let plist = try PropertyListSerialization.data(fromPropertyList: info, format: .xml, options: 0)
try plist.write(to: bundle.appendingPathComponent("Contents/Info.plist"))
let registered = TISRegisterInputSource(bundle as CFURL)
precondition(registered == noErr, "Cannot register layout: \(registered)")
let filter = [kTISPropertyInputSourceID as String: sourceID] as CFDictionary
let all = TISCreateInputSourceList(filter, true).takeRetainedValue() as! [TISInputSource]
guard let custom = all.first, let customRaw = TISGetInputSourceProperty(custom, kTISPropertyUnicodeKeyLayoutData) else { fatalError("Registered layout not found") }
let customData = Unmanaged<CFData>.fromOpaque(customRaw).takeUnretainedValue()
let customLayout = UnsafeRawPointer(CFDataGetBytePtr(customData)!).assumingMemoryBound(to: UCKeyboardLayout.self)
let checks: [(UInt16, UInt32, String)] = [(20, 2, "#"), (39, 0, "'"), (39, 2, "\""), (26, 2, "&"), (43, 2, "<"), (47, 2, ">"), (50, 0, "`"), (50, 2, "~"), (21, 8, "€"), (26, 8, "{"), (28, 8, "["), (25, 8, "]"), (29, 8, "}"), (0, 8, "ā"), (0, 10, "Ā"), (8, 8, "č"), (14, 8, "ē"), (5, 8, "ģ"), (34, 8, "ī"), (40, 8, "ķ"), (37, 8, "ļ"), (45, 8, "ņ"), (1, 8, "š"), (32, 8, "ū"), (6, 8, "ž"), (36, 0, "\r"), (48, 0, "\t"), (53, 0, "\u{1b}"), (0, 16, "\u{01}")]
for (key, mods, expected) in checks {
    let (result, state) = translate(customLayout, key, mods)
    precondition(result == expected && state == 0, "key=\(key) mods=\(mods) expected=\(expected.debugDescription) got=\(result.debugDescription) dead=\(state)")
}

precondition(TISEnableInputSource(custom) == noErr)
print("Verified \(checks.count) native mappings, including Shift+3 without Option")
print("INPUT_SOURCE_ID=" + property(custom, kTISPropertyInputSourceID))
print("LAYOUT_PATH=" + file.path)
