import 'package:frontend/core/network/connectivity_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class AppProviders {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (_) => ConnectivityProvider()),
    // ChangeNotifierProvider(create: (_) => PermissionProvider()),
  ];
}
