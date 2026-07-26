# Login — curl samples

Parent: [`LOGIN_MODULE.md`](LOGIN_MODULE.md)

Raw file: [`login.curl`](login.curl)  
JSON shapes: [`api-json.md`](api-json.md) · [`models.md`](models.md)

---

## Login

```bash
curl --location 'https://api.company.com/v1/auth/login' \
--header 'Content-Type: application/json' \
--header 'Accept: application/json' \
--data '{
    "email":"admin@test.com",
    "password":"123456"
}'
```

| Item | Value |
|------|--------|
| Method | `POST` |
| Path | `/v1/auth/login` |
| Body fields | `email`, `password` |
