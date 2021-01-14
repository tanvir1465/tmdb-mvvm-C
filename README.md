# TMDM API implementations with RxSwift using MVVM-C architecture

#### Features
- Supports iOS and iPadOS
- Dark mode
- Structural representation of MVVM-C architecture
- Reusable codes
- Modular structure
- Separate networking layer
- 100% programmatic layout

#### Requirement
- iOS and iPadOS 13 or later

#### SCOPE OF IMPROVEMENTS:
  - Data binding in detail controllers (both for mvoies and shows) is handled in non rx way
  - Network loading indicators and network errors are moderately handled, scope for bulletproof error handling
  - presenting detail view controller from search list is not handled by coordinators but in conventional apple MVC structure
  - Unit tests