import 'dart:typed_data';

import '../../../../../constants/appwrite_constants.dart';
import '../../../../../exception/server_exception.dart';
import '../../domain/repository/file_repository.dart';
import '../datasources/file_remote_datasource.dart';

class FileRepositoryImpl implements FileRepository{

  final FileRemoteDataSource remoteDataSource;

  const FileRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Uint8List?> getFileById({required String bucketId, required String fileId}) async{
    try{
      return remoteDataSource.getFile(bucketId, fileId);
    }on ServerException catch (_) {
      return null;
    }
  }

  @override
  Future<Uint8List?> getGroupPicById({required String groupPicId}) {
    return getFileById(bucketId: AppwriteConstants.groupPicBucket, fileId: groupPicId);
  }

  @override
  Future<Uint8List?> getProfilePicById({required String profilePicId}) {
    return getFileById(bucketId: AppwriteConstants.profilePicBucket, fileId: profilePicId);
  }

}