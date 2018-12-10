import 'dart:async';
import 'package:http/http.dart' as http;

import 'package:built_collection/built_collection.dart';
import '../model/mc_event.dart';

class WebClientException implements Exception {
  final String message;

  const WebClientException(this.message);
}

class WebClient {
  static const _requestTimeoutDuration = Duration(seconds: 10);
  static const maxAttempts = 3;

  const WebClient();

  String createAllMcEventUrl() => 'http://198.10.10.71:3000/events';

  String createAllConferencesUrl() =>
      'https://api.voxxed.com/api/voxxeddays/events/future/voxxed';

  String createSingleConferenceUrl(int id) =>
      'https://api.voxxed.com/api/voxxeddays/events/$id';

  String createAllSpeakersUrl(String cfpUrl, String cfpVersion) =>
      '${_trimFinalSlash(cfpUrl)}/api/conferences/$cfpVersion/speakers';

  String createSingleSpeakerUrl(
          String cfpUrl, String cfpVersion, String uuid) =>
      '${_trimFinalSlash(cfpUrl)}/api/conferences/$cfpVersion/speakers/$uuid';

  String createAllSchedulesUrl(String cfpUrl, String cfpVersion) =>
      '${_trimFinalSlash(cfpUrl)}/api/conferences/$cfpVersion/schedules/';

  String createSingleScheduleUrl(
          String cfpUrl, String cfpVersion, String day) =>
      '${_trimFinalSlash(cfpUrl)}/api/conferences/$cfpVersion/schedules/$day/';

  // Some (but not all) CFP Urls come back with a trailing slash. This method
  // removes any that are found, so the URL creation getters above always return
  // a URL that doesn't have double-up slashes.
  String _trimFinalSlash(String url) {
    return url.endsWith('/') ? url.substring(0, url.length - 1) : url;
  }

  Future<http.Response> _makeRequest(String url) async {
    int attempts = 0;
    http.Response response;

    do {
      attempts++;
      response =
          await http.get(url).timeout(_requestTimeoutDuration).catchError((_) {
        throw WebClientException('Timed out requesting $url.');
      });
    } while (response.statusCode == 500 && attempts < maxAttempts);

    return response;
  }

  Future<BuiltList<McEvent>> fetchMcEvent() async {
    try {
      final response = await _makeRequest(createAllMcEventUrl());

      if (response.statusCode != 200) {
        throw WebClientException(
            'Fail to fetch Mc Event, status: ${response.statusCode}');
      }

      final events = McEvent.listFromJson(response.body);
      return events;
    } catch (e) {
      print(e);
      throw WebClientException('SOME ERROR');
    }
  }

  // Future<BuiltList<Conference>> fetchConferences() async {
  //   try {
  //     final response = await _makeRequest(createAllConferencesUrl());

  //     if (response.statusCode != 200) {
  //       throw WebClientException(
  //           'Failed to fetch conferences, status: ${response.statusCode}');
  //     }

  //     final parsedJson = json.decode(response.body);
  //     final deserialized = serializers.deserialize(
  //       parsedJson,
  //       specifiedType: Conference.listSerializationType,
  //     );

  //     return deserialized;
  //   } on http.ClientException catch (e) {
  //     throw WebClientException(e.message);
  //   } on FormatException catch (e) {
  //     throw WebClientException(e.message);
  //   }
  // }

  // Future<Conference> fetchConference(int id) async {
  //   try {
  //     final response = await _makeRequest(createSingleConferenceUrl(id));

  //     if (response.statusCode != 200) {
  //       throw WebClientException(
  //           'Failed to fetch conference $id, status: ${response.statusCode}');
  //     }

  //     final parsedJson = json.decode(response.body);
  //     final deserialized =
  //         serializers.deserializeWith(Conference.serializer, parsedJson);
  //     return deserialized;
  //   } on http.ClientException catch (e) {
  //     throw WebClientException(e.message);
  //   } on FormatException catch (e) {
  //     throw WebClientException(e.message);
  //   }
  // }

  // Future<BuiltList<Speaker>> fetchSpeakers(
  //     String cfpUrl, String cfpVersion) async {
  //   try {
  //     final response =
  //         await _makeRequest(createAllSpeakersUrl(cfpUrl, cfpVersion));

