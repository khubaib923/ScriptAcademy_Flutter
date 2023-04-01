class AppException implements Exception{
  final String _message;
  final String _prefix;
  AppException(this._message,this._prefix);

  @override
  String toString(){
    return "$_prefix $_message";
  }

}

class InvalidInputException extends AppException{
  InvalidInputException(String message):super(message,"invalid input");
}

class UnauthorizdException extends AppException{
  UnauthorizdException(String message):super(message,"invalid input");
}

class FetchDataException extends AppException{
  FetchDataException(String message):super(message,"error during communication");
}


class BadRequestException extends AppException{
  BadRequestException(String message):super(message,"invalid request");
}

