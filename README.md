# Методы API

## Authorization service

> /auth

-  **POST** регистрация /signup

**Request body**

```json
{
  "name": "theUser",
  "surname": "James",
  "email": "john@email.com",
  "password": "12345",
  "phone": "12345"
}
```

Response

`HTTP/1.0 200 OK`
```json
{
 "jwt_token": "token"
}
```

-  **POST** авторизация /signin

**Request body**

```json
{
 "email": "john@email.com",
 "password": "12345"
}
```

Response

`HTTP/1.0 200 OK`
```json
{
 "jwt_token": "token"
}
```

В теле передается email и пароль для авторизации. При успешной авторизации, возвращается код 200 и токен авторизации в хэдере.
Если такого пользователя нет, то возвращаем 401. Для регистрации нужно ввести email, пароль, телефон, имя и фамилию. 

## Internal service

> /app/create

- **POST** создание приложения

**Request body**

```json
{
 "app_name": "electronic-shop",
 "events": [
  {
    "name": "number_of_openings"
  },
  {
    "name": "number_of_product_views", 
    "attrs": [{"product_name": "string"}]
  },
  {
    "name": "number_of_adding_products_in_cart",
    "attrs":
     [{"product_name": "string"}, {"quantity": "int"}]
  },
  {
    "name": "number_of_product_purchases",
    "attrs": [{"product_name": "string"}, {"quantity": "int"}]
  }
 ]
}
```

Response

`HTTP/1.0 200 OK`
```json
{
 "api_token": "token"
}
```

В теле запроса передается название приложения, разрешенные ивенты, аттрибуты и возвращается api token созданного приложения.

- код 200 - приложение успешно создано
- код 403 - пользователь не авторизован
- код 400 - такое приложение уже создано у данного пользователя.


> /<app_name>/<event_name>

-  **GET** получение статистики

Пример:

/electronic-shop/number_of_adding_products_in_cart

Response

`HTTP/1.0 200 OK`
```json
[
    {
      "user_id": 1,
      "resistor": 11,
      "diode": 235,
      "transistor": 14
    }
]
```

- код 200 - отображение графиков
- код 404 - страница с приложением не найдена

## Device service

Сервис для продюсинга статистики. Он будет производить и писать сообщения в kafka. Ручка пишет в один топик с одной партицией.

> /<app_name>

-  **POST** сбор статистики

```json
{
  "user_id": 1,
  "event_name": "number_of_adding_products_in_cart",
  "attrs": {"product_name": "diode", "quantity": 2}
}
```

Response

`HTTP/1.0 200 OK`

## Analytics consumer

Слушает топик и пишет в аналитическую базу из protobuf.
