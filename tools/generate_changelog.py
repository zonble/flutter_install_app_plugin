#!/usr/bin/env python3
"""
Generate changelog entries from git commits for Flutter packages.
This script helps maintain a rich changelog following Flutter's best practices.
"""

import subprocess
import re
import sys
from datetime import datetime
from typing import List, Dict, Tuple


class ChangelogGenerator:
    def __init__(self):
        self.categories = {
            'breaking': '### BREAKING CHANGES',
            'feat': '### Added',
            'feature': '### Added',
            'fix': '### Fixed',
            'bug': '### Fixed',
            'docs': '### Documentation',
            'style': '### Changed',
            'refactor': '### Changed',
            'perf': '### Performance',
            'test': '### Testing',
            'chore': '### Technical',
            'deps': '### Dependencies',
            'build': '### Technical',
            'ci': '### Technical',
        }

    def get_commits_since_tag(self, tag: str = None) -> List[Dict]:
        """Get all commits since the specified tag (or all if no tag)."""
        if tag:
            cmd = f"git log {tag}..HEAD --format='%H|%ci|%s|%b' --no-merges"
        else:
            cmd = "git log --format='%H|%ci|%s|%b' --no-merges -n 20"
        
        try:
            result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
            if result.returncode != 0:
                print(f"Error running git command: {result.stderr}")
                return []
            
            commits = []
            for line in result.stdout.strip().split('\n'):
                if '|' in line:
                    parts = line.split('|', 3)
                    if len(parts) >= 3:
                        commits.append({
                            'hash': parts[0],
                            'date': parts[1],
                            'subject': parts[2],
                            'body': parts[3] if len(parts) > 3 else ''
                        })
            return commits
        except Exception as e:
            print(f"Error getting commits: {e}")
            return []

    def categorize_commit(self, commit: Dict) -> Tuple[str, str]:
        """Categorize a commit and return category and formatted message."""
        subject = commit['subject'].lower()
        body = commit['body'].lower()
        
        # Check for breaking changes
        if 'breaking' in subject or 'breaking' in body or subject.startswith('!'):
            return 'breaking', self._format_breaking_change(commit)
        
        # Check conventional commit patterns
        for prefix, category in self.categories.items():
            if subject.startswith(f"{prefix}:") or subject.startswith(f"{prefix}("):
                return prefix, self._format_commit_message(commit, prefix)
        
        # Platform-specific categorization
        if any(platform in subject for platform in ['android', 'ios', 'web']):
            return 'platform', self._format_platform_change(commit)
        
        # Default to technical changes
        return 'chore', self._format_commit_message(commit, 'chore')

    def _format_breaking_change(self, commit: Dict) -> str:
        """Format a breaking change entry."""
        subject = commit['subject']
        # Remove conventional commit prefix if present
        subject = re.sub(r'^[a-z]+(\(.+\))?!?:\s*', '', subject, flags=re.IGNORECASE)
        return f"- **BREAKING**: {subject.capitalize()}"

    def _format_platform_change(self, commit: Dict) -> str:
        """Format a platform-specific change."""
        subject = commit['subject']
        
        # Extract platform
        platform = None
        for p in ['android', 'ios', 'web']:
            if p in subject.lower():
                platform = p.upper() if p != 'ios' else 'iOS'
                break
        
        # Remove conventional commit prefix if present
        subject = re.sub(r'^[a-z]+(\(.+\))?!?:\s*', '', subject, flags=re.IGNORECASE)
        
        if platform:
            return f"- **{platform}**: {subject.capitalize()}"
        else:
            return f"- {subject.capitalize()}"

    def _format_commit_message(self, commit: Dict, category: str) -> str:
        """Format a regular commit message."""
        subject = commit['subject']
        
        # Remove conventional commit prefix if present
        subject = re.sub(r'^[a-z]+(\(.+\))?!?:\s*', '', subject, flags=re.IGNORECASE)
        
        return f"- {subject.capitalize()}"

    def generate_changelog_section(self, version: str, commits: List[Dict]) -> str:
        """Generate a changelog section for the given commits."""
        if not commits:
            return ""
        
        # Get the latest commit date
        latest_date = commits[0]['date'][:10] if commits else datetime.now().strftime('%Y-%m-%d')
        
        # Categorize commits
        categorized = {}
        for commit in commits:
            category, message = self.categorize_commit(commit)
            
            # Map category to section header
            section = self.categories.get(category, '### Technical')
            
            if section not in categorized:
                categorized[section] = []
            categorized[section].append(message)
        
        # Build changelog section
        changelog = [f"## [{version}] - {latest_date}", ""]
        
        # Order sections by importance
        section_order = [
            '### BREAKING CHANGES',
            '### Added',
            '### Changed', 
            '### Fixed',
            '### Deprecated',
            '### Removed',
            '### Security',
            '### Performance',
            '### Documentation',
            '### Testing',
            '### Dependencies',
            '### Technical'
        ]
        
        for section in section_order:
            if section in categorized:
                changelog.append(section)
                for message in sorted(set(categorized[section])):
                    changelog.append(message)
                changelog.append("")
        
        return '\n'.join(changelog)

    def get_latest_tag(self) -> str:
        """Get the latest git tag."""
        try:
            result = subprocess.run(
                "git describe --tags --abbrev=0", 
                shell=True, capture_output=True, text=True
            )
            if result.returncode == 0:
                return result.stdout.strip()
        except Exception:
            pass
        return None


def main():
    generator = ChangelogGenerator()
    
    if len(sys.argv) > 1:
        if sys.argv[1] == '--help' or sys.argv[1] == '-h':
            print("Usage: generate_changelog.py [version] [since_tag]")
            print("  version: The version number for the new changelog entry")
            print("  since_tag: Generate changelog since this tag (optional)")
            print("  If no arguments provided, generates from recent commits")
            return
        
        version = sys.argv[1]
        since_tag = sys.argv[2] if len(sys.argv) > 2 else generator.get_latest_tag()
    else:
        version = "Unreleased"
        since_tag = generator.get_latest_tag()
    
    commits = generator.get_commits_since_tag(since_tag)
    
    if not commits:
        print("No commits found to generate changelog from.")
        return
    
    changelog_section = generator.generate_changelog_section(version, commits)
    print(changelog_section)


if __name__ == "__main__":
    main()