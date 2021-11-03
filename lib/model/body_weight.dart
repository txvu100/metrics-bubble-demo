class BodyWeight {
  String label = '';
  int? weight; // weight can be null if the data is not available

  BodyWeight({required label}) {
    this.label = label;
  }

  // int? get weight => _weight;
  //
  // set weight(int? value) {
  //   if (value! < 0 && value! > 350)
  //     throw new ArgumentError();
  //   else
  //     _weight = value;
  // }
}