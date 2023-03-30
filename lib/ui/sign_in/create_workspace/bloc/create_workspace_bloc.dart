import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'create_workspace_event.dart';
import 'create_workspace_state.dart';

@Injectable()
class CreateWorkSpaceBLoc
    extends Bloc<CreateWorkSpaceEvents, CreateWorkSpaceState> {
  CreateWorkSpaceBLoc() : super(const CreateWorkSpaceState()) {
    on<PageChangeEvent>(_onPageChange);
  }

  _onPageChange(PageChangeEvent event, Emitter<CreateWorkSpaceState> emit) {
    emit(state.copyWith(page: event.page));
  }
}
