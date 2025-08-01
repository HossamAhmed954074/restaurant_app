// import 'package:cloud_firestore/cloud_firestore.dart';

// Future<void> uploadDataToFireStore() async {
//   for (final sector in data.entries) {
//     uploadDataToFireStoreForField(field: sector.key, data: sector.value);
//   }
// }

// Future<void> uploadDataToFireStoreForField({
//   required String field,
//   required dynamic data,
// }) async {
//   FirebaseFirestore.instance.collection('ListOfMenuItems').doc(field).set(data);
// }
// final data=
// {
//   'Pasta' : {
//   'title' : 'Pasta',
//   'imageCategory' : 'assets/images/burger.jpg',
//   'items' : {
//     '0' : {
//       'title' : 'Spaghetti Carbonara',
//       'imageCategory' : 'assets/images/spaghetti_carbonara.jpg',
//       'description' : 'Classic Italian pasta with creamy sauce and pancetta.',
//       'price' : 12.99,
//       'rating' : '4.8',
//       'time' : '15 min',
//       'imageFordetails' : 'assets/images/spaghetti_carbonara.jpg',
//     },
//     '1' : {
//       'title' : 'Penne Arrabbiata',
//       'imageCategory' : 'assets/images/penne_arrabbiata.jpg',
//       'description' : 'Spicy tomato sauce with garlic and chili peppers.',
//       'price' : 11.49,
//       'rating' : '4.7',
//       'time' : '12 min',
//       'imageFordetails' : 'assets/images/penne_arrabbiata.jpg',
//     },
//     '2' : {
//       'title' : 'Fettuccine Alfredo',
//       'imageCategory' : 'assets/images/fettuccine_alfredo.jpg',
//       'description' : 'Creamy Alfredo sauce with fettuccine pasta.',
//       'price' : 13.49,
//       'rating' : '4.9',
//       'time' : '10 min',
//       'imageFordetails' : 'assets/images/fettuccine_alfredo.jpg',
//     },
//     '3' : {
//       'title' : 'Lasagna',
//       'imageCategory' : 'assets/images/lasagna.jpg',
//       'description' : 'Layers of pasta with meat sauce and cheese.',
//       'price' : 14.99,
//       'rating' : '4.6',
//       'time' : '20 min',
//       'imageFordetails' : 'assets/images/lasagna.jpg',
//     },
//     '4' : {
//       'title' : 'Pesto Pasta',
//       'imageCategory' : 'assets/images/pesto_pasta.jpg',
//       'description' : 'Pasta tossed with fresh basil pesto sauce.',
//       'price' : 11.99,
//       'rating' : '4.5',
//       'time' : '10 min',
//       'imageFordetails' : 'assets/images/pesto_pasta.jpg',
//     },
//     '5' : {
//       'title' : 'Seafood Linguine',
//       'imageCategory' : 'assets/images/seafood_linguine.jpg',
//       'description' : 'Linguine pasta with a mix of seafood in a light sauce.',
//       'price' : 15.99,
//       'rating' : '4.8',
//       'time' : '18 min',
//       'imageFordetails' : 'assets/images/seafood_linguine.jpg',
//     },
//     // Add more pasta items as needed
//   },
//   },
//   'sandwich': {
//   'title' : 'sandwich',
//   'imageCategory' : 'assets/images/sandwich.jpg',
//   'items' : {
//     '0' : {
//       'title' : 'Club Sandwich',
//       'imageCategory' : 'assets/images/club_sandwich.jpg',
//       'description' : 'Triple-layered sandwich with turkey, bacon, and lettuce.',
//       'price' : 8.99,
//       'rating' : '4.7',
//       'time' : '10 min',
//       'imageFordetails' : 'assets/images/club_sandwich.jpg',
//     },
//     '1' : {
//       'title' : 'BLT Sandwich',
//       'imageCategory' : 'assets/images/blt_sandwich.jpg',
//       'description' : 'Bacon, lettuce, and tomato on toasted bread.',
//       'price' : 7.49,
//       'rating' : '4.6',
//       'time' : '8 min',
//       'imageFordetails' : 'assets/images/blt_sandwich.jpg',
//     },
//     '2' : {
//       'title' : 'Grilled Cheese Sandwich',
//       'imageCategory' : 'assets/images/grilled_cheese_sandwich.jpg',
//       'description' : 'Classic grilled cheese with melted cheddar.',
//       'price' : 5.99,
//       'rating' : '4.5',
//       'time' : '5 min',
//       'imageFordetails' : 'assets/images/grilled_cheese_sandwich.jpg',
//     },
//     '3' : {
//       'title' : 'Turkey and Avocado Sandwich',
//       'imageCategory' : 'assets/images/turkey_avocado_sandwich.jpg',
//       'description' : 'Sliced turkey with avocado and sprouts on whole grain bread.',
//       'price' : 9.49,
//       'rating' : '4.8',
//       'time' : '10 min',
//       'imageFordetails' : 'assets/images/turkey_avocado_sandwich.jpg',
//     },
//     '4' : {
//       'title' : 'Caprese Sandwich',
//       'imageCategory' : 'assets/images/caprese_sandwich.jpg',
//       'description' : 'Fresh mozzarella, tomatoes, and basil with balsamic glaze.',
//       'price' : 6.99,
//       'rating' : '4.4',
//       'time' : '7 min',
//       'imageFordetails' : 'assets/images/caprese_sandwich.jpg',
//     },
//     '5' : {
//       'title' : 'Pulled Pork Sandwich',
//       'imageCategory' : 'assets/images/pulled_pork_sandwich.jpg',
//       'description' : 'Slow-cooked pulled pork with BBQ sauce on a bun.',
//       'price' : 10.99,
//       'rating' : '4.9',
//       'time' : '12 min',
//       'imageFordetails' : 'assets/images/pulled_pork_sandwich.jpg',
//     },
//     // Add more sandwich items as needed

