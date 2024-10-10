class AppwriteCustomException{
  final String message;
  const AppwriteCustomException(this.message);

}

class AppwriteDocumentNotFoundException extends AppwriteCustomException{
  AppwriteDocumentNotFoundException(super.message);
}

