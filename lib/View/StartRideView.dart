
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:memory_cache/memory_cache.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import '../Model/LocalSQLDB.dart';
import '../Model/NearIncidents.dart';
import 'EditTripInfoView.dart';
import 'NoConnectivityView.dart';
import 'SafeGoMap/SafeGoMap.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StartRideView extends StatelessWidget {
  final int i;
  String _destination = "";
  StartRideView(this.i, {Key? key}) : super(key: key);
  @override
  _StartRideView createState() => _StartRideView(i);
}
class _StartRideView extends State<StartRideView> {
  final int i;
  _StartRideView(this.i);
  String _source = "Loading....";
  String _destination = "Loading....";
  double distance = 2.0;
  late SharedPreferences prefs;
  @override
  void initState()  {
     super.initState();
     getSource().then((value) => _source);
     getDestination().then((value) => _destination);
     calculateDistance().then((value) => distance);
     Timer.periodic(const Duration(seconds: 2), (timer)
     {
       getSource().then((value) => _source);
       getDestination().then((value) => _destination);
       calculateDistance().then((value) => distance);
     });
  }


  Future<bool> checkConnectivity() async {

    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.other) {
      return true;
    } else {
      return false;
    }
  }
  Future<double> calculateDistance()
  async {
    NearIncidents ni = NearIncidents();
    //double? latS = MemoryCache.instance.read<double>('latS');
    //double? lngS = MemoryCache.instance.read<double>('lngS');
    //double? latD = MemoryCache.instance.read<double>('latD');
    //double? lngD = MemoryCache.instance.read<double>('lngD');
    prefs = await SharedPreferences.getInstance();
    double? latS = prefs.getDouble('latS');
    double? lngS = prefs.getDouble('lngS');
    double? latD = prefs.getDouble('latD');
    double? lngD = prefs.getDouble('lngD');
    print(latS);
    print(latS);
    print(latS);
    print(latS);
    print(latS);
    print(latD);
    print(latD);
    print(latD);
    print(latD);
    print(latD);
    print(lngS);
    print(lngS);
    print(lngS);
    print(lngS);
    print(lngD);
    print(lngD);
    print(lngD);
    print(lngD);
    print(lngD);
    print(lngD);
    distance = ni.calculateDistance(latS?? 0,lngS?? 0, latD?? 0,lngD?? 0);
    return ni.calculateDistance(latS?? 0,lngS?? 0, latD?? 0,lngD?? 0);
  }
  Future<String> getSource() async {
    GetIt getIt = GetIt.instance;
    List<Map<String, Object?>> results = await getIt<LocalSQLDB>().selectTravelData(i);
    setState(() {
      _source = results[0]["source"]! as String;
    });
     return  results[0]["source"]! as String;

    }
  Future<String> getDestination() async {
    GetIt getIt = GetIt.instance;
    List<Map<String, Object?>> results = await getIt<LocalSQLDB>().selectTravelData(i);
    setState(() {
      _destination = results[0]["destination"]! as String;
    });
    return  results[0]["destination"]! as String;
  }



  @override
  Widget build(BuildContext context) {
    double espaciado = 30.0;
    double paddingPercentage = 0.05;
    double textPadding = MediaQuery.of(context).size.height * 0.025;
    double iconPadding = MediaQuery.of(context).size.width * paddingPercentage;
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Expanded(
                flex: 1,
                child: SafeGoMap(),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF96CEB4),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(18, textPadding, 0, 0),
                              child: const Text(
                                'Your safe route is set!',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 0,
                                horizontal: 0,
                              ),
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(216, 244, 228, 1),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors
                                      .black, // Adjust the icon color as needed
                                ),
                                onPressed: () async {
                                  bool connectionState =
                                      await checkConnectivity();

                                  if (connectionState) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            EditTripInfoView(i),
                                      ),
                                    );
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const NoConnectivityView(),
                                      ),
                                    );
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: espaciado / 2,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            color: Colors.black,
                            height: 2.0,
                          ),
                        ),
                      ),

                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: iconPadding),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(216, 244, 228, 1),
                                  borderRadius: BorderRadius.circular(60.0),
                                ),
                                child: const Icon(
                                  Icons.access_time,
                                  color: Color.fromRGBO(64, 78, 72, 1),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: 18.0,
                                  right: iconPadding,
                                ),
                                child: Text(
                                  "The distance of your trip its $distance km.",
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: iconPadding,
                          ),
                          child: Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.srH2,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: iconPadding),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(216, 244, 228, 1),
                                  borderRadius: BorderRadius.circular(60.0),
                                ),
                                child: const Icon(
                                  Icons.place_outlined,
                                  color: Color.fromRGBO(64, 78, 72, 1),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: iconPadding,
                                  right: iconPadding,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 0,
                                        right: 0,
                                      ),
                                      child: Text(
                                        'From: $_source',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'To:      $_destination',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: iconPadding,
                          ),
                          child: Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.srTimeHeader,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: iconPadding),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(216, 244, 228, 1),
                                  borderRadius: BorderRadius.circular(60.0),
                                ),
                                child: const Icon(
                                  Icons.timer_sharp,
                                  color: Color.fromRGBO(64, 78, 72, 1),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: iconPadding,
                                  right: iconPadding,
                                ),
                                child: Text(
                                  AppLocalizations.of(context)!.srTime,
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Expanded(
                        flex: 1,
                        child: SizedBox(),
                      ), // Spacer
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }


}