//   }
//   }
// };

// final data=
// {
//   'Burger' : {
//   'title' : 'Burger',
//   'imageCategory' : 'assets/images/burger.jpg',
//   'items' : {
//     '0' : {
//       'title' : 'Cheeseburger',
//       'imageCategory' : 'assets/images/cheeseburger.jpg',
//       'description' : 'Juicy beef patty with cheese, lettuce, and tomato.',
//       'price' : 6.99,
//       'rating' : '4.7',
//       'time' : '10 min',
//       'imageFordetails' : 'assets/images/cheeseburger.jpg',
//     },
//     '1' : {
//       'title' : 'Double Cheeseburger',
//       'imageCategory' : 'assets/images/double_cheeseburger.jpg',
//       'description' : 'Double the beef, double the cheese, double the flavor.',
//       'price' : 8.99,
//       'rating' : '4.8',
//       'time' : '12 min',
//       'imageFordetails' : 'assets/images/double_cheeseburger.jpg',
//     },
//     '2' : {
//       'title' : 'Veggie Burger',
//       'imageCategory' : 'assets/images/veggie_burger.jpg',
//       'description' : 'A delicious plant-based burger with fresh veggies.',
//       'price' : 5.99,
//       'rating' : '4.5',
//       'time' : '8 min',
//       'imageFordetails' : 'assets/images/veggie_burger.jpg',
//     },
//     '3' : {
//       'title' : 'Spicy Chicken Burger',
//       'imageCategory' : 'assets/images/spicy_chicken_burger.jpg',
//       'description' : 'Crispy chicken with a spicy kick, topped with lettuce and mayo.',
//       'price' : 7.49,
//       'rating' : '4.6',
//       'time' : '10 min',
//       'imageFordetails' : 'assets/images/spicy_chicken_burger.jpg',
//     },
//     '4' : {
//       'title' : 'Bacon Burger',
//       'imageCategory' : 'assets/images/bacon_burger.jpg',
//       'description' : 'A classic burger topped with crispy bacon and cheese.',
//       'price' : 9.49,
//       'rating' : '4.9',
//       'time' : '10 min',
//       'imageFordetails' : 'assets/images/bacon_burger.jpg',
//     },
//     '5' : {
//       'title' : 'Fish Burger',
//       'imageCategory' : 'assets/images/fish_burger.jpg',
//       'description' : 'A light and crispy fish burger with tartar sauce.',
//       'price' : 7.99,
//       'rating' : '4.4',
//       'time' : '10 min',
//       'imageFordetails' : 'assets/images/fish_burger.jpg',
//     },
//   },
// },
//   'Pizza' : {
//    'title' : 'Pizza',
//    'imageCategory' : 'assets/images/pizza.jpg',
//    'items' : {
//      '0' : {
//        'title' : 'Margherita Pizza',
//        'imageCategory' : 'assets/images/margherita_pizza.jpg',
//        'description' : 'Classic pizza with fresh mozzarella, tomatoes, and basil.',
//        'price' : 8.99,
//        'rating' : '4.5',
//        'time' : '15 min',
//        'imageFordetails' : 'assets/images/margherita_pizza.jpg',
//      },
//       '1' : {
//        'title' : 'Pepperoni Pizza',
//        'imageCategory' : 'assets/images/pepperoni_pizza.jpg',
//        'description' : 'A classic favorite with spicy pepperoni slices.',
//        'price' : 9.99,
//        'rating' : '4.6',
//        'time' : '15 min',
//        'imageFordetails' : 'assets/images/pepperoni_pizza.jpg',
//      },
//      '2' : {
//        'title' : 'BBQ Chicken Pizza',
//        'imageCategory' : 'assets/images/bbq_chicken_pizza.jpg',
//        'description' : 'Grilled chicken with BBQ sauce, red onions, and cilantro.',
//        'price' : 10.99,
//        'rating' : '4.7',
//        'time' : '20 min',
//        'imageFordetails' : 'assets/images/bbq_chicken_pizza.jpg',
//      },
//      '3' : {
//        'title' : 'Veggie Supreme Pizza',
//        'imageCategory' : 'assets/images/veggie_supreme_pizza.jpg',
//        'description' : 'Loaded with fresh vegetables and a blend of cheeses.',
//        'price' : 9.49,
//        'rating' : '4.4',
//        'time' : '15 min',
//        'imageFordetails' : 'assets/images/veggie_supreme_pizza.jpg',
//      },
//      '4' : {
//        'title' : 'Hawaiian Pizza',
//        'imageCategory' : 'assets/images/hawaiian_pizza.jpg',
//        'description' : 'A sweet and savory combination of ham and pineapple.',
//        'price' : 10.49,
//        'rating' : '4.3',
//        'time' : '15 min',
//        'imageFordetails' : 'assets/images/hawaiian_pizza.jpg',
//      },
//      '5' : {
//        'title' : 'Meat Lovers Pizza',
//        'imageCategory' : 'assets/images/meat_lovers_pizza.jpg',
//        'description' : 'A hearty pizza with a variety of meats and cheeses.',
//        'price' : 11.99,
//        'rating' : '4.8',
//        'time' : '20 min',
//        'imageFordetails' : 'assets/images/meat_lovers_pizza.jpg',
//      },
//    }
//   },
//   'Sushi' : {
//    'title' : 'Sushi',
//    'imageCategory' : 'assets/images/sushi.jpg',
//    'items' : {
//      '0' : {
//        'title' : 'California Roll',
//        'imageCategory' : 'assets/images/california_roll.jpg',
//        'description' : 'Sushi roll with crab, avocado, and cucumber.',
//        'price' : 10.99,
//        'rating' : '4.8',
//        'time' : '20 min',
//        'imageFordetails' : 'assets/images/california_roll.jpg',
//      },
//      '1' : {
//        'title' : 'Spicy Tuna Roll',
//        'imageCategory' : 'assets/images/spicy_tuna_roll.jpg',
//        'description' : 'Spicy tuna with avocado and cucumber wrapped in rice.',
//        'price' : 11.49,
//        'rating' : '4.7',
//        'time' : '20 min',
//        'imageFordetails' : 'assets/images/spicy_tuna_roll.jpg',
//      },
//      '2' : {
//        'title' : 'Salmon Nigiri',
//        'imageCategory' : 'assets/images/salmon_nigiri.jpg',
//        'description' : 'Fresh salmon on top of vinegared rice.',
//        'price' : 9.99,
//        'rating' : '4.6',
//        'time' : '15 min',
//        'imageFordetails' : 'assets/images/salmon_nigiri.jpg',
//      },
//       '3' : {
//         'title' : 'Ebi (Shrimp) Nigiri',
//         'imageCategory' : 'assets/images/ebi_nigiri.jpg',
//         'description' : 'Sweet shrimp served on vinegared rice.',
//         'price' : 10.49,
//         'rating' : '4.5',
//         'time' : '15 min',
//         'imageFordetails' : 'assets/images/ebi_nigiri.jpg',
//       },
//       '4' : {
//         'title' : 'Dragon Roll',
//         'imageCategory' : 'assets/images/dragon_roll.jpg',
//         'description' : 'A beautiful roll with eel, avocado, and cucumber.',
//         'price' : 12.99,
//         'rating' : '4.9',
//         'time' : '25 min',
//         'imageFordetails' : 'assets/images/dragon_roll.jpg',
//       },
//       '5' : {
//         'title' : 'Tempura Roll',
//         'imageCategory' : 'assets/images/tempura_roll.jpg',
//         'description' : 'Crispy tempura shrimp with avocado and cucumber.',
//         'price' : 11.99,
//         'rating' : '4.8',
//         'time' : '20 min',
//         'imageFordetails' : 'assets/images/tempura_roll.jpg',
//       },
     
