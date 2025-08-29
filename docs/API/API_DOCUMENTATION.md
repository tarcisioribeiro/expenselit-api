# ExpenseLit API - Documentação Completa

## 📋 Visão Geral

A ExpenseLit API é uma API RESTful para gerenciamento de finanças pessoais, desenvolvida em Django com Django REST Framework. A API permite o controle completo de contas, despesas, receitas, cartões de crédito, empréstimos e transferências.

## 🔗 Base URL

```
http://localhost:8002/api/v1/
```

## 🔐 Autenticação

A API utiliza **JWT (JSON Web Tokens)** para autenticação. Todos os endpoints (exceto autenticação) requerem um token válido.

### Obter Token

**POST** `/authentication/token/`

```json
{
    "username": "admin",
    "password": "senha123"
}
```

**Resposta de Sucesso (200):**
```json
{
    "access": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9...",
    "refresh": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9..."
}
```

### Usar Token

Inclua o token no header de todas as requisições:

```
Authorization: Bearer {access_token}
```

### Renovar Token

**POST** `/authentication/token/refresh/`

```json
{
    "refresh": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9..."
}
```

## 📊 Status Codes

| Código | Significado | Descrição |
|--------|-------------|-----------|
| 200 | OK | Requisição bem-sucedida |
| 201 | Created | Recurso criado com sucesso |
| 204 | No Content | Recurso deletado com sucesso |
| 400 | Bad Request | Dados inválidos na requisição |
| 401 | Unauthorized | Token inválido ou ausente |
| 403 | Forbidden | Usuário sem permissão para a ação |
| 404 | Not Found | Recurso não encontrado |
| 500 | Internal Server Error | Erro interno do servidor |

## 🏦 Contas (Accounts)

### Tipos de Conta Disponíveis

| Código | Nome |
|--------|------|
| CC | Conta Corrente |
| CS | Conta Salário |
| FG | Fundo de Garantia |
| VA | Vale Alimentação |

### Instituições Disponíveis

| Código | Nome |
|--------|------|
| NUB | Nubank |
| SIC | Sicoob |
| MPG | Mercado Pago |
| IFB | Ifood Benefícios |
| CEF | Caixa Econômica Federal |

### Endpoints

- **GET** `/accounts/` - Lista todas as contas
- **POST** `/accounts/` - Cria uma nova conta
- **GET** `/accounts/{id}/` - Busca conta específica
- **PUT** `/accounts/{id}/` - Atualiza conta
- **DELETE** `/accounts/{id}/` - Exclui conta

### Exemplo de Conta

```json
{
    "id": 1,
    "name": "NUB",
    "account_type": "CC",
    "account_image": "/media/accounts/nubank.png",
    "is_active": true
}
```

## 💸 Despesas (Expenses)

### Categorias de Despesas

| Código | Nome |
|--------|------|
| food and drink | Comida e bebida |
| bills and services | Contas e serviços |
| electronics | Eletrônicos |
| family and friends | Amizades e Família |
| pets | Animais de estimação |
| digital signs | Assinaturas digitais |
| house | Casa |
| purchases | Compras |
| donate | Doações |
| education | Educação |
| loans | Empréstimos |
| entertainment | Entretenimento |
| taxes | Impostos |
| investments | Investimentos |
| others | Outros |
| vestuary | Roupas |
| health and care | Saúde e cuidados pessoais |
| professional services | Serviços profissionais |
| supermarket | Supermercado |
| rates | Taxas |
| transport | Transporte |
| travels | Viagens |

### Filtros Disponíveis

- `category` - Filtrar por categoria
- `payed` - Filtrar por status de pagamento (true/false)
- `account` - Filtrar por conta (ID)
- `date_from` - Data inicial (YYYY-MM-DD)
- `date_to` - Data final (YYYY-MM-DD)

### Endpoints

- **GET** `/expenses/` - Lista todas as despesas
- **POST** `/expenses/` - Cria uma nova despesa
- **GET** `/expenses/{id}/` - Busca despesa específica
- **PUT** `/expenses/{id}/` - Atualiza despesa
- **DELETE** `/expenses/{id}/` - Exclui despesa

### Exemplo de Despesa

```json
{
    "id": 1,
    "description": "Supermercado Extra",
    "value": "234.50",
    "date": "2024-01-15",
    "horary": "19:30:00",
    "category": "supermarket",
    "account": 1,
    "payed": true
}
```

## 💳 Cartões de Crédito (Credit Cards)

### Bandeiras Disponíveis

| Código | Nome |
|--------|------|
| MSC | Master Card |
| VSA | Visa |
| ELO | Elo |
| EXP | American Express |
| HCD | Hipercard |

### ⚠️ Segurança do CVV

O campo `security_code` (CVV) é **automaticamente criptografado** antes de ser salvo no banco de dados usando criptografia Fernet. 

**Importante:**
- O CVV nunca é retornado nas respostas da API
- Deve conter apenas 3 ou 4 dígitos numéricos
- É obrigatório apenas na criação/atualização do cartão

