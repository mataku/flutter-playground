import 'package:state_app/api/endpoint/endpoint.dart';

class RecentTracksEndpoint extends Endpoint<String> {
  RecentTracksEndpoint(
      {super.path = "/2.0/?method=user.getrecenttracks",
      required super.params,
      required super.requestType});
}
