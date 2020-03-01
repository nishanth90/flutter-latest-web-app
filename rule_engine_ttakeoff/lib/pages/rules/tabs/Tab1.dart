import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rule_engine_ttakeoff/models/UserModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rule_engine_ttakeoff/login/JWTTokenHandler.dart';

//

/* Future<List<Result>> fetchResults(http.Client client) async {
  final response = await client.get('https://api.myjson.com/bins/j5xau');

  // Use the compute function to run parseResults in a separate isolate
  return compute(parseResults, response.body);
} */

// A function that will convert a response body into a List<Result>



List<Result> parseResults() {
  
 return  [
    new Result("Trip", null, true, "Push", "Notif", null, "Special Offer availale for Lounge access", "4h"),
    new Result("Trip", null, true, "InApp", "Notif", null, "10% discount for baggage", "10h"),
    new Result("Trip", null, true, "Push", "Notif", null, "Have You Checked in online?", "6h"),
    new Result("Trip", null, true, "InApp", "Notif", null, "Your flight from '%src' is delayed by '%time' minutes", "4h"),
    new Result("Trip", null, true, "Push", "Notif", null, "Your flight to '%dest' is on time", "24h"),
    new Result("Trip", null, true, "InApp", "Notif", null, "Offers available on various CAB providers", "4h"),
    new Result("Trip", null, true, "Push", "Notif", null, "The traffic is very high enroute to airport", "24h"),
    new Result("Trip", null, true, "Push", "Notif", null, "Did you check your baggage contents?", "24h"),
    new Result("Trip", null, true, "Push", "Notif", null, "New offers available", "24h"),
    new Result("Trip", null, true, "Push", "Notif", null, "Message Template", "24h"),
    new Result("Trip", null, true, "InApp", "Notif", null, "Message Template", "24h"),
    new Result("Trip", null, true, "Push", "Notif", null, "Message Template", "24h"),
  ];
}

class Result {
  @required
  final String notificationType;
  @required
  final String action;
  @required
  final bool alwaysShow;
  @required
  final String type;
  @required
  final String subType;
  @required
  final String internalType;
  @required
  final String messagePayload;
  @required
  final String freqeuncy;

  Result(this.notificationType, this.action, this.alwaysShow, this.type,this.subType, this.internalType, this.messagePayload, this.freqeuncy);

  bool selected = false;

/*   factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      sex: json['sex'] as String,
      region: json['region'] as String,
      year: json['year'] as int,
      statistic: json['statistic'] as String,
      value: json['value'] as String,
    );
  }*/
} 

class ResultsDataSource extends DataTableSource {
  final List<Result> _results;
  ResultsDataSource(this._results);

  void _sort<T>(Comparable<T> getField(Result d), bool ascending) {
    _results.sort((Result a, Result b) {
      if (!ascending) {
        final Result c = a;
        a = b;
        b = c;
      }
      final Comparable<T> aValue = getField(a);
      final Comparable<T> bValue = getField(b);
      return Comparable.compare(aValue, bValue);
    });
    notifyListeners();
  }

  int _selectedCount = 0;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= _results.length) return null;
    final Result result = _results[index];
    return DataRow.byIndex(
        index: index,
        selected: result.selected,
        onSelectChanged: (bool value) {
          if (result.selected != value) {
            _selectedCount += value ? 1 : -1;
            assert(_selectedCount >= 0);
            result.selected = value;
            notifyListeners();
          }
        },
        cells: <DataCell>[
          DataCell(Text('${result.notificationType}')),
          DataCell(Text('${result.action}')),
          DataCell(Text('${result.alwaysShow}')),
          DataCell(Text('${result.type}')),
          DataCell(Text('${result.subType}')),
          DataCell(Text('${result.internalType}')),
          DataCell(Text('${result.messagePayload}')),
          DataCell(Text('${result.freqeuncy}')),
        ]);
  }

  @override
  int get rowCount => _results.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  void _selectAll(bool checked) {
    for (Result result in _results) result.selected = checked;
    _selectedCount = checked ? _results.length : 0;
    notifyListeners();
  }
}
// end of copy

class Tab1 extends StatefulWidget {
  //
  bool isLoaded = false;
  //
  _Tab1State createState() => _Tab1State();
}

class _Tab1State extends State<Tab1> with AutomaticKeepAliveClientMixin {
  Future<SharedPreferences> _instance;
  JWTTokenHandler _jwtInstance;
  @override
  void initState() {
    _instance = SharedPreferences.getInstance();
    _jwtInstance = JWTTokenHandler.instance;
    super.initState();
  }

  //
  ResultsDataSource _resultsDataSource = ResultsDataSource(parseResults());
  bool isLoaded = false;
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  void _sort<T>(
      Comparable<T> getField(Result d), int columnIndex, bool ascending) {
    _resultsDataSource._sort<T>(getField, ascending);
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  void getData() async {
   // final results = await fetchResults(http.Client());
    if (!isLoaded) {
      setState(() {
        _resultsDataSource = ResultsDataSource(parseResults());
        isLoaded = true;
      });
    }
  }

//
  Future<UserModel> getUser() async {
    String token = await _instance.then((value) => value.getString("token"));
    return _jwtInstance.getUserFromToken(token);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
        return ListView(
              padding: const EdgeInsets.all(20.0),
              children: <Widget>[
                  PaginatedDataTable(
              header: const Text('Trip Rules'),
              rowsPerPage: _rowsPerPage,
              onRowsPerPageChanged: (int value) {
                setState(() {
                  _rowsPerPage = value;
                });
              },
              sortColumnIndex: _sortColumnIndex,
              sortAscending: _sortAscending,
              onSelectAll: _resultsDataSource._selectAll,
              columns: <DataColumn>[
                DataColumn(
                    label: const Text('Notification Type'),
                    onSort: (int columnIndex, bool ascending) => _sort<String>(
                        (Result d) => d.notificationType, columnIndex, ascending)),
                DataColumn(
                    label: const Text('Action'),
                    numeric: false,
                    onSort: (int columnIndex, bool ascending) => _sort<String>(
                        (Result d) => d.action, columnIndex, ascending)),
                DataColumn(
                    label: const Text('Always Show'),
                    numeric: false,)
                  //  onSort: (int columnIndex, bool ascending) => _sort<bool>(
                      //  (Result d) => d.alwaysShow, columnIndex, ascending))
                      ,
                DataColumn(
                    label: const Text('Type'),
                    numeric: false,
                    onSort: (int columnIndex, bool ascending) => _sort<String>(
                        (Result d) => d.type, columnIndex, ascending)),
                DataColumn(
                    label: const Text('Sub Type'),
                    numeric: false,
                    onSort: (int columnIndex, bool ascending) => _sort<String>(
                        (Result d) => d.subType, columnIndex, ascending)),
                DataColumn(
                    label: const Text('Internal Type'),
                    numeric: false,
                    onSort: (int columnIndex, bool ascending) => _sort<String>(
                        (Result d) => d.internalType, columnIndex, ascending)),
                        DataColumn(
                    label: const Text('Message Payload'),
                    numeric: false,
                    onSort: (int columnIndex, bool ascending) => _sort<String>(
                        (Result d) => d.messagePayload, columnIndex, ascending)),
                        DataColumn(
                    label: const Text('Frequency'),
                    numeric: false,
                    onSort: (int columnIndex, bool ascending) => _sort<String>(
                        (Result d) => d.freqeuncy, columnIndex, ascending)),
              ],
              source: _resultsDataSource)
              ],
            );
 
   }
  

  @override
  bool get wantKeepAlive => true;
}
