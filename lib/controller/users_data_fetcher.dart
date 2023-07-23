import 'package:chat_app_flutter_firebase/model/user_model.dart';
import 'package:firebase_database/firebase_database.dart';

class UsersData {
  static fetch() async {
    FirebaseDatabase database = FirebaseDatabase.instance;
    DataSnapshot usersCollection = await database.ref('users').get();

    List ls = usersCollection.value as List;
    List<User> b =
        ls.map((e) => User.fromJsonToUserModel(jsonData: e)).toList();
    return b;
  }
}
