# Change Log

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.8.0] - 2025-05-28

### Changed
- **BREAKING**: Updated minimum Flutter version requirement to support Flutter 3.32.0
- Improved compatibility with latest Flutter framework features

### Technical
- Updated dependencies to support Flutter 3.32.0
- Enhanced SDK compatibility

## [0.7.0] - 2024-12-15

### Changed
- **Android**: Upgraded build system to Gradle 8.7.0 for improved performance and security
- Enhanced build reliability and compatibility with latest Android development tools

### Technical
- Updated Gradle wrapper to version 8.7.0
- Improved build configuration for better compatibility

## [0.6.0] - 2024-10-01

### Changed
- **BREAKING**: Migrated Android implementation to Android Embedding V2
- Improved plugin architecture for better Flutter integration
- Enhanced performance and stability on Android platform

### Technical
- Replaced deprecated Android Embedding V1 with V2
- Updated Android plugin implementation for modern Flutter standards

## [0.4.2-nullsafety.0] - 2021-03-15

### Added
- **Dart**: Full null safety support for improved type safety
- Migration to null-aware type system

### Technical
- Updated codebase to support Dart null safety
- Enhanced type checking and runtime safety

## [0.4.2] - 2020-11-20

### Added
- **iOS**: New `closeProductViewController` method for programmatically dismissing the App Store view
- Enhanced control over the iOS App Store presentation lifecycle

### Technical
- Added method to close SKStoreProductViewController programmatically

## [0.4.1] - 2020-09-15

### Added
- **Web**: Flutter Web platform support
- Cross-platform compatibility extended to web browsers

### Technical
- Implemented web plugin interface
- Added web-specific app installation handling

## [0.4.0] - 2020-06-10

### Added
- **iOS**: Enhanced App Store integration with new optional parameters:
  - `iosIapId`: Product identifier for promoted in-app purchases
  - `iosAffiliateToken`: Affiliate program integration
  - `iosCampaignToken`: App Analytics campaign tracking
  - `iosAdvertisingPartnerToken`: Advertising partner specification
  - `iosProviderToken`: Developer provider token

### Changed
- **Android**: Updated example application with improved user interface and functionality
- Enhanced documentation for new iOS parameters

### Technical
- Extended iOS implementation with SKStoreProductViewController parameters
- Improved example app to demonstrate new features

## [0.3.0] - 2020-03-20

### Changed
- **iOS**: Updated Xcode project to latest version for improved compatibility
- **iOS**: Defined Clang module configuration to support static library builds

### Technical
- Enhanced iOS build configuration
- Improved module definition for better integration

## [0.2.1] - 2020-01-15

### Changed
- **BREAKING**: Migrated to AndroidX for modern Android development standards
- Updated all Android dependencies to AndroidX equivalents

### Technical
- Replaced legacy Android Support Library with AndroidX
- Updated Gradle configuration for AndroidX compatibility

## [0.2.0] - 2019-11-10

### Changed
- **Android**: Updated build configuration and settings for improved compatibility
- Enhanced Android build process for better reliability

### Technical
- Improved Gradle build settings
- Updated Android plugin configuration

## [0.1.2] - 2019-09-05

### Changed
- **Android**: Further improvements to build settings and configuration
- Enhanced stability and compatibility

### Technical
- Refined Android build configuration
- Improved plugin integration

## [0.1.1] - 2019-08-20

### Changed
- Cleaned up repository by removing unnecessary and undesired files
- Improved project structure and maintainability

### Technical
- Repository cleanup and organization
- Removed build artifacts and temporary files

## [0.1.0] - 2019-08-01

### Added
- 🎉 **Initial release** of Flutter Install App Plugin
- **iOS**: App Store integration using SKStoreProductViewController
- **Android**: Google Play Store integration using market:// URLs
- Cross-platform API for installing apps from their respective stores
- Support for iOS App Store and Android Google Play Store

### Features
- Simple API for app installation across platforms
- Native store integration for seamless user experience
- Comprehensive example application demonstrating usage

### Technical
- Initial plugin architecture and implementation
- Cross-platform Flutter plugin structure
- Native iOS and Android implementations
