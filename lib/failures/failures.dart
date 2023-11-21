class MessageException implements Exception {
  MessageException({required this.message});
  final String message;
}

class LoginUserException implements Exception {
  LoginUserException({this.message});
  final String? message;
}

class ImageNotSelectedException implements Exception {}

class ImageFileNotSupportedException implements Exception {
  ImageFileNotSupportedException({this.message});

  final String? message;
}

class StoragePermissionDeniedPermanently implements Exception {
  StoragePermissionDeniedPermanently({required this.message});
  final String message;
}

class CameraPermissionDeniedPermanently implements Exception {
  CameraPermissionDeniedPermanently({required this.message});
  final String message;
}
