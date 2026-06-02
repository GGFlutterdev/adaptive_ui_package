# Changelog

All notable changes to this project will be documented in this file.

## [1.3.1] - 2026-06-02 - Tooltip su AdaptiveIconButton

### Added
- `AdaptiveIconButton.tooltip`: nuovo parametro opzionale. Su Material viene inoltrato a `IconButton.tooltip`; su iOS il `CupertinoButton` viene avvolto in un `Tooltip` (solo se valorizzato, dato che Cupertino non ha un tooltip nativo).

### Compatibility
- Retro-compatibilità totale: il parametro è opzionale e non modifica il comportamento esistente.

## [1.3.0] - 2026-06-02 - Supporto Navigator 2.0 / router

### Added
- `AdaptiveApp.router({ required routerConfig, ... })`: nuovo costruttore per Navigator 2.0 / router (es. `go_router`). Accetta un `RouterConfig<Object>` (soddisfatto da un `GoRouter`) e costruisce internamente `MaterialApp.router` (Android) o `CupertinoApp.router` (iOS).
- `AdaptiveApp.routerConfig`: nuovo campo opzionale che espone la configurazione del router.

### Changed
- `AdaptiveApp.home` è ora opzionale (`Widget?`): resta `required` nel costruttore di default ma può essere omesso usando `AdaptiveApp.router`. Un `assert` garantisce che venga fornito esattamente uno tra `home` e `routerConfig`.
- Tutto il theming (light/dark, `themeMode`, color theming), la localizzazione (`localizationsDelegates`, `supportedLocales`, `locale`), il `title`, il `debugShowCheckedModeBanner` e il wrapper `AdaptiveThemeProvider` vengono inoltrati identici sia nel ramo `home`/`routes` sia nel ramo `routerConfig`.

### Compatibility
- Retro-compatibilità totale: il codice esistente che usa `AdaptiveApp(home: ..., routes: ...)` continua a compilare e funzionare identico.

## [1.2.1] - 2026-06-01 - Fix localizzazioni Material su iOS

### Fixed
- I widget Material aperti come route su iOS (`showDialog`, `showModalBottomSheet`, i selection controls dei `TextField`, ecc.) non vanno più in crash con "No MaterialLocalizations found": la `CupertinoApp` interna accoda ora `DefaultMaterialLocalizations`, `DefaultCupertinoLocalizations` e `DefaultWidgetsLocalizations`.
- Gli `SnackBar` Material funzionano anche su iOS: la `CupertinoApp` ora monta uno `ScaffoldMessenger` sopra il Navigator radice (come fa automaticamente `MaterialApp`).

### Added
- `AdaptiveApp` espone `localizationsDelegates`, `supportedLocales` e `locale`, inoltrati a entrambi i rami (Material e Cupertino). Nel ramo Cupertino i delegate del consumer vengono accodati ai default.

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