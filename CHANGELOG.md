# Changelog

All notable changes to this project will be documented in this file.

## [1.2.0] - 2026-06-01 - Dark Mode

### Added
- Dark mode completa: `AdaptiveApp` accetta ora `darkTheme` (`AdaptiveThemeData`) e `themeMode` (`ThemeMode.system` di default). I token della modalità attiva vengono propagati ai widget `Adaptive*` e commutano automaticamente al variare della luminosità di sistema (Material e Cupertino).
- Nuova classe `AdaptiveThemeData` che raggruppa palette, font e stili dei componenti in un unico set di token per modalità (con `copyWith` e i default `AdaptiveThemeData.light` / `AdaptiveThemeData.dark`).
- `AdaptiveApp.theme`: tema chiaro completo come alternativa ai singoli parametri.
- Default per la dark mode: `ThemeColors.defaultDarkColors`, `InputStyles.defaultDarkStyles`.
- `copyWith` su `ThemeColors` e `InputStyles`; `AdaptiveThemeProvider.dataOf` e i getter `data`/`brightness`.
- `AdaptiveTextField`/`AdaptiveFormField`: parametro `style` per il testo digitato (default `bodyMedium` del tema).

### Changed
- `AdaptiveThemeProvider` ora incapsula un `AdaptiveThemeData`; i getter `colors`, `textTheme`, `spacing`, ecc. restano disponibili (retrocompatibile).
- `TextField`/`TextFormField` (Material e Cupertino): se non specificato, il `fillColor` usa il `surface` del tema; testo di default `bodyMedium`.
- `AdaptiveAppBar`: se non specificati, sfondo = `surface` e testo/icone = `onSurface` del tema; nuovo parametro `foregroundColor`.

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