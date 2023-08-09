import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/ui/forms/create_form/bloc/create_form_event.dart';
import 'package:projectunity/ui/forms/create_form/bloc/create_form_state.dart';

@Injectable()
class CreateFormBloc extends Bloc<CreateFormEvent, CreateFormState> {
  CreateFormBloc() : super(const CreateFormState());
}