### Endpoints - Cartões

- **GET** `/credit-cards/` - Lista todos os cartões
- **POST** `/credit-cards/` - Cria novo cartão
- **GET** `/credit-cards/{id}/` - Busca cartão específico
- **PUT** `/credit-cards/{id}/` - Atualiza cartão
- **DELETE** `/credit-cards/{id}/` - Exclui cartão

### Endpoints - Faturas

- **GET** `/credit-card-bills/` - Lista todas as faturas
- **POST** `/credit-card-bills/` - Cria nova fatura
- **GET** `/credit-card-bills/{id}/` - Busca fatura específica
- **PUT** `/credit-card-bills/{id}/` - Atualiza fatura
- **DELETE** `/credit-card-bills/{id}/` - Exclui fatura

### Endpoints - Despesas do Cartão

- **GET** `/credit-card-expenses/` - Lista despesas do cartão
- **POST** `/credit-card-expenses/` - Cria nova despesa
- **GET** `/credit-card-expenses/{id}/` - Busca despesa específica
- **PUT** `/credit-card-expenses/{id}/` - Atualiza despesa
- **DELETE** `/credit-card-expenses/{id}/` - Exclui despesa

### Exemplo de Cartão (Resposta)

```json
{
    "id": 1,
    "name": "Cartão Principal",
    "on_card_name": "JOAO DA SILVA",
    "flag": "MSC",
    "validation_date": "2028-12-31",
    "credit_limit": "5000.00",
    "max_limit": "10000.00",
    "associated_account": 1
}
```

### Exemplo de Cartão (Criação)

```json
{
    "name": "Cartão Reserva",
    "on_card_name": "MARIA DOS SANTOS",
    "flag": "VSA",
    "validation_date": "2029-06-30",
    "security_code": "456",
    "credit_limit": "3000.00",
    "max_limit": "8000.00",
    "associated_account": 1
}
```

## 💵 Receitas (Revenues)

### Categorias de Receitas

| Código | Nome |
|--------|------|
| deposit | Depósito |
| award | Prêmio |
| salary | Salário |
| ticket | Vale |
| income | Rendimentos |
| refund | Reembolso |
| cashback | Cashback |
| transfer | Transferência Recebida |
| received_loan | Empréstimo Recebido |
| loan_devolution | Devolução de empréstimo |

### Endpoints

- **GET** `/revenues/` - Lista todas as receitas
- **POST** `/revenues/` - Cria nova receita
- **GET** `/revenues/{id}/` - Busca receita específica
- **PUT** `/revenues/{id}/` - Atualiza receita
- **DELETE** `/revenues/{id}/` - Exclui receita

### Exemplo de Receita

```json
{
    "id": 1,
    "description": "Salário Janeiro",
    "value": "4500.00",
    "date": "2024-01-05",
    "horary": "08:00:00",
    "category": "salary",
    "account": 1,
    "received": true
}
```

## 👥 Membros (Members)

Sistema unificado para cadastro de pessoas relacionadas (família, amigos, credores, beneficiários, usuários).

### Campos Obrigatórios

- `name` - Nome completo
- `document` - Documento (CPF/CNPJ) - único
- `phone` - Telefone
- `sex` - Sexo (M - Masculino / F - Feminino)

### Campos Opcionais

- `email` - Email válido (opcional)
- `is_user` - Se é usuário do sistema (padrão: true)
- `is_creditor` - Se pode ser credor em empréstimos (padrão: true)  
- `is_benefited` - Se pode ser beneficiário (padrão: true)
- `active` - Status ativo (padrão: true)

### Endpoints

- **GET** `/members/` - Lista todos os membros
- **POST** `/members/` - Cria novo membro
- **GET** `/members/{id}/` - Busca membro específico
- **PUT** `/members/{id}/` - Atualiza membro
- **DELETE** `/members/{id}/` - Exclui membro

### Filtros Disponíveis

- `is_user=true/false` - Filtrar apenas usuários
- `is_creditor=true/false` - Filtrar apenas credores
- `is_benefited=true/false` - Filtrar apenas beneficiários
- `active=true/false` - Filtrar por status

### Exemplo de Membro

```json
{
    "id": 1,
    "name": "João da Silva",
    "document": "12345678901",
    "phone": "11999887766",
    "email": "joao.silva@email.com",
    "sex": "M",
    "is_user": true,
    "is_creditor": true,
    "is_benefited": true,
    "active": true
}
```

### Validações

- `document` deve ser único no sistema
- `email` deve ter formato válido quando informado
- `sex` deve ser 'M' ou 'F'
- Ao menos um dos flags (is_user, is_creditor, is_benefited) deve ser true

## 🔄 Transferências (Transfers)

Sistema para registrar transferências entre contas próprias.

### Validações

- A conta de origem deve ser diferente da conta de destino
- Ambas as contas devem existir e estar ativas
- O valor deve ser positivo

### Endpoints

