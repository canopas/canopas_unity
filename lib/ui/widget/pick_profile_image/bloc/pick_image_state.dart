import 'package:equatable/equatable.dart';

class PickImageState extends Equatable {
  final String? pickedImage;
  final bool isPickImageDone;

  const PickImageState({this.pickedImage, this.isPickImageDone = false});

  copyWith({
    String? pickedImage,
    bool? isPickImageDone,
  }) =>
      PickImageState(
        pickedImage: pickedImage ?? this.pickedImage,
        isPickImageDone: isPickImageDone ?? false,
      );

  @override
  List<Object?> get props => [pickedImage, isPickImageDone];
}
