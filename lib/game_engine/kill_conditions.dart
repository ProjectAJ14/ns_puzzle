Map<String, Function> killConditions = {
  'absent': (
    List<String> list,
    Map<String, String> condition,
  ) {
    if (list.contains(condition['killer']) &&
        list.contains(condition['victim']) &&
        !list.contains(condition['character'])) {
      return true;
    } else {
      return false;
    }
  },
  "greater": (
    List<String> list,
    Map<String, String> condition,
  ) {
    final killerCount =
        list.where((element) => element == condition['killer']).length;
    final victimCount =
        list.where((element) => element == condition['victim']).length;
    if (killerCount > victimCount) {
      return true;
    } else {
      return false;
    }
  },
};
