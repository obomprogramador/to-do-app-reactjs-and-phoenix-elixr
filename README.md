# To-Do App (ReactJS and Phoenix)

To star up this project use the files:
- On Windows run: ```win-start-up-app.bat```
- Linux/MacOs run: ```linux-start-up-app.sh```

This projéct use Phonix 1.7 and Vite to create ReactJS Apps.`

- The ReactJS uses ```Atomic Design``` to segregate componnents and ```Mobx``` to manage state machine.

API description:

We have two APIs in this projéct:
- Users API
- ToDos API

Obs: From ```User API``` was used only the ```authenticate``` end-point the others end-points where not used by the front-end ReactJS. But the end-points still exists in the back-end.

> Users API resources:

Request ```Get valid token```: 

```
  curl  -X POST \
  '/api/users/authenticate' \
  --header 'Accept: */*' \
  --header 'User-Agent: MyApp' \
  --header 'Content-Type: application/json' \
  --data-raw '{
    "email": "admin@gmail.com",
    "virtual_password": "123456789101112131415"
  '}
```

Response:

```
{
  "message": "Token is valid only by 30 min!",
  "bearer": "valid-hash-token"
}
```

Request ```Get a list of To-Do```:

```
curl  -X GET \
  '/api/to_dos' \
  --header 'Accept: */*' \
  --header 'User-Agent: MyApp \
  --header 'Authorization: Bearer valid-hash-token'
```

Response when have To-Dos:

```
{
  "data": [
    {
      "id": 1,
      "description": "Comprar pão no mercado!",
      "status": true
    },
    {
      "id": 2,
      "description": "Lavar o banheiro!",
      "status": true
    },
    .
    .
    .
  ]
}
```

Response when have no To-Dos:

```
{
  "data": []
}
```

Request ````Create a new To-Do```:

```
curl  -X POST \
  '/api/to_dos' \
  --header 'Accept: */*' \
  --header 'User-Agent: MyApp' \
  --header 'Authorization: Bearer ${valid-hash-token}' \
  --header 'Content-Type: application/json' \
  --data-raw '{
    "description": "Comprar roupas na loja baratão.",
    "status": true
  }'
```

Response:

```
{
  "data": {
    "id": 5,
    "status": true,
    "description": "Comprar roupas na loja baratão"
  },
  "message": "ToDo created as success!"
}
```

Request ```Update ToDos```:

* This resource was designed to acept multiple To-Dos to be changed at one time.

```
curl  -X POST \
  '/api/to_dos/update' \
  --header 'Accept: */*' \
  --header 'User-Agent: MyApp' \
  --header 'Authorization: Bearer valid-hash-token' \
  --header 'Content-Type: application/json' \
  --data-raw '{
    "to_do_list": [{
      "id": 5,
      "description": "Comprar roupas na loja baratão (Alterado)",
      "status": false
    }]
  }'
```

Response:

```
{
  "data": [
    {
      "id": 5,
      "description": "Comprar roupas na loja baratão (Alterado)",
      "status": false
    }
  ],
  "message": "ToDo(s) changed as success!"
}
```

Request ```Delete a specific To-Do```:

```
curl  -X DELETE \
  '/api/to_dos/:id' \
  --header 'Accept: */*' \
  --header 'User-Agent: MyApp' \
  --header 'Authorization: Bearer valid-hash-token'
```

Response:

```
{
  "data": {
    "id": 5,
    "status": false,
    "description": "Comprar roupas na loja baratão (Alterado)"
  },
  "message": "ToDo deleted as success!"
}
```

If you wanna create a new user it is only possible by API, looks like below:

Request ```Create new User```:

```
curl  -X POST \
  '/api/users' \
  --header 'Accept: */*' \
  --header 'User-Agent: MyApp' \
  --header 'Authorization: Bearer valid-hash-token' \
  --header 'Content-Type: application/json' \
  --data-raw '{
    "name": "Usuário Teste Para doc API",
    "email": "algum@gmail.com",
    "zip_code": "12345678",
    "virtual_password": "123456789101112131415"
  }'
```

Response:

```
{
  "data": {
    "id": 2,
    "name": "Usuário Teste Para doc API",
    "email": "algum@gmail.com",
    "zip_code": "12345678"
  },
  "message": "User created as success!"
}
```