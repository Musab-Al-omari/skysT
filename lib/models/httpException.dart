class HttpException implements Exception {
  final String messeges;
  HttpException(this.messeges);

  @override
  String toString() {
    return messeges;
  }
}
