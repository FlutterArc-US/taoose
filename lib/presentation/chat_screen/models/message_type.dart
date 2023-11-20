enum MessageType {
  image,
  audio,
  text;

  static const _image = 'Image';
  static const _text = 'text';
  static const _audio = 'audio';

  bool get isImage => this == MessageType.image;

  bool get isText => this == MessageType.text;

  bool get isAudio => this == MessageType.audio;

  int get id {
    if (isImage) {
      return 1;
    } else if (isText) {
      return 0;
    } else if (isAudio) {
      return 2;
    } else {
      return 0;
    }
  }

  static MessageType fromString(String type) {
    if (type == _image) {
      return MessageType.image;
    } else if (type == _audio) {
      return MessageType.audio;
    } else {
      return MessageType.text;
    }
  }
}
