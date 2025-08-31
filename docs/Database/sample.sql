-- =========================================
-- ExpenseLit API - Dados de Exemplo
-- =========================================
-- Este arquivo contém dados fictícios para demonstração
-- de todos os recursos da API ExpenseLit
-- 
-- Ordem de inserção:
-- 1. Usuários do Django (auth_user)
-- 2. Membros (members_member)
-- 3. Contas (accounts_account)
-- 4. Despesas (expenses_expense)
-- 5. Receitas (revenues_revenue)
-- 6. Cartões de Crédito (credit_cards_creditcard)
-- 7. Faturas de Cartão (credit_cards_creditcardbill)
-- 8. Despesas de Cartão (credit_cards_creditcardexpense)
-- 9. Empréstimos (loans_loan)
-- 10. Transferências (transfers_transfer)

-- Limpar dados existentes (opcional - use com cuidado!)
-- TRUNCATE TABLE transfers_transfer CASCADE;
-- TRUNCATE TABLE loans_loan CASCADE;
-- TRUNCATE TABLE credit_cards_creditcardexpense CASCADE;
-- TRUNCATE TABLE credit_cards_creditcardbill CASCADE;
-- TRUNCATE TABLE credit_cards_creditcard CASCADE;
-- TRUNCATE TABLE revenues_revenue CASCADE;
-- TRUNCATE TABLE expenses_expense CASCADE;
-- TRUNCATE TABLE accounts_account CASCADE;
-- TRUNCATE TABLE members_member CASCADE;
-- TRUNCATE TABLE auth_user CASCADE;

-- =========================================
-- 1. USUÁRIOS DO DJANGO (auth_user)
-- =========================================

INSERT INTO auth_user (
    id, password, last_login, is_superuser, username, first_name, 
    last_name, email, is_staff, is_active, date_joined
) VALUES 
(1, 'pbkdf2_sha256$600000$example_hash_admin', NOW(), true, 'admin', 'Administrador', 'Sistema', 'admin@expenselit.com', true, true, '2024-01-01 00:00:00'),
(2, 'pbkdf2_sha256$600000$example_hash_joao', '2024-12-30 10:00:00', false, 'joao.silva', 'João', 'Silva', 'joao.silva@email.com', false, true, '2024-01-15 08:30:00'),
(3, 'pbkdf2_sha256$600000$example_hash_maria', '2024-12-29 14:20:00', false, 'maria.santos', 'Maria', 'Santos', 'maria.santos@email.com', false, true, '2024-02-01 09:15:00'),
(4, 'pbkdf2_sha256$600000$example_hash_carlos', '2024-12-28 16:45:00', false, 'carlos.oliveira', 'Carlos', 'Oliveira', 'carlos.oliveira@email.com', false, true, '2024-02-15 11:00:00');

-- =========================================
-- 2. MEMBROS (members_member)
-- =========================================

INSERT INTO members_member (
    id, uuid, created_at, updated_at, is_deleted, deleted_at,
    name, document, phone, email, sex, is_creditor, is_benefited, 
    active, birth_date, address, emergency_contact, monthly_income, 
    occupation, notes, user_id, created_by_id, updated_by_id
) VALUES 
-- Membros com usuário do sistema
(1, gen_random_uuid(), NOW(), NOW(), false, null,
'João Silva', '12345678901', '11999887766', 'joao.silva@email.com', 'M', 
true, true, true, '1985-05-15', 'Rua das Flores, 123 - Vila Madalena, São Paulo/SP, 01234-567', 
'Maria Silva - 11888777666', 6500.00, 'Desenvolvedor Full Stack', 
'Membro fundador da família, responsável pela tecnologia', 2, 1, 1),

(2, gen_random_uuid(), NOW(), NOW(), false, null,
'Maria Santos', '98765432109', '11888776655', 'maria.santos@email.com', 'F', 
true, true, true, '1988-12-03', 'Av. Paulista, 456 - Bela Vista, São Paulo/SP, 01310-100', 
'João Silva - 11999887766', 5800.00, 'Designer UX/UI', 
'Especialista em design e experiência do usuário', 3, 1, 1),

(3, gen_random_uuid(), NOW(), NOW(), false, null,
'Carlos Oliveira', '11122233344', '11777666555', 'carlos.oliveira@email.com', 'M', 
false, true, true, '1992-08-22', 'Rua Augusta, 789 - Consolação, São Paulo/SP, 01305-000', 
'Ana Oliveira - 11666555444', 4200.00, 'Analista de Marketing', 
'Responsável pelas estratégias de marketing digital', 4, 1, 1),

