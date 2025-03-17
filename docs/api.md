# API Endpoints - Aplicación Educativa 📚

## 1️⃣ Autenticación (Usuarios)
### 🔹 Registro de Usuario
**POST** `/api/signup.json`  
**Parámetros (JSON)**  
```json
{
  "nombre": "Juan Pérez",
  "correo": "juan@example.com",
  "contraseña": "secreta123",
  "rol_id": 2
}
```
**Respuesta (201 - Created)**
```json
{
  "id": 1,
  "nombre": "Juan Pérez",
  "correo": "juan@example.com",
  "rol": "Estudiante",
  "token": "jwt_token_aqui"
}
```

### 🔹 Inicio de Sesión
**POST** `/api/login.json`  
**Parámetros (JSON)**
```json
{
  "correo": "juan@example.com",
  "contraseña": "secreta123"
}
```
**Respuesta (200 - OK)**
```json
{
  "token": "jwt_token_aqui",
  "usuario": {
    "id": 1,
    "nombre": "Juan Pérez",
    "rol": "Estudiante"
  }
}
```

---

## 2️⃣ Usuarios
### 🔹 Obtener Perfil de Usuario
**GET** `/api/users/:id.json`  
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
**GET** `/api/users.json`  
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
**GET** `/api/courses.json`  
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
**POST** `/api/courses.json`  
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
**POST** `/api/courses/:id/enroll.json`  
**Headers:** `Authorization: Bearer <estudiante_token>`  
**Respuesta (201 - Created)**
```json
{
  "mensaje": "Inscripción exitosa",
  "curso": "Matemáticas Avanzadas"
}
```

---


