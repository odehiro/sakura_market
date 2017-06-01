# coding: utf-8
User.create(
  name: "Example User", 
  email: "user@example.com",
  password: "foobar",
  password_confirmation: "foobar"
)
User.create(
  name: "Administrator", 
  email: "admin@example.com",
  password: "foobar",
  password_confirmation: "foobar",
  admin: true
)
User.create(
  name: "西出 宏和", 
  email: "nishide.h@gmail.com",
  password: "foobar",
  password_confirmation: "foobar",
  admin: true
)

Food.create(name: "さくらんぼ",
            image: "",
            price: 100,
            caption: "甘くて美味しい",
            display: true,
            order: "")
Food.create(name: "キャベツ",
            image: "",
            price: 2000,
            caption: "シャッキシャキ",
            display: true,
            order: "")
Food.create(name: "だいこん",
            image: "",
            price: 150,
            caption: "聖護院の京都産",
            display: true,
            order: "")
Food.create(name: "にら",
            image: "",
            price: 90,
            caption: "レバー",
            display: true,
            order: "")
Food.create(name: "メロン",
            image: "",
            price: 2000,
            caption: "夕張産です",
            display: true,
            order: "")

