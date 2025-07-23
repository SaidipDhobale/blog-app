// ignore_for_file: public_member_api_docs, sort_constructors_first
class Failure {
    late String message;
    Failure([ this.message="unexpected error"]);
    

  @override
  String toString() => message;
}
