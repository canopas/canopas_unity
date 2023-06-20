import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

abstract class PickImageEvents extends Equatable {}

class PickImageEvent extends PickImageEvents {
  final ImageSource imageSource;

  PickImageEvent({required this.imageSource});

  @override
  List<Object?> get props => [imageSource];
}