-- Membros sem usuário (apenas para empréstimos/transferências)
(4, gen_random_uuid(), NOW(), NOW(), false, null,
'Ana Paula Costa', '55566677788', '11555444333', 'ana.costa@email.com', 'F', 
true, false, true, '1990-03-10', 'Rua Oscar Freire, 321 - Jardins, São Paulo/SP, 01426-000', 
'Pedro Costa - 11444333222', 3800.00, 'Contadora', 
'Amiga da família, trabalha como contadora autônoma', null, 1, 1),

(5, gen_random_uuid(), NOW(), NOW(), false, null,
'Pedro Henrique Santos', '99988877766', '11333222111', 'pedro.santos@email.com', 'M', 
true, true, true, '1987-11-18', 'Alameda Jaú, 654 - Jardim Paulista, São Paulo/SP, 01420-001', 
'Carla Santos - 11222111000', 7200.00, 'Engenheiro de Software', 
'Primo do João, trabalha em startup de fintech', null, 1, 1),

(6, gen_random_uuid(), NOW(), NOW(), false, null,
'Fernanda Lima', '12312312312', '11666777888', 'fernanda.lima@email.com', 'F', 
false, true, true, '1995-07-25', 'Rua Haddock Lobo, 987 - Cerqueira César, São Paulo/SP, 01414-000', 
'Roberto Lima - 11555666777', 2800.00, 'Estudante de Medicina', 
'Filha de amigos da família, estudante universitária', null, 1, 2);

-- =========================================
-- 3. CONTAS (accounts_account)
-- =========================================

INSERT INTO accounts_account (
    id, uuid, created_at, updated_at, is_deleted, deleted_at,
    name, account_type, is_active, _account_number, agency, bank_code,
    current_balance, minimum_balance, opening_date, description, 
    owner_id, created_by_id, updated_by_id
) VALUES 
-- Conta principal do João (Nubank)
(1, gen_random_uuid(), NOW(), NOW(), false, null,
'NUB', 'CC', true, 'encrypted_account_number_123456789', '0001', '260',
15847.32, 0.00, '2020-01-15', 'Conta corrente principal - Nubank', 1, 1, 1),

-- Conta poupança da Maria (Sicoob)
(2, gen_random_uuid(), NOW(), NOW(), false, null,
'SIC', 'CC', true, 'encrypted_account_number_987654321', '1234', '756',
8923.45, 500.00, '2019-06-10', 'Conta corrente Sicoob - uso pessoal', 2, 1, 1),

-- Conta salário do Carlos (Caixa)
(3, gen_random_uuid(), NOW(), NOW(), false, null,
'CEF', 'CS', true, 'encrypted_account_number_456789123', '0123', '104',
3245.67, 0.00, '2022-03-01', 'Conta salário Caixa Econômica Federal', 3, 1, 1),

-- Conta digital Maria (Mercado Pago)
(4, gen_random_uuid(), NOW(), NOW(), false, null,
'MPG', 'CC', true, 'encrypted_account_number_789123456', '0001', '323',
1876.90, 0.00, '2023-05-20', 'Conta digital para gastos online', 2, 1, 2),

-- Vale alimentação João (iFood Benefícios)
(5, gen_random_uuid(), NOW(), NOW(), false, null,
'IFB', 'VA', true, null, null, '401',
456.78, 0.00, '2024-01-01', 'Vale alimentação empresa', 1, 1, 1);

-- =========================================
-- 4. DESPESAS (expenses_expense)
-- =========================================

INSERT INTO expenses_expense (
    id, uuid, created_at, updated_at, is_deleted, deleted_at,
    description, value, date, horary, category, payed, merchant, location,
    payment_method, notes, recurring, frequency, account_id, member_id,
    created_by_id, updated_by_id
) VALUES 
-- Despesas variadas por categoria
(1, gen_random_uuid(), NOW(), NOW(), false, null,
'Supermercado Extra - Compras do mês', 487.32, '2024-12-28', '19:30:00', 'supermarket', 
true, 'Extra Supermercados', 'Shopping Vila Olímpia', 'debit_card', 
'Compras mensais básicas', false, null, 1, 1, 1, 1),

(2, gen_random_uuid(), NOW(), NOW(), false, null,
'Netflix - Assinatura mensal', 29.90, '2024-12-15', '08:00:00', 'digital signs', 
true, 'Netflix Brasil', 'Online', 'credit_card', 
'Streaming de filmes e séries', true, 'monthly', 1, 1, 1, 1),

(3, gen_random_uuid(), NOW(), NOW(), false, null,
'Posto Shell - Combustível', 180.00, '2024-12-27', '14:20:00', 'transport', 
true, 'Shell', 'Av. Faria Lima, 1500', 'pix', 
'Abastecimento do carro', false, null, 1, 1, 1, 1),

