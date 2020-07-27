# flutter_session

Adds session support to Flutter. Works with mobile, web and (hopefully) desktop builds.
(Don't forget to hit the  like button if you find the package helpful.)

### Write values to the session:
```sh
await FlutterSession().set("token", myJWTToken);
```
or
```sh
var session = FlutterSession();
await session.set("token", myJWTToken);
await session.set("name", "jhourlad");
await session.set("id", 1);
await session.set("price", 10.50);
await session.set("isOK", true);
```

Saving objects, make sure that it has the toJson() method:

``` 
class Data {
  final int id;
  final String data;

  Data({this.data, this.id});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["data"] = this.data;
    return data;
  }
}

Data mappedData = Data(id: 1, data: "Lorem ipsum something, something...");
await FlutterSession().set('mappedData', mappedData);
```

### Read values from the session:
```sh
dynamic token = await FlutterSession().get("token");
```

Session persists throughout the app's lifetime.
(Don't forget to hit the  like button if you find the package helpful.)