import './lib/service/web_client.dart';
import './lib/model/mc_event.dart';

main() {
  var resbody =
      "[{\"mcid\":1,\"fail\":\"motor break\",\"ts\":1543825211693},{\"mcid\":2,\"fail\":\"fail header\",\"ts\":1543825211692},{\"mcid\":3,\"fail\":\"unknown\",\"ts\":1543825211692}]";
  var mcs = McEvent.listFromJson(resbody);
  print(mcs);
}

main1() async {
  var wc = WebClient();
  var mcs = await wc.fetchMcEvent();
  print(mcs);
}
