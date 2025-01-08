abstract class JsonModel {
  /**
   * Convert the object to a JSON object
   * DONT use this method to pass as the body of a request
   * which will result in 403 error
   * return @Map<String, dynamic>
   */
  Map<String, dynamic> toJson();

  /**
   * Convert the object to a JSON string
   * used to pass as the body of a request
   */
  String toJsonString();
}
