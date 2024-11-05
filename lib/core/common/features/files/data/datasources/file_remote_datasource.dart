import 'dart:typed_data';

import 'package:appwrite/appwrite.dart';

import '../../../../../exception/server_exception.dart';

abstract class FileRemoteDataSource {
  Future<Uint8List?> getFile(String bucketId, String fileId);
}

class FileRemoteDatasourceImpl implements FileRemoteDataSource{
  final Storage storage;

  const FileRemoteDatasourceImpl({
    required this.storage,
  });

  @override
  Future<Uint8List?> getFile(String bucketId, String fileId) async {
    try {
      return await storage.getFileView(
        bucketId: bucketId,
        fileId: fileId,
      );
    } on AppwriteException catch (e) {
      throw ServerException(e.message ?? 'Some unexpected error occurred');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
  
}