(4, gen_random_uuid(), NOW(), NOW(), false, null,
'Farmácia São Paulo - Medicamentos', 145.67, '2024-12-26', '10:15:00', 'health and care', 
true, 'Farmácia São Paulo', 'Rua Augusta, 234', 'cash', 
'Medicamentos mãe', false, null, 2, 2, 2, 2),

(5, gen_random_uuid(), NOW(), NOW(), false, null,
'Restaurante Sushi Leblon', 298.50, '2024-12-24', '20:45:00', 'food and drink', 
true, 'Sushi Leblon', 'Vila Madalena', 'credit_card', 
'Jantar de Natal em família', false, null, 1, 1, 1, 1),

(6, gen_random_uuid(), NOW(), NOW(), false, null,
'Uber - Corridas do mês', 156.78, '2024-12-23', '18:30:00', 'transport', 
true, 'Uber Technologies', 'Aplicativo', 'credit_card', 
'Transporte urbano', true, 'weekly', 2, 2, 2, 2),

(7, gen_random_uuid(), NOW(), NOW(), false, null,
'Conta de Luz ENEL', 234.89, '2024-12-20', '09:00:00', 'bills and services', 
true, 'ENEL São Paulo', 'Online - Débito Automático', 'transfer', 
'Energia elétrica residência', true, 'monthly', 1, 1, 1, 1),

(8, gen_random_uuid(), NOW(), NOW(), false, null,
'Amazon - Fone Bluetooth JBL', 299.90, '2024-12-18', '15:45:00', 'electronics', 
true, 'Amazon Brasil', 'E-commerce', 'credit_card', 
'Fone de ouvido para trabalho', false, null, 2, 2, 2, 2),

(9, gen_random_uuid(), NOW(), NOW(), false, null,
'Petshop Amor & Cia - Ração Golden', 89.90, '2024-12-17', '11:20:00', 'pets', 
true, 'Petshop Amor & Cia', 'Rua da Consolação, 456', 'pix', 
'Ração para o dog Thor', true, 'monthly', 1, 1, 1, 1),

(10, gen_random_uuid(), NOW(), NOW(), false, null,
'Zara - Camisa social', 179.90, '2024-12-15', '16:30:00', 'vestuary', 
true, 'Zara Brasil', 'Shopping Iguatemi', 'debit_card', 
'Roupa para trabalho', false, null, 3, 3, 3, 3),

(11, gen_random_uuid(), NOW(), NOW(), false, null,
'Doação Casa de Apoio Criança', 100.00, '2024-12-10', '12:00:00', 'donate', 
true, 'Casa de Apoio à Criança', 'Transferência bancária', 'transfer', 
'Doação mensal para instituição', true, 'monthly', 1, 1, 1, 1),

(12, gen_random_uuid(), NOW(), NOW(), false, null,
'Curso Udemy - React Advanced', 89.90, '2024-12-08', '14:00:00', 'education', 
true, 'Udemy', 'Online', 'credit_card', 
'Curso profissionalizante', false, null, 1, 1, 1, 1),

(13, gen_random_uuid(), NOW(), NOW(), false, null,
'Cinema Cinemark - Ingressos', 68.00, '2024-12-07', '19:00:00', 'entertainment', 
true, 'Cinemark', 'Shopping Eldorado', 'cash', 
'Filme em casal', false, null, 2, 2, 2, 2),

(14, gen_random_uuid(), NOW(), NOW(), false, null,
'IPTU 2024 - Parcela 12/12', 456.78, '2024-12-05', '10:30:00', 'taxes', 
true, 'Prefeitura de São Paulo', 'Débito automático', 'transfer', 
'Última parcela do IPTU', false, null, 1, 1, 1, 1),

(15, gen_random_uuid(), NOW(), NOW(), false, null,
'Advogado Dr. Silva - Consultoria', 500.00, '2024-12-03', '15:00:00', 'professional services', 
true, 'Dr. Silva & Associados', 'Escritório Faria Lima', 'pix', 
'Consultoria jurídica imobiliária', false, null, 1, 1, 1, 1);

-- =========================================
-- 5. RECEITAS (revenues_revenue)
-- =========================================

INSERT INTO revenues_revenue (
    id, uuid, created_at, updated_at, is_deleted, deleted_at,
    description, value, date, horary, category, received, source,
    tax_amount, net_amount, notes, recurring, frequency, account_id, 
    member_id, created_by_id, updated_by_id
) VALUES 
-- Salários e receitas principais
(1, gen_random_uuid(), NOW(), NOW(), false, null,
'Salário Dezembro - Tech Solutions', 6500.00, '2024-12-30', '08:00:00', 'salary', 
true, 'Tech Solutions Ltda', 650.00, 5850.00, 'Salário mensal desenvolvedor', 
true, 'monthly', 1, 1, 1, 1),

