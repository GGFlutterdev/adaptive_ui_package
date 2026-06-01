import 'package:flutter/material.dart';
import 'package:platform_adaptive_ui/platform_adaptive_ui.dart';

void main() {
  runApp(const MyApp());
}

/// Root dell'app: qui si definisce lo stile UNA SOLA VOLTA.
///
/// `AdaptiveApp` crea internamente un `MaterialApp` su Android e un
/// `CupertinoApp` su iOS, e propaga il tema a tutti gli `Adaptive*` widget
/// tramite `AdaptiveThemeProvider`. Tutti i parametri di stile sono opzionali:
/// se omessi vengono usati i default del package.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveApp(
      title: 'Adaptive UI Example',
      colors: const ThemeColors(
        primary: Color(0xFF6200EE),
        onPrimary: Colors.white,
        secondary: Color(0xFF03DAC6),
        onSecondary: Colors.black,
        background: Colors.white,
        surface: Colors.white,
        error: Color(0xFFB00020),
      ),
      textTheme: const TextThemeConfig(
        fontFamily: 'Roboto',
        headline: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        body: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
        caption: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
        button: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
      // Gli input ora rispettano questi stili anche su iOS (1.1.0).
      inputStyles: InputStyles(
        label: const TextStyle(fontSize: 14, color: Colors.grey),
        hint: const TextStyle(fontSize: 14, color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF6200EE), width: 2),
        ),
        fillColor: const Color(0xFFF2F2F7),
      ),
      spacing: const Spacing(
        xs: 4.0,
        sm: 8.0,
        md: 16.0,
        lg: 24.0,
        xl: 32.0,
      ),
      // Tema scuro completo: palette, font e stili dedicati alla dark mode.
      // `themeMode: system` fa seguire automaticamente l'impostazione del
      // dispositivo. Gli `Adaptive*` widget commutano i colori di conseguenza.
      darkTheme: AdaptiveThemeData(
        colors: ThemeColors.defaultDarkColors,
        textTheme: const TextThemeConfig(
          fontFamily: 'Roboto',
          headline: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          body: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
          caption: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
          button: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        cupertinoButtonStyles: CupertinoButtonStyles.defaultStyles,
        inputStyles: InputStyles.defaultDarkStyles.copyWith(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.white24),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFBB86FC), width: 2),
          ),
        ),
        spacing: Spacing.defaultSpacing,
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.system,
      home: const ExampleHomePage(),
    );
  }
}

class ExampleHomePage extends StatefulWidget {
  const ExampleHomePage({Key? key}) : super(key: key);

  @override
  State<ExampleHomePage> createState() => _ExampleHomePageState();
}

class _ExampleHomePageState extends State<ExampleHomePage> {
  int _currentTab = 0;
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    final theme = AdaptiveThemeProvider.of(context);

