// Esempio d'uso di `AdaptiveApp.router` con go_router (Navigator 2.0).
//
// Mostra come ottenere la stessa UI adattiva (MaterialApp.router su Android,
// CupertinoApp.router su iOS) usando un `GoRouter` come `routerConfig`, con
// theming e localizzazione identici al costruttore di default `AdaptiveApp`.
//
// Richiede `go_router` tra le dipendenze: `flutter pub add go_router`.
import 'package:flutter/material.dart';
import 'package:platform_adaptive_ui/platform_adaptive_ui.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyRouterApp());
}

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const _HomePage(),
    ),
    GoRoute(
      path: '/details',
      builder: (context, state) => const _DetailsPage(),
    ),
  ],
);

class MyRouterApp extends StatelessWidget {
  const MyRouterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveApp.router(
      title: 'Adaptive Router Demo',
      routerConfig: _router,
      // Tutto il theming/localizzazione del costruttore di default è disponibile.
      colors: ThemeColors.defaultColors,
      darkTheme: AdaptiveThemeData.dark,
      themeMode: ThemeMode.system,
    );
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage();

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      appBar: AdaptiveAppBar(title: const Text('Home')),
      body: Center(
        child: AdaptiveButton(
          onPressed: () => context.go('/details'),
          child: const Text('Vai ai dettagli'),
        ),
      ),
    );
  }
}

class _DetailsPage extends StatelessWidget {
  const _DetailsPage();

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      appBar: AdaptiveAppBar(title: const Text('Dettagli')),
      body: Center(
        child: AdaptiveButton(
          onPressed: () => context.go('/'),
          child: const Text('Torna alla home'),
        ),
      ),
    );
  }
}
