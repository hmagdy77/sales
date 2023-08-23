extension PowerString on String {
  String maxLength(int lenth) {
    if (this.length > lenth) {
      return this.substring(0, lenth) + '..';
    } else {
      return this;
    }
  }

  String firstThreeWords() {
    int? startIndex = 0, indexOfSpace;

    for (int i = 0; i < 3; i++) {
      indexOfSpace = this.indexOf(' ', startIndex!);
      if (indexOfSpace == -1) {
        //-1 is when character is not found
        return this;
      }
      startIndex = indexOfSpace + 1;
    }

    return this.substring(0, indexOfSpace!) + '...';
  }

  String firstWord() {
    int? startIndex = 0, indexOfSpace;

    for (int i = 0; i < 2; i++) {
      indexOfSpace = this.indexOf(' ', startIndex!);
      if (indexOfSpace == -1) {
        //-1 is when character is not found
        return this;
      }
      startIndex = indexOfSpace + 1;
    }

    return this.substring(0, indexOfSpace!) + '...';
  }
}