//    }
//   },
//   'Salad' : {
//    'title' : 'Salad',
//    'imageCategory' : 'assets/images/salad.jpg',
//    'items' : {
//      '0' : {
//        'title' : 'Garden Salad',
//        'imageCategory' : 'assets/images/garden_salad.jpg',
//        'description' : 'Fresh garden salad with a variety of vegetables.',
//        'price' : 9.99,
//        'rating' : '4.2',
//        'time' : '5 min',
//        'imageFordetails' : 'assets/images/garden_salad.jpg',
//      },
//      '1' : {
//        'title' : 'Caesar Salad',
//        'imageCategory' : 'assets/images/caesar_salad.jpg',
//        'description' : 'Crisp romaine lettuce with Caesar dressing and croutons.',
//        'price' : 10.49,
//        'rating' : '4.5',
//        'time' : '5 min',
//        'imageFordetails' : 'assets/images/caesar_salad.jpg',
//      },
//      '2' : {
//        'title' : 'Greek Salad',
//        'imageCategory' : 'assets/images/greek_salad.jpg',
//        'description' : 'A refreshing salad with feta cheese, olives, and tomatoes.',
//        'price' : 10.99,
//        'rating' : '4.4',
//        'time' : '5 min',
//        'imageFordetails' : 'assets/images/greek_salad.jpg',
//      },
//       '3' : {
//         'title' : 'Caprese Salad',
//         'imageCategory' : 'assets/images/caprese_salad.jpg',
//         'description' : 'Fresh mozzarella, tomatoes, and basil drizzled with balsamic.',
//         'price' : 11.49,
//         'rating' : '4.6',
//         'time' : '5 min',
//         'imageFordetails' : 'assets/images/caprese_salad.jpg',
//       },
//       '4' : {
//         'title' : 'Quinoa Salad',
//         'imageCategory' : 'assets/images/quinoa_salad.jpg',
//         'description' : 'Healthy quinoa salad with mixed greens and vegetables.',
//         'price' : 12.99,
//         'rating' : '4.7',
//         'time' : '5 min',
//         'imageFordetails' : 'assets/images/quinoa_salad.jpg',
//       },
//       '5' : {
//         'title' : 'Fruit Salad',
//         'imageCategory' : 'assets/images/fruit_salad.jpg',
//         'description' : 'A refreshing mix of seasonal fruits.',
//         'price' : 8.99,
//         'rating' : '4.3',
//         'time' : '5 min',
//         'imageFordetails' : 'assets/images/fruit_salad.jpg',
//       },
     