(2, gen_random_uuid(), NOW(), NOW(), false, null,
'Salário Dezembro - Creative Agency', 5800.00, '2024-12-30', '08:00:00', 'salary', 
true, 'Creative Design Agency', 580.00, 5220.00, 'Salário mensal designer', 
true, 'monthly', 2, 2, 2, 2),

(3, gen_random_uuid(), NOW(), NOW(), false, null,
'Salário Dezembro - Marketing Pro', 4200.00, '2024-12-30', '08:00:00', 'salary', 
true, 'Marketing Pro Ltda', 420.00, 3780.00, 'Salário mensal analista', 
true, 'monthly', 3, 3, 3, 3),

-- Freelances e rendas extras
(4, gen_random_uuid(), NOW(), NOW(), false, null,
'Freelance - Website E-commerce', 2500.00, '2024-12-20', '18:30:00', 'income', 
true, 'Loja Virtual Fashion', 250.00, 2250.00, 'Desenvolvimento site completo', 
false, null, 1, 1, 1, 1),

(5, gen_random_uuid(), NOW(), NOW(), false, null,
'Design de Logo - Startup FinTech', 800.00, '2024-12-18', '14:00:00', 'income', 
true, 'FinTech Innovation', 80.00, 720.00, 'Criação de identidade visual', 
false, null, 2, 2, 2, 2),

-- Vale alimentação e benefícios
(6, gen_random_uuid(), NOW(), NOW(), false, null,
'Vale Alimentação Dezembro', 600.00, '2024-12-01', '08:00:00', 'ticket', 
true, 'Tech Solutions Ltda', 0.00, 600.00, 'Benefício alimentação mensal', 
true, 'monthly', 5, 1, 1, 1),

(7, gen_random_uuid(), NOW(), NOW(), false, null,
'Vale Alimentação Dezembro', 500.00, '2024-12-01', '08:00:00', 'ticket', 
true, 'Creative Design Agency', 0.00, 500.00, 'Benefício alimentação mensal', 
true, 'monthly', 4, 2, 2, 2),

-- Investimentos e rendimentos
(8, gen_random_uuid(), NOW(), NOW(), false, null,
'Rendimento Tesouro Direto', 145.67, '2024-12-15', '06:00:00', 'income', 
true, 'Tesouro Nacional', 21.85, 123.82, 'Rendimento títulos públicos', 
true, 'monthly', 1, 1, 1, 1),

(9, gen_random_uuid(), NOW(), NOW(), false, null,
'Dividendos Ações PETR4', 89.34, '2024-12-10', '18:00:00', 'income', 
true, 'Petrobras S.A.', 13.40, 75.94, 'Dividendos trimestrais', 
false, null, 1, 1, 1, 1),

-- Cashback e reembolsos
(10, gen_random_uuid(), NOW(), NOW(), false, null,
'Cashback Nubank Novembro', 45.67, '2024-12-05', '10:00:00', 'cashback', 
true, 'Nubank S.A.', 0.00, 45.67, 'Cashback compras cartão crédito', 
true, 'monthly', 1, 1, 1, 1),

(11, gen_random_uuid(), NOW(), NOW(), false, null,
'Reembolso Plano de Saúde', 234.56, '2024-12-08', '16:30:00', 'refund', 
true, 'Unimed São Paulo', 0.00, 234.56, 'Reembolso consulta particular', 
false, null, 2, 2, 2, 2),

-- Transferências recebidas
(12, gen_random_uuid(), NOW(), NOW(), false, null,
'Transferência João - Divisão Conta', 150.00, '2024-12-22', '20:15:00', 'transfer', 
true, 'João Silva', 0.00, 150.00, 'Divisão conta jantar família', 
false, null, 2, 2, 1, 1),

-- Prêmios e vendas
(13, gen_random_uuid(), NOW(), NOW(), false, null,
'Venda MacBook usado', 3500.00, '2024-12-12', '14:00:00', 'award', 
true, 'Comprador OLX', 0.00, 3500.00, 'Venda notebook antigo', 
false, null, 1, 1, 1, 1),

(14, gen_random_uuid(), NOW(), NOW(), false, null,
'Prêmio Mega Sena - Quadra', 892.45, '2024-12-14', '20:00:00', 'award', 
true, 'Caixa Econômica Federal', 0.00, 892.45, 'Prêmio loteria - quadra', 
false, null, 1, 1, 1, 1);

-- =========================================
-- 6. CARTÕES DE CRÉDITO (credit_cards_creditcard)
-- =========================================

