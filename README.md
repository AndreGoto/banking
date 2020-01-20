# API Banking

## Setup

#### Install
  `Docker`
  `docker-compose`

#### Running
```
docker-compose up --build
```

#### Access
`http://localhost:4000/`





# Autorização

## Criação de Conta

Criação de uma conta

| URL            | Método |
| :------------- | :----- |
| `/api/v1/accounts` | `POST` |

### Exemplo de requisição

```json
{
	"account": {
		"password": "12345678",
  	"password_confirmation": "12345678",
  	"email": "test@test.com"
	}
}
```

### **Status 201 (CREATED)**
```json
```

### **Status 422 (Unprocessable Entity)**
Erro ao criar uma conta

```json
```