  //     if (response.statusCode != 200) {
  //       throw WebClientException('Failed to fetch speakers for $cfpVersion, '
  //           'status: ${response.statusCode}');
  //     }

  //     final parsedJson = json.decode(response.body);
  //     final deserialized = serializers.deserialize(
  //       parsedJson,
  //       specifiedType: Speaker.listSerializationType,
  //     );

  //     return deserialized;
  //   } on http.ClientException catch (e) {
  //     throw WebClientException(e.message);
  //   } on FormatException catch (e) {
  //     throw WebClientException(e.message);
  //   }
  // }

  // Future<Speaker> fetchSpeaker(
  //     String cfpUrl, String cfpVersion, String uuid) async {
  //   try {
  //     final response =
  //         await _makeRequest(createSingleSpeakerUrl(cfpUrl, cfpVersion, uuid));

  //     if (response.statusCode != 200) {
  //       throw WebClientException('Failed to fetch speaker for $uuid at '
  //           '$cfpVersion, status: ${response.statusCode}');
  //     }

  //     final parsedJson = json.decode(response.body);
  //     final deserialized =
  //         serializers.deserializeWith(Speaker.serializer, parsedJson);

  //     return deserialized;
  //   } on http.ClientException catch (e) {
  //     throw WebClientException(e.message);
  //   } on FormatException catch (e) {
  //     throw WebClientException(e.message);
  //   }
  // }

  // Future<BuiltList<Schedule>> fetchSchedules(
  //     String cfpUrl, String cfpVersion) async {
  //   try {
  //     final response =
  //         await _makeRequest(createAllSchedulesUrl(cfpUrl, cfpVersion));

  //     if (response.statusCode != 200) {
  //       throw WebClientException('Failed to fetch schedules for $cfpVersion, '
  //           'status: ${response.statusCode}');
  //     }

  //     final parsedJson = json.decode(response.body);
  //     final schedules = <Schedule>[];

  //     // Pulls individual details out of the list provided by the API and
  //     // creates Schedule objects with them. The day property is the last part
  //     // of the URL, so it's nipped off and stored.
  //     //
  //     // The title string for each schedule currently has a template field
  //     // added, which this code removes.
  //     for (final link in parsedJson['links']) {
  //       final hrefParts = link['href'].split('/');
  //       schedules.add(
  //         Schedule((b) => b
  //           ..day = hrefParts[hrefParts.length - 1]
  //           ..title = link['title'].toString().replaceAll(', {0}', '')),
  //       );
  //     }

  //     return BuiltList<Schedule>(schedules);
  //   } on http.ClientException catch (e) {
  //     throw WebClientException(e.message);
  //   } on FormatException catch (e) {
  //     throw WebClientException(e.message);
  //   }
  // }

  // Future<BuiltList<ScheduleSlot>> fetchScheduleSlots(
  //     String cfpUrl, String cfpVersion, String day) async {
  //   try {
  //     final response =
  //         await _makeRequest(createSingleScheduleUrl(cfpUrl, cfpVersion, day));

  //     if (response.statusCode != 200) {
  //       throw WebClientException('Failed to fetch $day schedule at '
  //           '$cfpVersion, status: ${response.statusCode}');
  //     }

  //     final parsedJson = json.decode(response.body)['slots'];

  //     for (final slot in parsedJson as List) {
  //       if (slot['talk'] != null && slot['talk']['speakers'] != null) {
  //         final uuids = <String>[];
  //         for (final speaker in slot['talk']['speakers']) {
  //           uuids.add(speaker['link']['uuid']);
  //         }
  //         slot['talk']['speakerUuids'] = uuids;
  //       }
  //     }

  //     // The slots for a schedule are returned as a list inside a JSON object
  //     // with a single property, "slots." This method only cares about the
  //     // talks, so everything else is ignored.
  //     final slots = serializers.deserialize(
  //       parsedJson,
  //       specifiedType: ScheduleSlot.listSerializationType,
  //     );

  //     return BuiltList<ScheduleSlot>(slots);
  //   } on http.ClientException catch (e) {
  //     throw WebClientException(e.message);
  //   } on FormatException catch (e) {
  //     throw WebClientException(e.message);
  //   }
  // }
}
