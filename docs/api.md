# API Endpoints - Aplicación Educativa 📚

## 1️⃣ Autenticación (Usuarios)
### 🔹 Registro de Usuario
**POST** `/auth/sign_up.json`  
**Parámetros (JSON)**  
```json
{
    "user": {
        "email": "test@gmail.com",
        "name": "test name",
        "lastname": "test lastname",
        "password": "123" 
    }
}
```
**Respuesta (200 - Created)**
```json
{
    "message": "Sign up successful"
}
```

### 🔹 Inicio de Sesión
**POST** `/auth/sign_in.json`  
**Parámetros (JSON)**
```json
{
    "email": "jodertio@gmail.com",
    "password": "123" 
}
```
**Respuesta (200 - OK)**
```json
{
    "message": "Sign in successful",
    "token": "...."
}
```

---

## 2️⃣ Usuarios
### 🔹 Obtener Perfil de Usuario
**GET** `/users/:id.json`  
**Headers:** `Authorization: Bearer <token>`  
**Respuesta (200 - OK)**
```json
{
"id": 1,
"nombre": "Juan Pérez",
"correo": "juan@example.com",
"rol": "Estudiante"
}
```

### 🔹 Listar Usuarios (Admin)
**GET** `/users.json`  
**Headers:** `Authorization: Bearer <admin_token>`  
**Respuesta (200 - OK)**
```json
[
{
"id": 1,
"nombre": "Juan Pérez",
"correo": "juan@example.com",
"rol": "Estudiante"
},
{
"id": 2,
"nombre": "María López",
"correo": "maria@example.com",
"rol": "Profesor"
}
]
```

---

## 3️⃣ Cursos
### 🔹 Listar Cursos
**GET** `/courses.json`  
**Respuesta (200 - OK)**
```json
[
{
"id": 1,
"nombre": "Matemáticas Avanzadas",
"descripcion": "Curso de cálculo diferencial e integral",
"profesor": "María López"
}
]
```

### 🔹 Crear Curso (Profesor)
**POST** `/courses.json`  
**Headers:** `Authorization: Bearer <profesor_token>`  
**Parámetros (JSON)**
```json
{
"nombre": "Física Cuántica",
"descripcion": "Fundamentos de la mecánica cuántica"
}
```
**Respuesta (201 - Created)**
```json
{
"id": 2,
"nombre": "Física Cuántica",
"descripcion": "Fundamentos de la mecánica cuántica",
"profesor": "María López"
}
```

### 🔹 Inscribirse a un Curso (Estudiante)
**POST** `/courses/:id/enroll.json`  
**Headers:** `Authorization: Bearer <estudiante_token>`  
**Respuesta (201 - Created)**
```json
{
"mensaje": "Inscripción exitosa",
"curso": "Matemáticas Avanzadas"
}
```

---




```

    # Admin
    /admin/courses.json

    /admin/courses/:id/lessons.json

    # User
    /enrollments.json

```