INSERT INTO credit_cards_creditcard (
    id, uuid, created_at, updated_at, is_deleted, deleted_at,
    name, on_card_name, flag, validation_date, _security_code, 
    credit_limit, max_limit, _card_number, is_active, closing_day, due_day,
    interest_rate, annual_fee, notes, associated_account_id, owner_id,
    created_by_id, updated_by_id
) VALUES 
-- Cartão principal João (Nubank)
(1, gen_random_uuid(), NOW(), NOW(), false, null,
'Nubank Roxinho', 'JOAO SILVA', 'MSC', '2028-12-31', 'encrypted_cvv_123',
5000.00, 10000.00, 'encrypted_card_1234567890123456', true, 15, 10,
2.50, 0.00, 'Cartão principal sem anuidade', 1, 1, 1, 1),

-- Cartão Maria (Itaú)
(2, gen_random_uuid(), NOW(), NOW(), false, null,
'Itaú Click Visa', 'MARIA SANTOS', 'VSA', '2027-08-31', 'encrypted_cvv_456',
3000.00, 8000.00, 'encrypted_card_9876543210987654', true, 5, 25,
3.20, 120.00, 'Cartão com programa de pontos', 2, 2, 2, 2),

-- Cartão Carlos (Caixa)
(3, gen_random_uuid(), NOW(), NOW(), false, null,
'Caixa Elo Mais', 'CARLOS OLIVEIRA', 'ELO', '2029-03-31', 'encrypted_cvv_789',
2000.00, 5000.00, 'encrypted_card_5555444433332222', true, 20, 15,
2.99, 89.00, 'Cartão básico com anuidade', 3, 3, 3, 3),

-- Cartão adicional Maria (Santander)
(4, gen_random_uuid(), NOW(), NOW(), false, null,
'Santander SX Gold', 'MARIA SANTOS', 'MSC', '2026-11-30', 'encrypted_cvv_321',
4500.00, 12000.00, 'encrypted_card_1111222233334444', true, 10, 5,
2.75, 200.00, 'Cartão premium com benefícios', 4, 2, 2, 2),

-- Cartão inativo (exemplo)
(5, gen_random_uuid(), NOW(), NOW(), false, null,
'Bradesco Visa Clássico', 'JOAO SILVA', 'VSA', '2025-06-30', 'encrypted_cvv_654',
1500.00, 3000.00, 'encrypted_card_7777888899990000', false, 25, 20,
3.50, 150.00, 'Cartão cancelado - não utilizar', 1, 1, 1, 1);

-- =========================================
-- 7. FATURAS DE CARTÃO (credit_cards_creditcardbill)
-- =========================================

INSERT INTO credit_cards_creditcardbill (
    id, uuid, created_at, updated_at, is_deleted, deleted_at,
    year, month, invoice_beginning_date, invoice_ending_date, closed,
    total_amount, minimum_payment, due_date, paid_amount, payment_date,
    interest_charged, late_fee, status, credit_card_id, created_by_id, updated_by_id
) VALUES 
-- Faturas Nubank João (Cartão 1)
(1, gen_random_uuid(), NOW(), NOW(), false, null,
'2024', 'Dec', '2024-11-16', '2024-12-15', true,
1847.65, 184.77, '2025-01-10', 1847.65, '2025-01-08',
0.00, 0.00, 'paid', 1, 1, 1),

(2, gen_random_uuid(), NOW(), NOW(), false, null,
'2024', 'Nov', '2024-10-16', '2024-11-15', true,
2156.43, 215.64, '2024-12-10', 2156.43, '2024-12-09',
0.00, 0.00, 'paid', 1, 1, 1),

(3, gen_random_uuid(), NOW(), NOW(), false, null,
'2025', 'Jan', '2024-12-16', '2025-01-15', false,
892.34, 89.23, '2025-02-10', 0.00, null,
0.00, 0.00, 'open', 1, 1, 1),

-- Faturas Itaú Maria (Cartão 2)
(4, gen_random_uuid(), NOW(), NOW(), false, null,
'2024', 'Dec', '2024-11-06', '2024-12-05', true,
1345.67, 134.57, '2024-12-25', 1345.67, '2024-12-23',
0.00, 0.00, 'paid', 2, 2, 2),

(5, gen_random_uuid(), NOW(), NOW(), false, null,
'2025', 'Jan', '2024-12-06', '2025-01-05', false,
567.89, 56.79, '2025-01-25', 0.00, null,
0.00, 0.00, 'open', 2, 2, 2),

-- Faturas Caixa Carlos (Cartão 3)
(6, gen_random_uuid(), NOW(), NOW(), false, null,
'2024', 'Dec', '2024-11-21', '2024-12-20', true,
823.45, 82.35, '2025-01-15', 400.00, '2025-01-15',
45.67, 0.00, 'overdue', 3, 3, 3),

-- Faturas Santander Maria (Cartão 4)
(7, gen_random_uuid(), NOW(), NOW(), false, null,
'2024', 'Dec', '2024-11-11', '2024-12-10', true,
2789.12, 278.91, '2025-01-05', 2789.12, '2025-01-03',
0.00, 0.00, 'paid', 4, 2, 2);

