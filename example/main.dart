import 'package:flutter/material.dart';
import 'package:platform_adaptive_ui/platform_adaptive_ui.dart';

void main() {
  runApp(const MyApp());
}

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
      spacing: const Spacing(
        xs: 4.0,
        sm: 8.0,
        md: 16.0,
        lg: 24.0,
        xl: 32.0,
      ),
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
  bool switchValue = false;
  double sliderValue = 0.5;
  String? selectedOption;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = AdaptiveThemeProvider.of(context);

    return AdaptiveScaffold(
      appBar: AdaptiveAppBar(
        title: const Text('Adaptive UI Demo'),
        actions: [
          AdaptiveIconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Azione settings
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(theme.spacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Titolo
            Text(
              'Widget Adattivi',
              style: theme.textTheme.headline,
            ),
            SizedBox(height: theme.spacing.lg),

            // Bottoni
            AdaptiveButton(
              onPressed: () {
                _showDialog();
              },
              child: const Text('Mostra Dialog'),
            ),
            SizedBox(height: theme.spacing.sm),

            AdaptiveTextButton(
              onPressed: () {
                _showActionSheet();
              },
              child: const Text('Mostra Action Sheet'),
            ),
            SizedBox(height: theme.spacing.lg),

            // TextField
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
                  onChanged: (value) {
                    setState(() {
                      switchValue = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: theme.spacing.lg),

            // Slider
            Text('Slider: ${sliderValue.toStringAsFixed(2)}',
                style: theme.textTheme.body),
            AdaptiveSlider(
              value: sliderValue,
              onChanged: (value) {
                setState(() {
                  sliderValue = value;
                });
              },
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
              onChanged: (value) {
                setState(() {
                  selectedOption = value;
                });
              },
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
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Data selezionata: ${date.toString()}'),
                    ),
                  );
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
              onTap: () {
                // Azione
              },
            ),
            AdaptiveListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Impostazioni'),
              subtitle: const Text('Configura l\'app'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Azione
              },
            ),
            SizedBox(height: theme.spacing.lg),

            // Progress Indicator
            const Center(
              child: AdaptiveProgressIndicator(),
            ),
          ],
        ),
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
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Modifica selezionata')),
            );
          },
        ),
        AdaptiveActionSheetItem(
          label: 'Condividi',
          icon: const Icon(Icons.share),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Condividi selezionato')),
            );
          },
        ),
        AdaptiveActionSheetItem(
          label: 'Elimina',
          icon: const Icon(Icons.delete),
          isDestructive: true,
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Elimina selezionato')),
            );
          },
        ),
      ],
      cancelLabel: 'Annulla',
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
