# coding: utf-8
User.create(
  name: "Example User", 
  email: "user@example.com",
  password: "foobar",
  password_confirmation: "foobar",
  to_address: "尼崎",
  admin: false
)
User.create(
  name: "Administrator", 
  email: "admin@example.com",
  password: "foobar",
  password_confirmation: "foobar",
  to_address: "京都",
  admin: true
)
User.create(
  name: "nishide", 
  email: "nishide.h@gmail.com",
  password: "foobar",
  password_confirmation: "foobar",
  to_name: "西出 宏和",
  to_address: "尼崎",
  admin: true
)

Food.create(name: "さくらんぼ",
            image: File.open("./db/images/fruit_cherry.png").read,
            price: 100,
            caption: "甘くて美味しい",
            display: true,
            order_index: 10
           )
Food.create(name: "キャベツ",
            image: File.open("./db/images/kyabetsu_cabbage.png").read,
            price: 2000,
            caption: "シャッキシャキ",
            display: true,
            order_index: 20
           )
Food.create(name: "だいこん",
            image: File.open("./db/images/daikon_radish.png").read,
            price: 150,
            caption: "聖護院の京都産",
            display: true,
            order_index: 30
           )
Food.create(name: "白菜",
            image: File.open("./db/images/hakusai.png").read,
            price: 290,
            caption: "お鍋にぴったり",
            display: true,
            order_index: 40
           )
Food.create(name: "にら",
            image: File.open("./db/images/nira15.jpg").read,
            price: 100,
            caption: "レバーとどうぞ",
            display: true,
            order_index: 50
           )
Food.create(name: "メロン",
            image: File.open("./db/images/fruit_melon_cut.png").read,
            price: 2000,
            caption: "夕張産です",
            display: true,
            order_index: 60
           )
CashOnDelivery.create(less: 10000, price: 300)
CashOnDelivery.create(less: 30000, price: 400)
CashOnDelivery.create(less: 100000, price: 600)
CashOnDelivery.create(less: 999999999, price: 1000)
