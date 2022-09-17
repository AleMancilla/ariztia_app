//{
//    "idBusiness":OU0xmGobwJr7GrjJYAAr,
//    "city":"El Alto",
//    "description":"Una pieza grande de pollo con papas fritas",
//    "photo":"https"://firebasestorage.googleapis.com/v0/b/el-chaski-delivery-bolivia.appspot.com/o/Arizt%C3%ADa%20SRL%2Fscaled_image_picker985354843908402475.jpg?alt=media&token=8c44809a-12d4-422a-bb7b-05eec8037e91,
//    "emergency":false,
//    "nameBusiness":"Ariztía SRL",
//    "zone":"Villa Adela",
//    "price":20,
//    "name":"Broaster Cuarto",
//    "options":[
//       {
//          "quantity":1,
//          "options":[
//             {
//                "price":0.0,
//                "name":"Pecho con ala"
//             },
//             {
//                "price":0.0,
//                "name":"Pierna con entrepierna"
//             }
//          ],
//          "title":"Presa"
//       },
//       {
//          "quantity":1,
//          "options":[
//             {
//                "price":0.0,
//                "name":"Arroz"
//             },
//             {
//                "price":0.0,
//                "name":"Tallarín"
//             },
//             {
//                "price":0.0,
//                "name":"Mixto"
//             }
//          ],
//          "title":"Guarnición"
//       }
//    ],
//    "days":[
//       "Martes",
//       "Miercoles",
//       "Jueves",
//       "Viernes",
//       "Sabado",
//       "Domingo"
//    ],
//    "idProduct":xNzitgRtR4PRJ1hAk9Tg,
//    "stock":true,
//    "rangePriority":3.0
// }

class ProductModel {
  String? city;
  List<String> days = [];
  String? description;
  String idBusiness;
  String idProduct;
  String name;
  String? nameBusiness;
  String photo;
  double price;
  bool? stock;
  bool? emergency;
  bool? isOpen;
  double? rangePriority;

  List<Options> options = [];

  // ProductModel.createByJson(Map json) {
  //   var listaOrder = <Options>[];
  //   List lista = json['options'];

  //   lista.forEach((element) {
  //     listaOrder.add(Options.createByJson(element));
  //   });

  //   idBusiness = json['idBusiness'];
  //   city = json['city'];
  //   price = json['price'] != null ? double.parse('${json['price']}') : 0.0;
  //   name = json['name'];
  //   options = listaOrder;
  //   days = json['days']
  //       .toString()
  //       .replaceAll('[', '')
  //       .replaceAll(' ', '')
  //       .replaceAll(']', '')
  //       .replaceAll('"', '')
  //       .split(',');
  //   description = json['description'];
  //   idProduct = json['idProduct'];
  //   tokenNotificationBusiness = [];
  //   nameBusiness = json['nameBusiness'];
  //   photo = json['photo'];
  //   stock = json['stock'];
  //   emergency = json['emergency'] ?? false;
  //   coordenates = json['coordenates'];
  //   isOpen = false;
  //   rangePriority =
  //       json['rangePriority'] != null ? json['rangePriority'] * 1.0 : 1.0;
  // }

  ProductModel({
    this.city = '',
    this.days = const [],
    this.description = '',
    this.idBusiness = '',
    this.idProduct = '',
    this.name = '',
    this.nameBusiness = '',
    this.options = const [],
    this.photo = '',
    // this.tokenNotificationBusiness,
    this.price = 0,
    this.stock = false,
    this.isOpen = false,
    this.rangePriority = 1.0,
    this.emergency = false,
  });

  Map<String, Object> toJson() {
    var listaMapa = <Map>[];
    for (var element in options) {
      listaMapa.add(element.toJson());
    }
    return {
      'city': city.toString(),
      'days': days,
      'description': description.toString(),
      'idBusiness': idBusiness,
      'idProduct': idProduct,
      'name': name,
      'nameBusiness': nameBusiness.toString(),
      'options': listaMapa,
      'photo': photo,
      'price': price,
      'stock': stock.toString(),
      'emergency': emergency.toString(),
    };
  }

  @override
  String toString() {
    return "{'city':$city,'days':$days,'description':$description,'idBusiness':$idBusiness,'idProduct':$idProduct,'name':$name,'nameBusiness':$nameBusiness,'options':$options,'photo':$photo,'price':$price,'stock':$stock,'emergency':$emergency}";
  }
}

class Options {
  int quantity;
  String title;
  List<ItemOptions> optionsItems;

  Options(
      {this.optionsItems = const [], this.quantity = 0, required this.title});

  // Options.createByJson(Map json) {
  //   var listaOrder = <ItemOptions>[];
  //   List lista = json['options'];

  //   lista.forEach((element) {
  //     listaOrder.add(ItemOptions.createByJson(element));
  //   });

  //   quantity = json['quantity'];
  //   title = json['title'];
  //   optionsItems = listaOrder;
  // }

  Map<String, Object> toJson() {
    var listaMapa = <Map>[];

    for (var element in optionsItems) {
      listaMapa.add(element.toJson());
    }
    return {'optionsItems': listaMapa, 'quantity': quantity, 'title': title};
  }

  @override
  String toString() {
    return "{'optionsItems':$optionsItems,'quantity':$quantity,'title':$title}";
  }
}

class ItemOptions {
  String name;
  double price;
  bool isSelect;

  ItemOptions({required this.name, this.price = 0, this.isSelect = false});

  // ItemOptions.createByJson(Map json) {
  //   name = json['name'];
  //   price = json['price'] != null ? double.parse('${json['price']}') : 0.0;
  //   isSelect = false;
  // }

  Map<String, Object> toJson() {
    return {'name': name, 'price': price, 'isSelect': isSelect};
  }

  @override
  String toString() {
    return "{'name':$name,'price':$price}";
  }
}
