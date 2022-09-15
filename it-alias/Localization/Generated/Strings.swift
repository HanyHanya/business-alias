// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum Strings {
  internal enum AddTeamView {
    /// Add Team
    internal static let addTeam = Strings.tr("Localizable", "AddTeamView.AddTeam", fallback: "Add Team")
  }
  internal enum Menu {
    /// Localization.strings
    ///   it-alias
    /// 
    ///   Created by Yushkevich Ilya on 26.08.22.
    internal static let play = Strings.tr("Localizable", "Menu.Play", fallback: "Play")
  }
  internal enum TeamView {
    /// Team
    internal static let teamName = Strings.tr("Localizable", "TeamView.TeamName", fallback: "Team")
  }
  internal enum Teams {
    /// Add Teams
    internal static let addTeams = Strings.tr("Localizable", "Teams.AddTeams", fallback: "Add Teams")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Strings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