- **GET** `/transfers/` - Lista todas as transferências
- **POST** `/transfers/` - Cria nova transferência
- **GET** `/transfers/{id}/` - Busca transferência específica
- **PUT** `/transfers/{id}/` - Atualiza transferência
- **DELETE** `/transfers/{id}/` - Exclui transferência

### Exemplo de Transferência

```json
{
    "id": 1,
    "value": "500.00",
    "date": "2024-01-18",
    "horary": "10:15:00",
    "origin_account": 1,
    "destination_account": 2,
    "description": "Transferência para poupança"
}
```

## 💰 Empréstimos (Loans)

Sistema para controlar empréstimos feitos a terceiros.

### Campos

- `description` - Descrição do empréstimo
- `value` - Valor total do empréstimo
- `payed_value` - Valor já recebido de volta
- `date` - Data do empréstimo
- `horary` - Horário do empréstimo
- `category` - Categoria do empréstimo
- `account` - Conta de onde saiu o dinheiro
- `creditor` - Pessoa que deve (referência ao membro)

### Validações

- O valor pago não pode ser maior que o valor total
- O credor deve ser um membro válido

### Endpoints

- **GET** `/loans/` - Lista todos os empréstimos
- **POST** `/loans/` - Cria novo empréstimo
- **GET** `/loans/{id}/` - Busca empréstimo específico
- **PUT** `/loans/{id}/` - Atualiza empréstimo
- **DELETE** `/loans/{id}/` - Exclui empréstimo

### Exemplo de Empréstimo

```json
{
    "id": 1,
    "description": "Empréstimo para reforma",
    "value": "5000.00",
    "payed_value": "1500.00",
    "date": "2024-01-10",
    "horary": "09:00:00",
    "category": "personal",
    "account": 1,
    "creditor": 1
}
```

## 🛡️ Permissões

A API utiliza um sistema de permissões baseado no sistema padrão do Django. Cada modelo possui as seguintes permissões:

- `view_{model}` - Visualizar registros
- `add_{model}` - Criar novos registros  
- `change_{model}` - Editar registros existentes
- `delete_{model}` - Excluir registros

### Verificar Permissões do Usuário

**GET** `/authentication/user-permissions/`

```json
{
    "username": "admin",
    "permissions": [
        "accounts.add_account",
        "accounts.view_account",
        "expenses.add_expense",
        "expenses.view_expense"
    ],
    "is_staff": true,
    "is_superuser": true
}
```

## ❌ Tratamento de Erros

### Erros de Validação (400)

```json
{
    "field_name": [
        "Error message describing what's wrong"
    ],
    "another_field": [
        "Another error message"
    ]
}
```

### Erro de Autenticação (401)

```json
{
    "detail": "Given token not valid for any token type",
    "code": "token_not_valid",
    "messages": [
        {
            "token_class": "AccessToken",
            "token_type": "access",
            "message": "Token is invalid or expired"
        }
    ]
}
```

### Erro de Permissão (403)

```json
{
    "detail": "You do not have permission to perform this action."
}
```

### Recurso Não Encontrado (404)

```json
{
    "detail": "Not found."
}
```

## 🔧 Configuração do Ambiente

### Variáveis de Ambiente Obrigatórias

```env
# Database
DB_HOST=localhost
DB_PORT=5432
DB_NAME=expenselit
DB_USER=seu_usuario
DB_PASSWORD=sua_senha

# Django
SECRET_KEY=sua_secret_key_django
DJANGO_SUPERUSER_USERNAME=admin
DJANGO_SUPERUSER_EMAIL=admin@exemplo.com
DJANGO_SUPERUSER_PASSWORD=senha_admin

# Criptografia (OBRIGATÓRIA para segurança do CVV)
ENCRYPTION_KEY=sua_chave_fernet_base64
```

### Gerar Chave de Criptografia

```bash
python -c "from cryptography.fernet import Fernet; print('ENCRYPTION_KEY=' + Fernet.generate_key().decode())"
```

## 📝 Notas Importantes

1. **Segurança**: Todos os CVVs são criptografados automaticamente
2. **Autenticação**: Tokens JWT têm tempo de vida limitado
3. **Permissões**: Sistema baseado em grupos e permissões do Django
4. **Validações**: Campos obrigatórios e validações customizadas implementadas
5. **Soft Delete**: Não implementado - exclusões são definitivas
6. **Paginação**: Não implementada na versão atual
7. **Filtros**: Disponíveis apenas em alguns endpoints

## 🚀 Próximas Melhorias Planejadas

- [ ] Implementar paginação
- [ ] Adicionar mais filtros
- [ ] Implementar soft delete
- [ ] Adicionar endpoints de relatórios
- [ ] Implementar cache
- [ ] Adicionar validações de negócio mais robustas
- [ ] Implementar rate limiting
- [ ] Adicionar logs de auditoria

## 📞 Suporte

Para dúvidas ou problemas:

1. Verifique esta documentação
2. Consulte a collection do Postman
3. Execute os testes unitários
4. Verifique os logs da aplicação