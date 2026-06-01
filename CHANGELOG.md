# Changelog

All notable changes to this project will be documented in this file.

## [1.1.0] - 2026-06-01 - Aggiornamento Stile iOS

### Fixed
- `AdaptiveScaffold` non lancia più `type 'AdaptiveAppBar' is not a subtype of type 'CupertinoNavigationBar?'` su iOS: la navigation bar Cupertino viene ora costruita correttamente invece di essere castata.

### Added
- `AdaptiveScaffold` ora supporta `bottomNavigationBar` e `floatingActionButton` anche su iOS (impaginati dentro `CupertinoPageScaffold`).
- `AdaptiveAppBar.buildCupertinoNavigationBar()` e `buildMaterialAppBar()` per costruire il widget di piattaforma.
- `AdaptiveThemeProvider.maybeOf`, `colorsOf`, `inputStylesOf`, `cupertinoButtonStylesOf`, `textThemeOf`: accessor null-safe con fallback ai default (i widget funzionano anche senza `AdaptiveApp`).
- `InputStyles.fillColor` e `InputStyles.toCupertinoDecoration()` per derivare la decorazione dei campi su iOS.

### Changed
- Theming coerente su iOS: i widget Cupertino (`AdaptiveTextField`, `AdaptiveFormField`, `AdaptiveButton` e varianti, `AdaptiveSlider`, `AdaptiveSwitch`, `AdaptiveProgressIndicator`, `AdaptiveDropdown`) rispettano ora `ThemeColors` e `InputStyles` invece di usare colori/stili hardcoded.

## [1.0.0] - 2026-02-12

### Added
- Initial release
- AdaptiveApp widget (MaterialApp / CupertinoApp)
- AdaptiveScaffold widget (Scaffold / CupertinoPageScaffold)
- AdaptiveAppBar widget (AppBar / CupertinoNavigationBar)
- AdaptiveButton, AdaptiveTextButton, AdaptiveIconButton widgets
- AdaptiveTextField widget (TextField / CupertinoTextField)
- AdaptiveSwitch widget (always adaptive)
- AdaptiveSlider widget (Slider / CupertinoSlider)
- AdaptiveListTile widget (ListTile / CupertinoListTile)
- AdaptiveAlertDialog widget (AlertDialog / CupertinoAlertDialog)
- AdaptiveProgressIndicator widget (CircularProgressIndicator / CupertinoActivityIndicator)
- AdaptiveBottomNavBar and AdaptiveTabScaffold widgets
- AdaptiveDatePicker and AdaptiveTimePicker utilities
- AdaptiveActionSheet and AdaptiveModalBottomSheet utilities
- AdaptiveDropdown widget (DropdownButton / CupertinoPicker)
- Complete theme configuration system (ThemeColors, TextThemeConfig, ButtonStyles, etc.)
- AdaptiveThemeProvider for accessing theme throughout the app
- Comprehensive documentation and examples