    return AdaptiveScaffold(
      appBar: AdaptiveAppBar(
        title: const Text('Adaptive UI Demo'),
        actions: [
          AdaptiveIconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => _notify('Impostazioni'),
          ),
        ],
      ),
      // FAB e bottom nav ora funzionano sia su Android che su iOS (1.1.0).
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => _counter++),
        backgroundColor: theme.colors.primary,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: AdaptiveBottomNavBar(
        currentIndex: _currentTab,
        onTap: (index) => setState(() => _currentTab = index),
        items: const [
          AdaptiveBottomNavItem(icon: Icon(Icons.widgets), label: 'Widget'),
          AdaptiveBottomNavItem(icon: Icon(Icons.info_outline), label: 'Info'),
        ],
      ),
      body: IndexedStack(
        index: _currentTab,
        children: [
          _WidgetsTab(counter: _counter, onNotify: _notify),
          const _InfoTab(),
        ],
      ),
    );
  }

  /// Feedback cross-platform: usa un dialog adattivo invece di `SnackBar`,
  /// che richiederebbe un `Scaffold` Material e non funziona dentro
  /// `CupertinoApp` su iOS.
  void _notify(String message) {
    AdaptiveAlertDialog.show(
      context: context,
      title: const Text('Azione'),
      content: Text(message),
      actions: [
        AdaptiveDialogAction(
          child: const Text('OK'),
          isDefaultAction: true,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}

/// Tab che mostra una rassegna dei widget adattivi.
class _WidgetsTab extends StatefulWidget {
  const _WidgetsTab({required this.counter, required this.onNotify});

  final int counter;
  final ValueChanged<String> onNotify;

  @override
  State<_WidgetsTab> createState() => _WidgetsTabState();
}

class _WidgetsTabState extends State<_WidgetsTab> {
  bool switchValue = false;
  double sliderValue = 0.5;
  String? selectedOption;
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = AdaptiveThemeProvider.of(context);

    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Widget Adattivi', style: theme.textTheme.headline),
          SizedBox(height: theme.spacing.sm),
          Text('FAB premuto ${widget.counter} volte',
              style: theme.textTheme.caption),
          SizedBox(height: theme.spacing.lg),

          // Bottoni
          AdaptiveButton(
            onPressed: _showDialog,
            child: const Text('Mostra Dialog'),
          ),
          SizedBox(height: theme.spacing.sm),
          AdaptiveTextButton(
            onPressed: _showActionSheet,
            child: const Text('Mostra Action Sheet'),
          ),
          SizedBox(height: theme.spacing.lg),

          // TextField (usa inputStyles, coerente Android/iOS)
          AdaptiveTextField(
            controller: _controller,
            placeholder: 'Inserisci testo',
            label: 'Nome',
          ),
          SizedBox(height: theme.spacing.lg),

          // Switch
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Switch Adattivo', style: theme.textTheme.body),
              AdaptiveSwitch(
                value: switchValue,
                onChanged: (value) => setState(() => switchValue = value),
              ),
            ],
          ),
          SizedBox(height: theme.spacing.lg),

          // Slider
          Text('Slider: ${sliderValue.toStringAsFixed(2)}',
              style: theme.textTheme.body),
          AdaptiveSlider(
            value: sliderValue,
            onChanged: (value) => setState(() => sliderValue = value),
            min: 0.0,
            max: 1.0,
          ),
          SizedBox(height: theme.spacing.lg),

          // Dropdown
          AdaptiveDropdown<String>(
            value: selectedOption,
            hint: 'Seleziona opzione',
            items: const [
              AdaptiveDropdownItem(value: 'option1', label: 'Opzione 1'),
              AdaptiveDropdownItem(value: 'option2', label: 'Opzione 2'),
              AdaptiveDropdownItem(value: 'option3', label: 'Opzione 3'),
            ],
            onChanged: (value) => setState(() => selectedOption = value),
          ),
          SizedBox(height: theme.spacing.lg),

          // Date Picker
          AdaptiveButton(
            onPressed: () async {
              final date = await AdaptiveDatePicker.showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2020),
                lastDate: DateTime(2030),
              );
              if (date != null) {
                widget.onNotify('Data selezionata: ${date.toLocal()}');
              }
            },
            child: const Text('Seleziona Data'),
          ),
          SizedBox(height: theme.spacing.lg),

          // List Tiles
          AdaptiveListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profilo'),
            subtitle: const Text('Visualizza il tuo profilo'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => widget.onNotify('Profilo'),
          ),
          AdaptiveListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Impostazioni'),
            subtitle: const Text('Configura l\'app'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => widget.onNotify('Impostazioni'),
          ),
          SizedBox(height: theme.spacing.lg),

          // Progress Indicator
          const Center(child: AdaptiveProgressIndicator()),
        ],
      ),
    );
  }

  void _showDialog() {
    AdaptiveAlertDialog.show(
      context: context,
      title: const Text('Attenzione'),
      content: const Text('Questo è un dialog adattivo!'),
      actions: [
        AdaptiveDialogAction(
          child: const Text('Annulla'),
          onPressed: () => Navigator.pop(context),
        ),
        AdaptiveDialogAction(
          child: const Text('OK'),
          isDefaultAction: true,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  void _showActionSheet() {
    AdaptiveActionSheet.show(
      context: context,
      title: 'Seleziona azione',
      message: 'Scegli cosa fare',
      actions: [
        AdaptiveActionSheetItem(
          label: 'Modifica',
          icon: const Icon(Icons.edit),
          onPressed: () => widget.onNotify('Modifica selezionata'),
        ),
        AdaptiveActionSheetItem(
          label: 'Condividi',
          icon: const Icon(Icons.share),
          onPressed: () => widget.onNotify('Condividi selezionato'),
        ),
        AdaptiveActionSheetItem(
          label: 'Elimina',
          icon: const Icon(Icons.delete),
          isDestructive: true,
          onPressed: () => widget.onNotify('Elimina selezionato'),
        ),
      ],
      cancelLabel: 'Annulla',
    );
  }
}

/// Semplice tab informativa, per mostrare lo switch tra pagine via bottom nav.
class _InfoTab extends StatelessWidget {
  const _InfoTab();

  @override
  Widget build(BuildContext context) {
    final theme = AdaptiveThemeProvider.of(context);
    return Padding(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.info_outline, size: 48, color: theme.colors.primary),
          SizedBox(height: theme.spacing.md),
          Text('platform_adaptive_ui', style: theme.textTheme.headline),
          SizedBox(height: theme.spacing.sm),
          Text(
            'Definisci lo stile in AdaptiveApp e usa gli Adaptive* widget: '
            'Material su Android, Cupertino su iOS, automaticamente.',
            textAlign: TextAlign.center,
            style: theme.textTheme.body,
          ),
        ],
      ),
    );
  }
}
