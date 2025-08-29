# 💰 ExpenseLit API

API RESTful em Django para gerenciamento completo de finanças pessoais com sistema robusto de permissões e criptografia de dados sensíveis.

## 📋 Sobre o Projeto

ExpenseLit API foi desenvolvida para oferecer controle completo sobre finanças pessoais, permitindo:

- ✅ Gerenciamento de contas bancárias e cartões de crédito
- ✅ Controle de despesas e receitas por categorias
- ✅ Sistema de empréstimos e transferências
- ✅ Cadastro unificado de membros (usuários, credores, beneficiários)
- ✅ Criptografia automática de dados sensíveis (CVV)
- ✅ Sistema robusto de permissões baseado no Django
- ✅ Autenticação JWT com refresh tokens
- ✅ Documentação completa da API

## 🚀 Tecnologias Utilizadas

- **[Python 3.13.7](https://www.python.org/downloads/release/python-3137/)** - Linguagem base
- **[Django 5.2.5](https://www.djangoproject.com/)** - Framework web
- **[Django REST Framework](https://www.django-rest-framework.org/)** - API REST
- **[PostgreSQL 16.9](https://www.postgresql.org/docs/release/16.9/)** - Banco de dados
- **[Docker](https://www.docker.com/)** - Conteinerização
- **[Cryptography](https://cryptography.io/)** - Criptografia Fernet para CVVs
- **[SimpleJWT](https://django-rest-framework-simplejwt.readthedocs.io/)** - Autenticação JWT

## 📊 Funcionalidades Principais

### 🏦 Contas Bancárias
- Suporte a múltiplos tipos (CC, Poupança, Salário, Vale)
- Integração com principais instituições financeiras
- Upload de imagens para identificação visual

### 💳 Cartões de Crédito
- **Criptografia automática do CVV** com Fernet
- Gestão de limites e faturas
- Controle de despesas por cartão
- Suporte a múltiplas bandeiras

### 💸 Despesas & Receitas
- 17+ categorias de despesas predefinidas
- 9 categorias de receitas
- Filtros avançados por período, conta e categoria
- Controle de status de pagamento/recebimento

### 👥 Sistema de Membros Unificado
- Cadastro único para usuários, credores e beneficiários
- Flags configuráveis (is_user, is_creditor, is_benefited)
- Validação de documentos únicos
- Filtros por tipo de membro

### 🔄 Empréstimos & Transferências
- Controle de empréstimos com valor pago/pendente
- Transferências entre contas próprias
- Validações de negócio implementadas

## 🛡️ Segurança

- **Criptografia Fernet**: CVVs são automaticamente criptografados
- **JWT Authentication**: Tokens seguros com refresh
- **Sistema de Permissões**: Controle granular baseado no Django
- **Validações Robustas**: Entrada de dados sanitizada
- **HTTPS Ready**: Configurado para produção segura

## 🐳 Instalação com Docker

### 1. Configurar Variáveis de Ambiente

Crie o arquivo `.env` na raiz do projeto baseado no `.env.example`:

```bash
cp .env.example .env
```

**Variáveis obrigatórias:**
```env
# Database
DB_HOST=db
DB_PORT=5432
DB_NAME=expenselit
DB_USER=seu_usuario
DB_PASSWORD=sua_senha_segura

# Django
SECRET_KEY=sua_secret_key_django_muito_segura
DJANGO_SUPERUSER_USERNAME=admin
DJANGO_SUPERUSER_EMAIL=admin@exemplo.com
DJANGO_SUPERUSER_PASSWORD=senha_admin_segura

# Criptografia (OBRIGATÓRIA)
ENCRYPTION_KEY=sua_chave_fernet_base64
```

### 2. Gerar Chave de Criptografia

```bash
python -c "from cryptography.fernet import Fernet; print('ENCRYPTION_KEY=' + Fernet.generate_key().decode())"
```

### 3. Construir e Executar

```bash
# Construir a imagem
docker build . -t expenselit-api

# Configurar banco no expenselit-api.yml
# Edite as variáveis POSTGRES_USER e POSTGRES_PASSWORD

# Executar o stack
docker stack deploy -c expenselit-api.yml expenselit-api
```

## 🔧 Instalação Local (Desenvolvimento)

```bash
# Clonar repositório
git clone https://github.com/seu-usuario/expenselit-api.git
cd expenselit-api

# Criar ambiente virtual
python -m venv venv
source venv/bin/activate  # Linux/Mac
# venv\Scripts\activate   # Windows

# Instalar dependências
pip install -r requirements.txt

# Configurar .env (ver seção Docker)

# Executar migrações
python manage.py migrate

# Criar superusuário
python manage.py createsuperuser

# Executar servidor
python manage.py runserver 0.0.0.0:8002
```

## 📚 Documentação da API

### 📖 Documentação Completa
- **[API Documentation](docs/API_DOCUMENTATION.md)** - Guia completo com todos os endpoints
- **[Error Responses Guide](docs/ERROR_RESPONSES_GUIDE.md)** - Tratamento de erros
- **[Postman Collection](docs/expenselit-api-complete.postman_collection.json)** - Collection completa

### 🔗 Endpoints Principais

- `POST /api/v1/authentication/token/` - Autenticação
- `GET/POST /api/v1/accounts/` - Contas bancárias
- `GET/POST /api/v1/expenses/` - Despesas
- `GET/POST /api/v1/revenues/` - Receitas
- `GET/POST /api/v1/credit-cards/` - Cartões de crédito
- `GET/POST /api/v1/members/` - Sistema de membros
- `GET/POST /api/v1/loans/` - Empréstimos
- `GET/POST /api/v1/transfers/` - Transferências

### 🧪 Executar Testes

```bash
# Todos os testes
python manage.py test

# Testes específicos
python manage.py test tests.test_permissions
python manage.py test tests.test_models
python manage.py test tests.test_views
```

## 🎯 Próximas Melhorias

- [ ] **Paginação** - Implementar em todos os endpoints
- [ ] **Cache Redis** - Otimização de performance
- [ ] **Soft Delete** - Exclusão lógica vs física
- [ ] **Relatórios** - Endpoints de analytics e relatórios
- [ ] **Rate Limiting** - Proteção contra abuso
- [ ] **Logs de Auditoria** - Rastreamento de ações
- [ ] **Webhooks** - Notificações automáticas
- [ ] **API Versioning** - Versionamento semântico
- [ ] **Backup Automático** - Rotinas de backup
- [ ] **Healthcheck** - Monitoramento da aplicação

## 🤝 Contribuição

1. Fork o projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo `LICENSE` para mais detalhes.

## 📞 Suporte

- 📧 **Email**: [tarcisio.ribeiro.1840@hotmail.com]
- 📱 **Issues**: [GitHub Issues](https://github.com/tarcisioribeiro/expenselit-api/issues)
- 📚 **Docs**: Consulte a pasta `docs/` para documentação completa