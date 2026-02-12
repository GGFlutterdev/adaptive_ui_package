# Adaptive UI

Un package Flutter completo per creare interfacce utente adaptive che si adattano automaticamente tra Material Design (Android) e Cupertino (iOS).

## Features

✨ **Widget Adattivi**: Oltre 15 widget che scelgono automaticamente tra Material e Cupertino in base alla piattaforma
🎨 **Tema Configurabile**: Sistema di temi flessibile con supporto per colori, tipografia, stili di bottoni e input
📱 **Cross-Platform**: Funziona perfettamente su iOS e Android
🚀 **Facile da Usare**: API semplice e intuitiva

## Widget Supportati

| Widget Adattivo | Material | Cupertino |
|----------------|----------|-----------|
| `AdaptiveApp` | `MaterialApp` | `CupertinoApp` |
| `AdaptiveScaffold` | `Scaffold` | `CupertinoPageScaffold` |
| `AdaptiveAppBar` | `AppBar` | `CupertinoNavigationBar` |
| `AdaptiveButton` | `ElevatedButton` | `CupertinoButton` |
| `AdaptiveTextButton` | `TextButton` | `CupertinoButton` |
| `AdaptiveIconButton` | `IconButton` | `CupertinoButton` |
| `AdaptiveTextField` | `TextField` | `CupertinoTextField` |
| `AdaptiveTextFormField` | `TextFormField` | `CupertinoTextFormFieldRow` |
| `AdaptiveSwitch` | `Switch.adaptive` | `Switch.adaptive` |
| `AdaptiveSlider` | `Slider` | `CupertinoSlider` |
| `AdaptiveListTile` | `ListTile` | `CupertinoListTile` |
| `AdaptiveAlertDialog` | `AlertDialog` | `CupertinoAlertDialog` |
| `AdaptiveProgressIndicator` | `CircularProgressIndicator` | `CupertinoActivityIndicator` |
| `AdaptiveBottomNavBar` | `BottomNavigationBar` | `CupertinoTabBar` |
| `AdaptiveTabScaffold` | `Scaffold` + `BottomNavigationBar` | `CupertinoTabScaffold` |
| `AdaptiveDropdown` | `DropdownButton` | `CupertinoPicker` (in modal) |

## Installazione

Aggiungi questa dipendenza al tuo file `pubspec.yaml`:

```yaml
dependencies:
  adaptive_ui: ^1.0.0
```

Poi esegui:

```bash
flutter pub get
```

## Uso Base

### 1. Configurare l'App

```dart
import 'package:adaptive_ui/adaptive_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveApp(
      title: 'My App',
      colors: ThemeColors(
        primary: Color(0xFF6200EE),
        onPrimary: Colors.white,
        secondary: Color(0xFF03DAC6),
        onSecondary: Colors.black,
        background: Colors.white,
        surface: Colors.white,
        error: Color(0xFFB00020),
      ),
      home: HomePage(),
    );
  }
}
```

### 2. Usare i Widget Adattivi

```dart
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      appBar: AdaptiveAppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AdaptiveButton(
              onPressed: () {
                print('Pressed!');
              },
              child: Text('Click Me'),
            ),
            SizedBox(height: 20),
            AdaptiveTextField(
              placeholder: 'Enter text',
            ),
          ],
        ),
      ),
    );
  }
}
```

### 3. Personalizzare il Tema

```dart
AdaptiveApp(
  title: 'My App',
  colors: ThemeColors(
    primary: Colors.blue,
    onPrimary: Colors.white,
    secondary: Colors.orange,
    onSecondary: Colors.black,
    background: Colors.grey[100]!,
    surface: Colors.white,
    error: Colors.red,
  ),
  textTheme: TextThemeConfig(
    fontFamily: 'Montserrat',
    headline: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
    body: TextStyle(fontSize: 16),
    caption: TextStyle(fontSize: 12),
    button: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
  ),
  spacing: Spacing(
    xs: 4,
    sm: 8,
    md: 16,
    lg: 24,
    xl: 32,
  ),
  home: HomePage(),
)
```

## Esempi Avanzati

### Dialog Adattivo

```dart
AdaptiveAlertDialog.show(
  context: context,
  title: Text('Conferma'),
  content: Text('Sei sicuro di voler continuare?'),
  actions: [
    AdaptiveDialogAction(
      child: Text('Annulla'),
      onPressed: () => Navigator.pop(context),
    ),
    AdaptiveDialogAction(
      child: Text('Conferma'),
      isDefaultAction: true,
      onPressed: () {
        Navigator.pop(context);
        // Azione confermata
      },
    ),
  ],
);
```

### Action Sheet

```dart
AdaptiveActionSheet.show(
  context: context,
  title: 'Seleziona azione',
  actions: [
    AdaptiveActionSheetItem(
      label: 'Modifica',
      onPressed: () {
        // Azione modifica
      },
      icon: Icon(Icons.edit),
    ),
    AdaptiveActionSheetItem(
      label: 'Elimina',
      isDestructive: true,
      onPressed: () {
        // Azione elimina
      },
      icon: Icon(Icons.delete),
    ),
  ],
  cancelLabel: 'Annulla',
);
```

### Date Picker

```dart
final date = await AdaptiveDatePicker.showDatePicker(
  context: context,
  initialDate: DateTime.now(),
  firstDate: DateTime(2020),
  lastDate: DateTime(2030),
);
```

### Dropdown

```dart
AdaptiveDropdown<String>(
  value: selectedValue,
  hint: 'Seleziona un'opzione',
  items: [
    AdaptiveDropdownItem(value: 'option1', label: 'Opzione 1'),
    AdaptiveDropdownItem(value: 'option2', label: 'Opzione 2'),
    AdaptiveDropdownItem(value: 'option3', label: 'Opzione 3'),
  ],
  onChanged: (value) {
    setState(() {
      selectedValue = value;
    });
  },
)
```

### Tab Navigation

```dart
AdaptiveTabScaffold(
  tabItems: [
    AdaptiveBottomNavItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    AdaptiveBottomNavItem(
      icon: Icon(Icons.search),
      label: 'Search',
    ),
    AdaptiveBottomNavItem(
      icon: Icon(Icons.person),
      label: 'Profile',
    ),
  ],
  children: [
    HomePage(),
    SearchPage(),
    ProfilePage(),
  ],
)
```

## Accedere al Tema

Puoi accedere alle configurazioni del tema in qualsiasi punto dell'app:

```dart
final theme = AdaptiveThemeProvider.of(context);

// Usa i colori
Container(
  color: theme.colors.primary,
)

// Usa gli spacing
Padding(
  padding: EdgeInsets.all(theme.spacing.md),
)

// Usa gli stili di testo
Text(
  'Titolo',
  style: theme.textTheme.headline,
)
```

## Licenza

MIT License - vedi il file LICENSE per i dettagli.

## Contribuire

I contributi sono benvenuti! Sentiti libero di aprire issue o pull request.
