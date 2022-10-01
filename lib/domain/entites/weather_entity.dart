class WeatherEntity {
  WeatherEntity({
    required this.location,
    required this.current,
    required this.forecast,
  });
  late final Location location;
  late final Current current;
  late final Forecast forecast;
}

class Location {
  late final String name;
  late final String country;

  Location.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    country = json['country'];
  }
}

class Current {
  Current({
    required this.lastUpdated,
    required this.tempC,
    required this.tempF,
    required this.isDay,
    required this.condition,
    required this.windKph,
    required this.humidity,
    required this.feelslikeC,
    required this.feelslikeF,
    required this.uv,
  });
  late final String lastUpdated;
  late final int tempC;
  late final int tempF;
  late final bool isDay;
  late final Condition condition;
  late final int windKph;
  late final int humidity;
  late final int feelslikeC;
  late final int feelslikeF;
  late final double uv;

  Current.fromJson(Map<String, dynamic> json) {
    lastUpdated = json['last_updated'];
    tempC = json['temp_c'].toInt();
    tempF = json['temp_f'].toInt();
    isDay = json['is_day'] == 1;
    condition = Condition.fromJson(json['condition']);
    windKph = json['wind_kph'].toInt();
    humidity = json['humidity'].toInt();
    feelslikeC = json['feelslike_c'].toInt();
    feelslikeF = json['feelslike_f'].toInt();
    uv = json['uv'].toDouble();
  }
}

class Condition {
  Condition({
    required this.text,
    required this.icon,
  });
  late final String text;
  late final String icon;

  Condition.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    icon = json['icon'];
  }
}

class Forecast {
  Forecast({
    required this.forecastday,
  });
  late final List<Forecastday> forecastday;

  Forecast.fromJson(Map<String, dynamic> json) {
    forecastday = List.from(json['forecastday']).map((e) => Forecastday.fromJson(e)).toList();
  }
}

class Forecastday {
  Forecastday({
    required this.date,
    required this.day,
    required this.astro,
    required this.hour,
  });
  late final String date;
  late final Day day;
  late final Astro astro;
  late final List<Hour> hour;

  Forecastday.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    day = Day.fromJson(json['day']);
    astro = Astro.fromJson(json['astro']);
    hour = List.from(json['hour']).map((e) => Hour.fromJson(e)).toList();
  }
}

class Day {
  Day({
    required this.maxtempC,
    required this.maxtempF,
    required this.mintempC,
    required this.mintempF,
    required this.avghumidity,
    required this.condition,
    required this.uv,
  });
  late final int maxtempC;
  late final int maxtempF;
  late final int mintempC;
  late final int mintempF;
  late final int avghumidity;
  late final Condition condition;
  late final double uv;

  Day.fromJson(Map<String, dynamic> json) {
    maxtempC = json['maxtemp_c'].toInt();
    maxtempF = json['maxtemp_f'].toInt();
    mintempC = json['mintemp_c'].toInt();
    mintempF = json['mintemp_f'].toInt();
    avghumidity = json['avghumidity'].toInt();
    condition = Condition.fromJson(json['condition']);
    uv = json['uv'].toDouble();
  }
}

class Astro {
  Astro({
    required this.sunrise,
    required this.sunset,
  });
  late final String sunrise;
  late final String sunset;

  Astro.fromJson(Map<String, dynamic> json) {
    sunrise = json['sunrise'];
    sunset = json['sunset'];
  }
}

class Hour {
  Hour({
    required this.time,
    required this.tempC,
    required this.tempF,
    required this.isDay,
    required this.condition,
    required this.windKph,
    required this.humidity,
    required this.feelslikeC,
    required this.feelslikeF,
    required this.uv,
  });
  late final String time;
  late final int? tempC;
  late final int? tempF;
  late final bool isDay;
  late final Condition condition;
  late final int? windKph;
  late final int humidity;
  late final int? feelslikeC;
  late final int? feelslikeF;
  late final double uv;

  Hour.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    tempC = json['temp_c'].toInt();
    tempF = json['temp_f'].toInt();
    isDay = json['is_day'] == 1;
    condition = Condition.fromJson(json['condition']);
    windKph = json['wind_kph'].toInt();
    humidity = json['humidity'].toInt();
    feelslikeC = json['feelslike_c'].toInt();
    feelslikeF = json['feelslike_f'].toInt();
    uv = json['uv'].toDouble();
  }
}