-- =========================================
-- 8. DESPESAS DE CARTÃO (credit_cards_creditcardexpense)
-- =========================================

INSERT INTO credit_cards_creditcardexpense (
    id, uuid, created_at, updated_at, is_deleted, deleted_at,
    description, value, date, horary, category, installment, payed,
    total_installments, merchant, transaction_id, location, notes,
    card_id, bill_id, member_id, created_by_id, updated_by_id
) VALUES 
-- Despesas Cartão Nubank João
(1, gen_random_uuid(), NOW(), NOW(), false, null,
'Spotify Premium Familiar', 32.90, '2024-12-10', '08:15:00', 'digital signs', 
1, false, 1, 'Spotify AB', 'SPT123456789', 'Online', 
'Assinatura mensal streaming música', 1, 3, 1, 1, 1),

(2, gen_random_uuid(), NOW(), NOW(), false, null,
'MacBook Pro M3 - Apple Store', 8999.00, '2024-12-08', '15:30:00', 'electronics', 
1, false, 12, 'Apple Store Brasil', 'APL987654321', 'Shopping Villa Lobos', 
'Novo notebook para trabalho - 12x sem juros', 1, 3, 1, 1, 1),

(3, gen_random_uuid(), NOW(), NOW(), false, null,
'Jantar Famiglia Mancini', 187.50, '2024-12-05', '20:45:00', 'food and drink', 
1, false, 1, 'Famiglia Mancini', 'FAM456789123', 'Rua Avanhandava, 81', 
'Jantar comemorativo promoção', 1, 3, 1, 1, 1),

-- Despesas Cartão Itaú Maria
(4, gen_random_uuid(), NOW(), NOW(), false, null,
'Zara Home - Decoração', 456.78, '2024-12-15', '16:20:00', 'house', 
2, false, 3, 'Zara Home', 'ZAR789123456', 'Shopping Iguatemi', 
'Itens decoração sala - 3x sem juros', 2, 5, 2, 2, 2),

(5, gen_random_uuid(), NOW(), NOW(), false, null,
'Curso Adobe Creative Suite', 299.90, '2024-12-12', '11:00:00', 'education', 
1, false, 1, 'Adobe Systems', 'ADB321654987', 'Online', 
'Curso profissionalizante design', 2, 5, 2, 2, 2),

-- Despesas Cartão Caixa Carlos
(6, gen_random_uuid(), NOW(), NOW, false, null,
'Posto Ipiranga - Combustível', 220.00, '2024-12-18', '07:45:00', 'transport', 
1, false, 1, 'Posto Ipiranga', 'IPI654321789', 'Av. Rebouças, 1200', 
'Abastecimento completo', 3, 6, 3, 3, 3),

(7, gen_random_uuid(), NOW(), NOW(), false, null,
'Livraria Cultura - Livros Técnicos', 189.90, '2024-12-14', '14:30:00', 'education', 
1, false, 1, 'Livraria Cultura', 'CUL987123654', 'Shopping Bourbon', 
'Livros marketing digital', 3, 6, 3, 3, 3),

-- Despesas Cartão Santander Maria
(8, gen_random_uuid(), NOW(), NOW(), false, null,
'Viagem Rio de Janeiro - Hotel', 1200.00, '2024-12-20', '10:00:00', 'travels', 
3, false, 6, 'Copacabana Palace Hotel', 'CPH456789321', 'Rio de Janeiro/RJ', 
'Viagem final de ano - 6x sem juros', 4, 7, 2, 2, 2),

(9, gen_random_uuid(), NOW(), NOW(), false, null,
'Passagens Aéreas Rio-SP', 890.00, '2024-12-18', '09:15:00', 'travels', 
1, false, 1, 'LATAM Airlines', 'LAT789456123', 'Online', 
'Passagens ida e volta', 4, 7, 2, 2, 2),

(10, gen_random_uuid(), NOW(), NOW(), false, null,
'Presente Natal - Perfume', 280.50, '2024-12-22', '18:20:00', 'family and friends', 
1, false, 1, 'O Boticário', 'BOT123789456', 'Shopping Center Norte', 
'Presente Natal para mãe', 4, 7, 2, 2, 2);

-- =========================================
-- 9. EMPRÉSTIMOS (loans_loan)
-- =========================================

INSERT INTO loans_loan (
    id, uuid, created_at, updated_at, is_deleted, deleted_at,
    description, value, payed_value, date, horary, category, payed,
    interest_rate, installments, due_date, payment_frequency, late_fee,
    notes, status, account_id, benefited_id, creditor_id, guarantor_id,
    created_by_id, updated_by_id
) VALUES 
-- Empréstimo João para Carlos (reforma)
(1, gen_random_uuid(), NOW(), NOW(), false, null,
'Empréstimo para reforma cozinha', 5000.00, 1500.00, '2024-10-15', '14:30:00', 
'house', false, 2.00, 10, '2025-08-15', 'monthly', 50.00,
'Empréstimo para reforma da cozinha - 10 parcelas mensais', 'active', 
1, 3, 1, 2, 1, 1),

