import 'dart:typed_data';

abstract class FileRepository {
  Future<Uint8List?> getFileById({required String bucketId, required String fileId});
  Future<Uint8List?> getGroupPicById({required String groupPicId});
  Future<Uint8List?> getProfilePicById({required String profilePicId});

}