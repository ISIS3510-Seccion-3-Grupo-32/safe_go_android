class TravelData {
  final int id;
  final String source;
  final String destination;
  final String date;
  TravelData(this.id, this.source, this.destination, this.date);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'source': source,
      'destination': destination,
      'date': date,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'TravelData { id: $id, source: $source, destination: $destination, date: $date}';
  }
}