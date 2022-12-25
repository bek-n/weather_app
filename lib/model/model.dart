class Weather {
  dynamic location, current, forecast;
  Weather({this.current, this.forecast, this.location});

  factory Weather.fromJson(Map data) {
    return Weather(
        current: data['current'],
        forecast: data['forecast'],
        location: data['location']);
  }
}
