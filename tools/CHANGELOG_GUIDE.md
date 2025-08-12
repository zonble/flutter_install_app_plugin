# Changelog Maintenance Guide

This guide explains how to maintain the rich changelog format for this Flutter plugin.

## Changelog Format

The changelog follows Flutter's best practices and the [Keep a Changelog](https://keepachangelog.com/) format:

- **Version headers** with dates: `## [0.8.0] - 2025-05-28`
- **Categorized changes** using standard sections:
  - `### BREAKING CHANGES` - Breaking changes that require user action
  - `### Added` - New features and functionality
  - `### Changed` - Changes in existing functionality
  - `### Fixed` - Bug fixes
  - `### Deprecated` - Features that will be removed in future versions
  - `### Removed` - Features removed in this version
  - `### Security` - Security-related changes
  - `### Performance` - Performance improvements
  - `### Documentation` - Documentation updates
  - `### Testing` - Test-related changes
  - `### Dependencies` - Dependency updates
  - `### Technical` - Technical/internal changes

## Manual Changelog Updates

When manually updating the changelog:

1. **Add platform prefixes** for platform-specific changes:
   - `**Android**:` for Android-specific changes
   - `**iOS**:` for iOS-specific changes  
   - `**Web**:` for web-specific changes

2. **Use consistent formatting**:
   - Each entry starts with `-` (bullet point)
   - Use `**BREAKING**:` prefix for breaking changes
   - Capitalize the first letter of each entry
   - Be descriptive but concise

3. **Include context** when helpful:
   - Mention specific technologies (e.g., "Gradle 8.7.0")
   - Explain the impact of changes
   - Reference important concepts (e.g., "AndroidX", "null safety")

## Automated Changelog Generation

Use the provided script to generate changelog entries from git commits:

```bash
# Generate changelog for unreleased commits
python3 tools/generate_changelog.py

# Generate changelog for a specific version
python3 tools/generate_changelog.py "0.9.0"

# Generate changelog since a specific tag
python3 tools/generate_changelog.py "0.9.0" "0.8.0"
```

### Commit Message Conventions

For best results with automated generation, use conventional commit format:

- `feat:` or `feature:` for new features
- `fix:` or `bug:` for bug fixes
- `docs:` for documentation changes
- `style:` for code style changes
- `refactor:` for code refactoring
- `perf:` for performance improvements
- `test:` for test changes
- `chore:` for maintenance tasks
- `deps:` for dependency updates
- `build:` for build system changes
- `ci:` for CI/CD changes

### Breaking Changes

Mark breaking changes by:
- Including "BREAKING" or "breaking" in the commit message
- Using `!` after the type (e.g., `feat!:`)

### Platform-Specific Changes

Include platform names in commit messages:
- "android: update gradle version"
- "ios: add new app store parameters"  
- "web: implement web support"

## Examples

### Good Changelog Entries

```markdown
### Added
- **iOS**: New `closeProductViewController` method for programmatically dismissing the App Store view
- **Web**: Flutter Web platform support with cross-platform compatibility

### Changed
- **BREAKING**: Updated minimum Flutter version requirement to support Flutter 3.32.0
- **Android**: Upgraded build system to Gradle 8.7.0 for improved performance and security

### Fixed
- **iOS**: Fixed memory leak in SKStoreProductViewController
- **Android**: Resolved crash when app store is not available
```

### Good Commit Messages

```
feat(ios): add closeProductViewController method
fix(android): resolve crash when store unavailable  
feat!: upgrade to flutter 3.32.0
docs: update readme with new ios parameters
chore(deps): upgrade gradle to 8.7.0
```

## Best Practices

1. **Update the changelog** with every release
2. **Keep entries focused** - one concept per bullet point
3. **Be user-focused** - explain the impact, not just the technical change
4. **Use consistent terminology** throughout the changelog
5. **Include dates** for all releases
6. **Group related changes** under appropriate categories
7. **Review and edit** generated entries for clarity and consistency