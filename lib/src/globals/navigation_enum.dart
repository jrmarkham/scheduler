enum NavigationEnum {
  home,
  provider,
  scheduler,
  appointment,
  client;

  String getRoute() {
    switch (this) {
      case NavigationEnum.home:
        return '/';
      case NavigationEnum.provider:
        return '/provider';
      case NavigationEnum.scheduler:
        return '/scheduler';
      case NavigationEnum.appointment:
        return '/appointment';
      case NavigationEnum.client:
        return '/client';
    }
  }
}
