import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectunity/ui/space/join_space/bloc/join_space_event.dart';
import 'package:projectunity/ui/space/join_space/bloc/join_space_state.dart';

class JoinSpaceBloc extends Bloc<JoinSpaceEvents, JoinSpaceState>{


  JoinSpaceBloc() : super(JoinSpaceState()){

  }

}