part of 'image_bloc.dart';

@immutable
abstract class ImageEvent {}

class FetchInitialDataEvent extends ImageEvent{}

class CameraImageSelected extends ImageEvent{}

class GalarayImageSelected extends ImageEvent{}