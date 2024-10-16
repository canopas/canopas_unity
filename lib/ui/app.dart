import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/ui/shared/appbar_drawer/drawer/bloc/app_drawer_bloc.dart';
import 'package:projectunity/ui/widget/error_snack_bar.dart';

import '../data/bloc/network/network_connection_bloc.dart';
import '../data/bloc/network/network_connection_event.dart';
import '../data/bloc/network/network_connection_state.dart';
import '../data/bloc/user_state/user_state_controller_bloc.dart';
import '../data/di/service_locator.dart';

class App extends StatefulWidget {
  final Widget child;

  const App({super.key, required this.child});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => getIt.get<DrawerBloc>()),
          BlocProvider(
              create: (context) => getIt<NetworkConnectionBloc>()
                ..add(NetworkConnectionObserveEvent())),
          BlocProvider(create: (context) => getIt<UserStateControllerBloc>()),
        ],
        child: BlocListener<NetworkConnectionBloc, NetworkConnectionState>(
          listenWhen: (previous, current) =>
              current is NetworkConnectionFailureState,
          listener: (context, state) {
            if (state is NetworkConnectionFailureState) {
              String connectionErrorMessage =
                  context.l10n.network_connection_error;
              showSnackBar(context: context, msg: connectionErrorMessage);
            }
          },
          child: widget.child,
        ));
  }
}
