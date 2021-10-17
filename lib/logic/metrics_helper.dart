class MetricsHelper {
  static const metricSystems = {'mm': 0.001, 'cm': 0.01, 'm': 1, 'km': 1000};

  convertTo(double distance, String from, String to) {
    return (distance * metricSystems[from]!) / metricSystems[to]!;
  }
}
