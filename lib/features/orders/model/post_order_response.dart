
class PostOrderResponse {
    bool? toPayOnline;
    String? id;
    String? url;

    PostOrderResponse({this.toPayOnline, this.id, this.url});

    PostOrderResponse.fromJson(Map<String, dynamic> json) {
        toPayOnline = json["toPayOnline"];
        id = json["id"];
        url = json["url"];
    }
}