-- Empréstimo Maria para Fernanda (estudos)
(2, gen_random_uuid(), NOW(), NOW(), false, null,
'Empréstimo para matrícula faculdade', 2800.00, 800.00, '2024-11-01', '09:00:00', 
'education', false, 1.50, 12, '2025-11-01', 'monthly', 30.00,
'Ajuda com mensalidades da faculdade de medicina', 'active', 
2, 6, 2, null, 2, 2),

-- Empréstimo Pedro para Ana (emergência)
(3, gen_random_uuid(), NOW(), NOW(), false, null,
'Empréstimo emergência médica', 1200.00, 1200.00, '2024-08-20', '16:45:00', 
'health and care', true, 0.00, 1, '2024-12-20', 'monthly', 0.00,
'Empréstimo para cirurgia - já quitado', 'paid', 
1, 4, 5, null, 1, 1),

-- Empréstimo João para Pedro (investimento)
(4, gen_random_uuid(), NOW(), NOW(), false, null,
'Empréstimo para investimento negócio', 8000.00, 2000.00, '2024-09-10', '11:00:00', 
'investments', false, 2.50, 15, '2025-12-10', 'monthly', 75.00,
'Capital para startup fintech - parcelas mensais', 'active', 
1, 5, 1, 2, 1, 1),

-- Empréstimo emergencial (em atraso)
(5, gen_random_uuid(), NOW(), NOW(), false, null,
'Empréstimo emergência familiar', 3500.00, 500.00, '2024-06-15', '13:20:00', 
'family and friends', false, 3.00, 8, '2024-12-15', 'monthly', 100.00,
'Empréstimo para emergência familiar - parcelas atrasadas', 'overdue', 
2, 4, 2, 1, 2, 2);

-- =========================================
-- 10. TRANSFERÊNCIAS (transfers_transfer)
-- =========================================

INSERT INTO transfers_transfer (
    id, uuid, created_at, updated_at, is_deleted, deleted_at,
    description, value, date, horary, category, transfered, transaction_id,
    fee, exchange_rate, processed_at, confirmation_code, notes,
    origin_account_id, destiny_account_id, member_id, created_by_id, updated_by_id
) VALUES 
-- Transferência João -> Maria (divisão conta)
(1, gen_random_uuid(), NOW(), NOW(), false, null,
'Divisão conta restaurante Natal', 150.00, '2024-12-24', '21:30:00', 'pix', 
true, 'PIX240E4D8F9A2B1C5E7', 0.00, null, '2024-12-24 21:30:15', 'CONF789456',
'Divisão conta jantar família Natal', 1, 2, 1, 1, 1),

-- Transferência Maria -> Conta Poupança
(2, gen_random_uuid(), NOW(), NOW(), false, null,
'Reserva emergência mensal', 800.00, '2024-12-30', '08:00:00', 'ted', 
true, 'TED20241230080012345', 2.50, null, '2024-12-30 08:00:30', 'CONF123789',
'Transferência mensal para reserva de emergência', 2, 4, 2, 2, 2),

-- Transferência Carlos -> João (pagamento empréstimo)
(3, gen_random_uuid(), NOW(), NOW(), false, null,
'Pagamento empréstimo reforma - Parcela 4', 500.00, '2024-12-15', '18:45:00', 'pix', 
true, 'PIX240F5E9G0B3C2D6F8', 0.00, null, '2024-12-15 18:45:22', 'CONF456123',
'Quarta parcela do empréstimo para reforma', 3, 1, 3, 3, 3),

-- Transferência João -> Conta Mercado Pago
(4, gen_random_uuid(), NOW(), NOW(), false, null,
'Recarga cartão digital compras online', 500.00, '2024-12-20', '15:20:00', 'pix', 
true, 'PIX240G6F0H1C4D3E7G9', 0.00, null, '2024-12-20 15:20:08', 'CONF654321',
'Recarga para compras online fim de ano', 1, 4, 1, 1, 1),

-- Transferência Maria -> Carlos (ajuda emergencial)
(5, gen_random_uuid(), NOW(), NOW(), false, null,
'Ajuda emergencial conserto carro', 300.00, '2024-12-12', '12:15:00', 'pix', 
true, 'PIX240H7G1I2D5E4F8H0', 0.00, null, '2024-12-12 12:15:45', 'CONF987654',
'Ajuda para conserto do carro Carlos', 2, 3, 2, 2, 2),