//    }
//   },
//   'Dessert' : {
//    'title' : 'Dessert',
//    'imageCategory' : 'assets/images/dessert.jpg',
//    'items' : {
//      '0' : {
//        'title' : 'Chocolate Cake',
//        'imageCategory' : 'assets/images/chocolate_cake.jpg',
//        'description' : 'Rich and moist chocolate cake with creamy frosting.',
//        'price' : 5.99,
//        'rating' : '4.6',
//        'time' : '10 min',
//        'imageFordetails' : 'assets/images/chocolate_cake.jpg',
//      },
//      '1' : {
//        'title' : 'Cheesecake',
//        'imageCategory' : 'assets/images/cheesecake.jpg',
//        'description' : 'Creamy cheesecake with a graham cracker crust.',
//        'price' : 6.49,
//        'rating' : '4.7',
//        'time' : '10 min',
//        'imageFordetails' : 'assets/images/cheesecake.jpg',
//      },
//      '2' : {
//        'title' : 'Apple Pie',
//        'imageCategory' : 'assets/images/apple_pie.jpg',
//        'description' : 'Classic apple pie with a flaky crust.',
//        'price' : 5.49,
//        'rating' : '4.5',
//        'time' : '15 min',
//        'imageFordetails' : 'assets/images/apple_pie.jpg',
//      },
//       '3' : {
//         'title' : 'Ice Cream Sundae',
//         'imageCategory' : 'assets/images/ice_cream_sundae.jpg',
//         'description' : 'Delicious ice cream topped with chocolate sauce and nuts.',
//         'price' : 4.99,
//         'rating' : '4.8',
//         'time' : '5 min',
//         'imageFordetails' : 'assets/images/ice_cream_sundae.jpg',
//       },
//       '4' : {
//         'title' : 'Brownies',
//         'imageCategory' : 'assets/images/brownies.jpg',
//         'description' : 'Fudgy brownies with a rich chocolate flavor.',
//         'price' : 5.99,
//         'rating' : '4.9',
//         'time' : '10 min',
//         'imageFordetails' : 'assets/images/brownies.jpg',
//       },
//       '5' : {
//         'title' : 'Fruit Tart',
//         'imageCategory' : 'assets/images/fruit_tart.jpg',
//         'description' : 'A delightful tart filled with pastry cream and topped with fresh fruits.',
//         'price' : 6.99,
//         'rating' : '4.4',
//         'time' : '10 min',
//         'imageFordetails' : 'assets/images/fruit_tart.jpg',
//       },
//       // Add more dessert items as needed
//    }
//   },
//   'Drinks' : {
//    'title' : 'Drinks',
//    'imageCategory' : 'assets/images/drinks.jpg',
//    'items' : {
//      '0' : {
//        'title' : 'Coca Cola',
//        'imageCategory' : 'assets/images/coca_cola.jpg',
//        'description' : 'Classic Coca Cola soft drink.',
//        'price' : 1.99,
//        'rating' : '4.5',
//        'time' : '2 min',
//        'imageFordetails' : 'assets/images/coca_cola.jpg',
//      },
//      '1' : {
//        'title' : 'Lemonade',
//        'imageCategory' : 'assets/images/lemonade.jpg',
//        'description' : 'Refreshing lemonade made with fresh lemons.',
//        'price' : 2.49,
//        'rating' : '4.6',
//        'time' : '2 min',
//        'imageFordetails' : 'assets/images/lemonade.jpg',
//      },
//      '2' : {
//        'title' : 'Iced Tea',
//        'imageCategory' : 'assets/images/iced_tea.jpg',
//        'description' : 'Chilled iced tea with a hint of lemon.',
//        'price' : 2.99,
//        'rating' : '4.4',
//        'time' : '2 min',
//        'imageFordetails' : 'assets/images/iced_tea.jpg',
//      },
//       '3' : {
//         'title' : 'Orange Juice',
//         'imageCategory' : 'assets/images/orange_juice.jpg',
//         'description' : 'Freshly squeezed orange juice.',
//         'price' : 3.49,
//         'rating' : '4.7',
//         'time' : '2 min',
//         'imageFordetails' : 'assets/images/orange_juice.jpg',
//       },
//       '4' : {
//         'title' : 'Coffee',
//         'imageCategory' : 'assets/images/coffee.jpg',
//         'description' : 'Freshly brewed coffee to kickstart your day.',
//         'price' : 2.99,
//         'rating' : '4.8',
//         'time' : '2 min',
//         'imageFordetails' : 'assets/images/coffee.jpg', 
//       },
//       '5' : {
//         'title' : 'Smoothie',
//         'imageCategory' : 'assets/images/smoothie.jpg',
//         'description' : 'A healthy smoothie made with fresh fruits.',
//         'price' : 3.99,
//         'rating' : '4.5',
//         'time' : '5 min',
//         'imageFordetails' : 'assets/images/smoothie.jpg',
//       },
//       // Add more drink items as needed
//    }
//   },

// };