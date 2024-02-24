# Metrica

Cервис сбора статистики из мобильного приложения.

## Методы API

### User service

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

-  **GET** рефреш токена /refresh

Response

`HTTP/1.0 200 OK`
```json
{
 "jwt_token": "token"
}
```

> /<app_code> 

Response

`HTTP/1.0 200 OK`
```json
{
 "api_token": "token", 
 "app_code": "code"
}
```

### Application service

> /app

- **POST** создание приложения /create

**Request body**

```json
{
 "app_name": "electronic-shop"
}
```

Response

`HTTP/1.0 200 OK`
```json
{
 "api_token": "token", 
 "app_code": "app_code"
}
```

- код 200 - приложение успешно создано
- код 403 - пользователь не авторизован
- код 400 - такое приложение уже создано у данного пользователя.

- **POST** создание ивента  /create_event/<app_code>

**Request body**

```json
{
  "events": [
    {
      "name": "number of product views",
      "attrs": [
        {
        "name": "product_name",
        "type": "string"
        },
        {
        "name": "quantity",
        "type": "integer"
        }
      ]
    }
  ]
}
```

Response

`HTTP/1.0 200 OK`
```json
{
 "event_code": "event-code", 
 "app_code": "code"
}
```

### Analytics API
> /<app_code>

-  **GET** получение статистики /<event_code>

Пример:

/electronic-shop-uuid/number_of_product_views-uuid

Response

`HTTP/1.0 200 OK`
```json
[
    {
      "user_code": "user_code_uuid",
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

> /<app_code>

Название топика "analytics-data.raw"

Пример сообщения:

```json
{
  "user_code": "user_code_uuid",
  "event_name": "number_of_adding_products_in_cart",
  "attrs": [
    {
      "name": "product_name",
      "type": "string"
    },
    {
      "name": "quantity",
      "type": "integer"
    }
  ]
}
```

Response

`HTTP/1.0 200 OK`

## Analytics consumer

Слушает топик "analytics-data.raw" и пишет данные в аналитическую базу.
