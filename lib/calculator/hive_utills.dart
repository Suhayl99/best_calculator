import 'package:hive/hive.dart';

mixin HiveUtills {
  Future addAllBox<T>(String boxName, Iterable<T> value) async {
    Box<T> box = await isCheckOpenBox<T>(boxName);
    await box.addAll(value);
  }

    Future addBox<T>(String boxName,T value) async {
    Box<T> box = await isCheckOpenBox<T>(boxName);
    await box.add(value);
  }

  Future<Box<T>> getAllBox<T>(String boxName) async {
    Box<T> box = await isCheckOpenBox<T>(boxName);
    return Future<Box<T>>.value(box);
  }

    Future<List<T>> getAllListBox<T>(String boxName) async {
    Box<T> box = await isCheckOpenBox<T>(boxName);
     List<T> list=box.values.toList();
    return list;
  }

    Future getIndexBox<T>(String boxName, int index) async {
    Box<T> box = await isCheckOpenBox<T>(boxName);
    return box.getAt(index);
  }

    Future<T?> getBox<T>(String boxName, String key) async {
    Box<T> box = await isCheckOpenBox<T>(boxName);
    return box.get(key);
  }


    Future<bool> keyContaBox<T>(String boxName, String key) async {
       Box<T> box;
         if (Hive.isBoxOpen(boxName)) {
      box = Hive.box<T>(boxName);
    } else {
      box = Hive.openBox<T>(boxName) as Box<T>;
    }
    if (box.keys.contains(key)){
        return true;
    }else{
      return false;
    }
  }

   Future putBox<T>(String boxName,String key, T value) async {
    Box<T> box = await isCheckOpenBox<T>(boxName);
    await box.put(key, value);
  }  

    Future deleteAtBox<T>(String boxName, int index) async {
    Box<T> box = await isCheckOpenBox<T>(boxName);
    box.deleteAt(index);
  }


  Future clearAllBox<T>(String boxName) async {
    Box<T> box = await isCheckOpenBox<T>(boxName);
    box.clear();
  }

  

  Future<Box<T>> isCheckOpenBox<T>(String boxName) async {
    if (Hive.isBoxOpen(boxName)) {
      return Hive.box<T>(boxName);
    } else {
      return Future.value(Hive.openBox<T>(boxName));
    }
  }

  Future<bool> isEmptyBox<T>(String boxName) async {
    Box<T> box = await isCheckOpenBox<T>(boxName);
    return Future<bool>.value(box.isEmpty);
  }
}