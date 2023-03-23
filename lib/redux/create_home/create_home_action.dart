class DiscardCreateHomeAction {}

class FailedToDiscardCreateHome {}

class HomeNameChangedAction {
  final String newName;

  HomeNameChangedAction(this.newName);
}

class HomeAddressChangedAction {
  final String newAddress;

  HomeAddressChangedAction(this.newAddress);
}

class HomeAboutChangedAction {
  final String newAbout;

  HomeAboutChangedAction(this.newAbout);
}
