import 'package:flutter/material.dart';
import 'package:vibe_coding_test/app/injection.dart';
import 'package:vibe_coding_test/app/routes.dart';
import 'package:vibe_coding_test/core/navigation/navigation_service.dart';
import 'package:vibe_coding_test/core/theme/app_theme.dart';
import 'package:vibe_coding_test/core/widgets/loading_overlay.dart';
import 'package:vibe_coding_test/features/authentication/repository/login_repository.dart';
import 'package:vibe_coding_test/features/authentication/view/login_view.dart';
import 'package:vibe_coding_test/features/dashboard/view/dashboard_view.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final navigation = getIt<NavigationService>();

    return MaterialApp(
      title: 'Enterprise Management System',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      navigatorKey: navigation.navigatorKey,
      home: const SessionGate(),
      routes: {
        AppRoutes.login: (_) => const LoginView(),
        AppRoutes.dashboard: (_) => const DashboardView(),
      },
    );
  }
}

/// Restores session on launch (acceptance A7).
class SessionGate extends StatefulWidget {
  const SessionGate({super.key});

  @override
  State<SessionGate> createState() => _SessionGateState();
}

class _SessionGateState extends State<SessionGate> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _resolve());
  }

  Future<void> _resolve() async {
    final hasSession = await getIt<LoginRepository>().hasValidSession();
    if (!mounted) return;
    final nav = getIt<NavigationService>();
    if (hasSession) {
      await nav.pushNamedAndRemoveUntil(AppRoutes.dashboard, (_) => false);
    } else {
      await nav.pushNamedAndRemoveUntil(AppRoutes.login, (_) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: LoadingWidget());
  }
}
