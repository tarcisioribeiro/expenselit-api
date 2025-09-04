# Documentação do Banco de Dados

Gerado com **DbSchema** (Trial) em 31-08-2025.  
Fonte: [dbschema.com](https://dbschema.com)

---

## Diagramas e Observações
- Clique duas vezes nos cabeçalhos, colunas ou chaves estrangeiras da tabela para editar.
- É possível criar vários diagramas com tabelas iguais ou diferentes.
- Os diagramas são salvos no arquivo de modelo e podem ser reabertos posteriormente.

---

## Esquema Público

### Tabelas Principais
- [accounts_account](#table-accounts_account)
- [auth_group](#table-auth_group)
- [auth_group_permissions](#table-auth_group_permissions)
- [auth_permission](#table-auth_permission)
- [auth_user](#table-auth_user)
- [auth_user_groups](#table-auth_user_groups)
- [auth_user_user_permissions](#table-auth_user_user_permissions)
- [credit_cards_creditcard](#table-credit_cards_creditcard)
- [credit_cards_creditcardbill](#table-credit_cards_creditcardbill)
- [credit_cards_creditcardexpense](#table-credit_cards_creditcardexpense)
- [django_admin_log](#table-django_admin_log)
- [django_content_type](#table-django_content_type)
- [django_migrations](#table-django_migrations)
- [django_session](#table-django_session)
- [expenses_expense](#table-expenses_expense)
- [loans_loan](#table-loans_loan)
- [members_member](#table-members_member)
- [revenues_revenue](#table-revenues_revenue)
- [transfers_transfer](#table-transfers_transfer)

---

## Table: accounts_account
**Campos:**
- `id` (PK, bigint, identity)
- `uuid` (unique, uuid)
- `created_at` (timestamptz)
- `updated_at` (timestamptz)
- `is_deleted` (boolean)
- `deleted_at` (timestamptz)
- `name` (varchar 200, indexed)
- `account_type` (varchar 100)
- `account_image` (varchar 100)
- `is_active` (boolean)
- `_account_number` (text)
- `agency` (varchar 20)
- `bank_code` (varchar 10)
- `current_balance` (decimal 15,2)
- `minimum_balance` (decimal 15,2)
- `opening_date` (date)
- `description` (text)
- `created_by_id` (FK → auth_user.id)
- `owner_id` (FK → members_member.id)
- `updated_by_id` (FK → auth_user.id)

**Índices:**
- PK, Unq (uuid), name like, created_by_id, owner_id, updated_by_id

---

## Table: auth_group
**Campos:**
- `id` (PK, integer, identity)
- `name` (varchar 150, indexed)

---

## Table: auth_group_permissions
**Campos:**
- `id` (PK, bigint, identity)
- `group_id` (FK → auth_group.id, unique)
- `permission_id` (FK → auth_permission.id, unique)

---

## Table: auth_permission
**Campos:**
- `id` (PK, integer, identity)
- `name` (varchar 255)
- `content_type_id` (FK → django_content_type.id, unique)
- `codename` (varchar 100, unique)

---

## Table: auth_user
**Campos:**
- `id` (PK, integer, identity)
- `password` (varchar 128)
- `last_login` (timestamptz)
- `is_superuser` (boolean)
- `username` (varchar 150, indexed)
- `first_name` (varchar 150)
- `last_name` (varchar 150)
- `email` (varchar 254)
- `is_staff` (boolean)
- `is_active` (boolean)
- `date_joined` (timestamptz)

---

## Table: auth_user_groups
**Campos:**
- `id` (PK, bigint, identity)
- `user_id` (FK → auth_user.id, unique)
- `group_id` (FK → auth_group.id, unique)

---

## Table: auth_user_user_permissions
**Campos:**
- `id` (PK, bigint, identity)
- `user_id` (FK → auth_user.id, unique)
- `permission_id` (FK → auth_permission.id, unique)

---

## Table: credit_cards_creditcard
**Campos:**
- `id` (PK, bigint, identity)
- `uuid` (unique, uuid)
- `created_at` (timestamptz)
- `updated_at` (timestamptz)
- `is_deleted` (boolean)
- `deleted_at` (timestamptz)
- `name` (varchar 200)
- `on_card_name` (varchar 200)
- `flag` (varchar 200)
- `validation_date` (date)
- `_security_code` (text)
- `credit_limit` (decimal 10,2)
- `max_limit` (decimal 10,2)
- `_card_number` (text)
- `is_active` (boolean)
- `closing_day` (integer)
- `due_day` (integer)
- `interest_rate` (decimal 5,2)
- `annual_fee` (decimal 10,2)
- `notes` (text)
- `associated_account_id` (FK → accounts_account.id)
- `created_by_id` (FK → auth_user.id)
- `owner_id` (FK → members_member.id)
- `updated_by_id` (FK → auth_user.id)

---

## Table: credit_cards_creditcardbill
**Campos:**
- `id` (PK, bigint, identity)
- `uuid` (unique, uuid)
- `created_at`, `updated_at`, `is_deleted`, `deleted_at`
- `year` (varchar), `month` (varchar)
- `invoice_beginning_date`, `invoice_ending_date` (date)
- `closed` (boolean)
- `total_amount`, `minimum_payment`, `paid_amount`, `interest_charged`, `late_fee` (decimal 10,2)
- `due_date`, `payment_date` (date)
- `status` (varchar 20)
- `credit_card_id` (FK → credit_cards_creditcard.id)
- `created_by_id`, `updated_by_id` (FK → auth_user.id)

---

## Table: credit_cards_creditcardexpense
**Campos:**
- `id` (PK, bigint, identity)
- `uuid` (unique, uuid)
- `created_at`, `updated_at`, `is_deleted`, `deleted_at`
- `description` (varchar 200)
- `value` (decimal 10,2)
- `date` (date), `horary` (time)
- `category` (varchar 200)
- `installment` (integer, check >= 0)
- `payed` (boolean), `total_installments` (int)
- `merchant`, `transaction_id`, `location` (varchar)
- `notes` (text), `receipt` (varchar 100)
- `bill_id` (FK → credit_cards_creditcardbill.id)
- `card_id` (FK → credit_cards_creditcard.id)
- `created_by_id` (FK → auth_user.id)
- `member_id` (FK → members_member.id)
- `updated_by_id` (FK → auth_user.id)

---

## Table: django_admin_log
**Campos:**
- `id` (PK, integer, identity)
- `action_time` (timestamptz)
- `object_id` (text)
- `object_repr` (varchar 200)
- `action_flag` (smallint, check >= 0)
- `change_message` (text)
- `content_type_id` (FK → django_content_type.id)
- `user_id` (FK → auth_user.id)

---

## Table: django_content_type
**Campos:**
- `id` (PK, integer, identity)
- `app_label` (varchar 100, unique)
- `model` (varchar 100, unique)

---

## Table: django_migrations
**Campos:**
- `id` (PK, bigint, identity)
- `app` (varchar 255)
- `name` (varchar 255)
- `applied` (timestamptz)

---

## Table: django_session
**Campos:**
- `session_key` (PK, varchar 40)
- `session_data` (text)
- `expire_date` (timestamptz, indexed)

---

## Table: expenses_expense
**Campos:**
- `id` (PK, bigint, identity)
- `uuid` (unique, uuid)
- `created_at`, `updated_at`, `is_deleted`, `deleted_at`
- `description` (varchar 100)
- `value` (decimal 10,2)
- `date` (date, indexed), `horary` (time)
- `category` (varchar 200, indexed)
- `payed` (boolean, indexed)
- `merchant`, `location`, `payment_method` (varchar)
- `receipt` (varchar 100)
- `notes` (text)
- `recurring` (boolean), `frequency` (varchar 20)
- `account_id` (FK → accounts_account.id)
- `created_by_id`, `updated_by_id` (FK → auth_user.id)
- `member_id` (FK → members_member.id)

---

## Table: loans_loan
**Campos:**
- `id` (PK, bigint, identity)
- `uuid` (unique, uuid)
- `created_at`, `updated_at`, `is_deleted`, `deleted_at`
- `description` (varchar 200)
- `value`, `payed_value` (decimal 10,2)
- `date` (date), `horary` (time)
- `category` (varchar 200)
- `payed` (boolean)
- `interest_rate` (decimal 5,2)
- `installments` (integer)
- `due_date` (date)
- `contract_document` (varchar 100)
- `payment_frequency` (varchar 20)
- `late_fee` (decimal 10,2)
- `notes` (text)
- `status` (varchar 20)
- `account_id` (FK → accounts_account.id)
- `benefited_id`, `creditor_id`, `guarantor_id` (FK → members_member.id)
- `created_by_id`, `updated_by_id` (FK → auth_user.id)

---

## Table: members_member
**Campos:**
- `id` (PK, bigint, identity)
- `uuid` (unique, uuid)
- `created_at`, `updated_at`, `is_deleted`, `deleted_at`
- `name` (varchar 200)
- `document` (varchar 200, indexed, unique)
- `phone`, `email` (varchar)
- `sex` (varchar)
- `is_creditor`, `is_benefited`, `active` (boolean)
- `birth_date` (date)
- `address` (text)
- `profile_photo` (varchar 100)
- `emergency_contact` (varchar 200)
- `monthly_income` (decimal 10,2)
- `occupation` (varchar 200)
- `notes` (text)
- `created_by_id`, `updated_by_id` (FK → auth_user.id)
- `user_id` (FK → auth_user.id, unique, OneToOneField)

**Propriedades Calculadas:**
- `is_user`: True se o membro está vinculado a um usuário (user_id não é null)
- `age`: Idade calculada baseada na data de nascimento

---

## Table: revenues_revenue
**Campos:**
- `id` (PK, bigint, identity)
- `uuid` (unique, uuid)
- `created_at`, `updated_at`, `is_deleted`, `deleted_at`
- `description` (varchar 200)
- `value` (decimal 10,2)
- `date` (date, indexed)
- `horary` (time)
- `category` (varchar 200, indexed)
- `received` (boolean, indexed)
- `source` (varchar 200)
- `tax_amount`, `net_amount` (decimal 10,2)
- `receipt` (varchar 100)
- `recurring` (boolean), `frequency` (varchar 20)
- `notes` (text)
- `account_id` (FK → accounts_account.id)
- `created_by_id`, `updated_by_id` (FK → auth_user.id)
- `member_id` (FK → members_member.id)

---

## Table: transfers_transfer
**Campos:**
- `id` (PK, bigint, identity)
- `uuid` (unique, uuid)
- `created_at`, `updated_at`, `is_deleted`, `deleted_at`
- `description` (varchar 200)
- `value` (decimal 10,2)
- `date` (date), `horary` (time)
- `category` (varchar 200) - Valores: doc, ted, pix
- `transfered` (boolean)
- `transaction_id` (varchar 100, indexed, unique)
- `fee` (decimal 10,2)
- `exchange_rate` (decimal 10,6)
- `processed_at` (timestamptz)
- `confirmation_code` (varchar 50)
- `notes` (text), `receipt` (varchar 100)
- `origin_account_id` (FK → accounts_account.id, related_name="Credora")
- `destiny_account_id` (FK → accounts_account.id, related_name="Beneficiada")
- `created_by_id`, `updated_by_id` (FK → auth_user.id)
- `member_id` (FK → members_member.id)

---

