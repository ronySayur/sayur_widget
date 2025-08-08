# Project Structure

## Root Directory Layout
```
sayur_widget/
├── lib/                    # Main source code
├── assets/                 # Static assets
├── .dart_tool/            # Dart tooling cache
├── .git/                  # Git repository
├── .kiro/                 # Kiro AI assistant configuration
├── pubspec.yaml           # Package configuration
├── README.md              # Package documentation
├── CHANGELOG.md           # Version history
├── LICENSE                # Package license
└── analysis_options.yaml  # Linting configuration
```

## Library Structure (`lib/`)

### Core Architecture
- **`sayur_core.dart`** - Main export file that re-exports all package components
- **`sayur_constant.dart`** - Global constants, colors, enums, and design tokens
- **`sayur_extension.dart`** - Dart extensions for common operations

### Feature Modules
- **`sayur_widget.dart`** - UI widget components (3000+ lines, main widget library)
- **`sayur_function.dart`** - Utility functions and helpers
- **`sayur_model.dart`** - Data models and structures
- **`sayur_api.dart`** - API integration utilities
- **`sayur_routing.dart`** - Navigation and routing helpers
- **`sayur_sharepref.dart`** - SharedPreferences wrapper
- **`sayur_permission.dart`** - Permission handling utilities
- **`sayur_google.dart`** - Google services integration
- **`sayur_main.dart`** - Main application setup utilities

## Asset Organization (`assets/`)
```
assets/
└── json/
    ├── loading.json    # Loading animation
    ├── success.json    # Success animation
    └── failed.json     # Error animation
```

## Naming Conventions

### Widget Naming
- All custom widgets prefixed with `Yur` (e.g., `YurText`, `YurButton`, `YurForm`)
- Follows PascalCase for class names
- Descriptive and consistent naming pattern

### Constants & Variables
- Colors: Material color swatches (e.g., `primaryRed`, `secondaryYellow`)
- Spacing: Consistent gap and padding constants (e.g., `gap4`, `e12`, `br16`)
- Enums: Descriptive enum names (e.g., `SizeTextField`, `LottieEnum`, `BStyle`)

### File Organization
- Single responsibility: Each file focuses on specific functionality
- Logical grouping: Related utilities grouped together
- Export pattern: Main exports through `sayur_core.dart`

## Code Organization Patterns

### Widget Structure
- Consistent parameter ordering: required params first, optional with defaults
- Comprehensive customization options for styling
- Built-in validation and error handling
- Indonesian locale defaults where applicable

### Constants Structure
- Material Design color palettes
- Consistent spacing system (4px increments)
- Predefined border radius values
- Gap and padding shortcuts for rapid development

### Extension Pattern
- DateTime formatting and parsing utilities
- String validation and transformation
- Currency formatting (Rupiah/Dollar)
- Type conversion helpers

## Development Guidelines

### Import Organization
- Flutter framework imports first
- Third-party package imports
- Local package imports last
- Alphabetical ordering within groups

### Code Style
- Uses `flutter_lints` for consistent formatting
- Comprehensive parameter documentation
- Null safety throughout
- Consistent error handling patterns