-- Transferência entre contas João (organização)
(6, gen_random_uuid(), NOW(), NOW(), false, null,
'Organização conta salário -> principal', 1000.00, '2024-12-05', '09:30:00', 'ted', 
true, 'TED20241205093045678', 3.00, null, '2024-12-05 09:30:45', 'CONF321654',
'Transferência organizacional entre contas próprias', 1, 1, 1, 1, 1),

-- Transferência programada (futura)
(7, gen_random_uuid(), NOW(), NOW(), false, null,
'Pagamento aluguel Janeiro 2025', 1800.00, '2025-01-01', '08:00:00', 'ted', 
false, null, 3.50, null, null, null,
'Pagamento aluguel programado para início do mês', 1, 2, 1, 1, 1),

-- Transferência internacional (exemplo com câmbio)
(8, gen_random_uuid(), NOW(), NOW(), false, null,
'Pagamento curso online Coursera', 49.00, '2024-12-28', '16:00:00', 'ted', 
true, 'TED20241228160098765', 15.00, 5.25, '2024-12-28 16:05:30', 'CONF789123',
'Pagamento curso internacional - conversão USD', 1, 2, 1, 1, 1);

-- =========================================
-- SEQUENCIAS E AJUSTES FINAIS
-- =========================================

-- Ajustar sequences para próximos IDs
SELECT setval('auth_user_id_seq', (SELECT MAX(id) FROM auth_user));
SELECT setval('members_member_id_seq', (SELECT MAX(id) FROM members_member));
SELECT setval('accounts_account_id_seq', (SELECT MAX(id) FROM accounts_account));
SELECT setval('expenses_expense_id_seq', (SELECT MAX(id) FROM expenses_expense));
SELECT setval('revenues_revenue_id_seq', (SELECT MAX(id) FROM revenues_revenue));
SELECT setval('credit_cards_creditcard_id_seq', (SELECT MAX(id) FROM credit_cards_creditcard));
SELECT setval('credit_cards_creditcardbill_id_seq', (SELECT MAX(id) FROM credit_cards_creditcardbill));
SELECT setval('credit_cards_creditcardexpense_id_seq', (SELECT MAX(id) FROM credit_cards_creditcardexpense));
SELECT setval('loans_loan_id_seq', (SELECT MAX(id) FROM loans_loan));
SELECT setval('transfers_transfer_id_seq', (SELECT MAX(id) FROM transfers_transfer));

-- =========================================
-- CONSULTAS DE VERIFICAÇÃO
-- =========================================

-- Verificar dados inseridos
SELECT 'Usuários' as tabela, COUNT(*) as total FROM auth_user
UNION ALL
SELECT 'Membros', COUNT(*) FROM members_member
UNION ALL
SELECT 'Contas', COUNT(*) FROM accounts_account
UNION ALL
SELECT 'Despesas', COUNT(*) FROM expenses_expense
UNION ALL
SELECT 'Receitas', COUNT(*) FROM revenues_revenue
UNION ALL
SELECT 'Cartões', COUNT(*) FROM credit_cards_creditcard
UNION ALL
SELECT 'Faturas', COUNT(*) FROM credit_cards_creditcardbill
UNION ALL
SELECT 'Desp. Cartão', COUNT(*) FROM credit_cards_creditcardexpense
UNION ALL
SELECT 'Empréstimos', COUNT(*) FROM loans_loan
UNION ALL
SELECT 'Transferências', COUNT(*) FROM transfers_transfer;

-- =========================================
-- COMENTÁRIOS FINAIS
-- =========================================

/*
Este arquivo de exemplo contém:

✅ 4 usuários Django (admin + 3 usuários normais)
✅ 6 membros (alguns vinculados a usuários, outros não)
✅ 5 contas bancárias (diferentes tipos e instituições)
✅ 15 despesas (todas as categorias principais)
✅ 14 receitas (salários, freelances, investimentos, etc.)
✅ 5 cartões de crédito (diferentes bandeiras e limites)
✅ 7 faturas de cartão (algumas pagas, outras abertas/atrasadas)
✅ 10 despesas de cartão (parceladas e à vista)
✅ 5 empréstimos (ativos, pagos, em atraso)
✅ 8 transferências (PIX, TED, entre contas próprias)

Dados realísticos incluindo:
- Valores monetários variados e realistas
- Datas distribuídas ao longo do tempo
- Relacionamentos corretos entre tabelas
- Exemplos de criptografia (campos _security_code, _card_number, _account_number)
- Status variados (ativo/inativo, pago/pendente, etc.)
- Categorias diversificadas
- Observações detalhadas

Para usar:
1. Execute este SQL em seu banco PostgreSQL
2. Verifique os dados com as consultas de verificação
3. Use os dados para testar a API
4. Ajuste valores conforme necessário
*/