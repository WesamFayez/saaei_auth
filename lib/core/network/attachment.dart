import 'dart:typed_data';

class Attachment {
  final String fieldName;
  final Uint8List? file; // such as Data
  final String? filePath;
  final String mimeType;
  final String fileName;

  Attachment({
    required this.fieldName,
    this.file,
    this.filePath,
    required this.mimeType,
    required this.fileName,
  });
}
