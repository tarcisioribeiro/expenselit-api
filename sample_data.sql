-- ExpenseLit API - Dados de exemplo
-- Arquivo SQL com dados relevantes para popular o banco de dados

-- ==============================================================================
-- INSERINDO USUÁRIOS DO DJANGO
-- ==============================================================================
INSERT INTO auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined)
VALUES 
(1, 'pbkdf2_sha256$600000$sample$hash', NULL, false, 'tarcisio', 'Tarcísio', 'Silva', 'tarcisio@expenselit.com', false, true, '2024-01-15 10:00:00'),
(2, 'pbkdf2_sha256$600000$sample$hash', NULL, false, 'maria', 'Maria', 'Santos', 'maria@expenselit.com', false, true, '2024-01-20 11:30:00'),
(3, 'pbkdf2_sha256$600000$sample$hash', NULL, false, 'joao', 'João', 'Oliveira', 'joao@expenselit.com', false, true, '2024-02-01 09:15:00');

-- ==============================================================================
-- INSERINDO MEMBROS
-- ==============================================================================
INSERT INTO members_member (id, uuid, created_at, updated_at, created_by_id, updated_by_id, is_deleted, deleted_at, name, document, phone, email, sex, user_id, is_creditor, is_benefited, active, birth_date, address, profile_photo, emergency_contact, monthly_income, occupation, notes)
VALUES 
(1, gen_random_uuid(), '2024-01-15 10:00:00', '2024-01-15 10:00:00', 1, 1, false, NULL, 'Tarcísio Silva', '12345678901', '(11) 99999-1234', 'tarcisio@expenselit.com', 'M', 1, true, true, true, '1990-05-15', 'Rua das Flores, 123 - São Paulo, SP', '', '(11) 99999-5678', 8500.00, 'Desenvolvedor', 'Membro fundador'),
(2, gen_random_uuid(), '2024-01-20 11:30:00', '2024-01-20 11:30:00', 1, 1, false, NULL, 'Maria Santos', '98765432109', '(11) 88888-4321', 'maria@expenselit.com', 'F', 2, true, true, true, '1985-08-22', 'Av. Principal, 456 - São Paulo, SP', '', '(11) 88888-8765', 6200.00, 'Designer', 'Especialista em UX/UI'),
(3, gen_random_uuid(), '2024-02-01 09:15:00', '2024-02-01 09:15:00', 1, 1, false, NULL, 'João Oliveira', '11122233344', '(11) 77777-9876', 'joao@expenselit.com', 'M', 3, true, true, true, '1988-12-03', 'Rua da Paz, 789 - São Paulo, SP', '', '(11) 77777-1234', 7300.00, 'Analista', 'Especialista em dados'),
(4, gen_random_uuid(), '2024-02-05 14:20:00', '2024-02-05 14:20:00', 1, 1, false, NULL, 'Ana Costa', '55566677788', '(11) 66666-5555', 'ana@gmail.com', 'F', NULL, false, true, true, '1992-03-18', 'Rua Verde, 321 - São Paulo, SP', '', '(11) 66666-9999', 4800.00, 'Assistente', 'Membro beneficiário'),
(5, gen_random_uuid(), '2024-02-10 16:45:00', '2024-02-10 16:45:00', 1, 1, false, NULL, 'Carlos Ferreira', '99988877766', '(11) 55555-4444', 'carlos@gmail.com', 'M', NULL, true, false, true, '1980-11-30', 'Av. Central, 654 - São Paulo, SP', '', '(11) 55555-8888', 12000.00, 'Empresário', 'Credor principal');

-- ==============================================================================
-- INSERINDO CONTAS
-- ==============================================================================
INSERT INTO accounts_account (id, uuid, created_at, updated_at, created_by_id, updated_by_id, is_deleted, deleted_at, name, account_type, account_image, is_active, _account_number, agency, bank_code, current_balance, minimum_balance, opening_date, description, owner_id)
VALUES 
(1, gen_random_uuid(), '2024-01-15 10:30:00', '2024-01-15 10:30:00', 1, 1, false, NULL, 'NUB', 'CC', '', true, NULL, '0001', '260', 5420.75, 0.00, '2023-01-15', 'Conta principal para despesas gerais', 1),
(2, gen_random_uuid(), '2024-01-20 12:00:00', '2024-01-20 12:00:00', 1, 1, false, NULL, 'SIC', 'CS', '', true, NULL, '4321', '756', 3200.50, 0.00, '2023-02-01', 'Conta salário', 2),
(3, gen_random_uuid(), '2024-01-25 15:15:00', '2024-01-25 15:15:00', 1, 1, false, NULL, 'MPG', 'CC', '', true, NULL, '0001', '323', 1850.30, 0.00, '2023-03-10', 'Conta para pagamentos digitais', 1),
(4, gen_random_uuid(), '2024-02-01 09:45:00', '2024-02-01 09:45:00', 1, 1, false, NULL, 'IFB', 'VA', '', true, NULL, '', '', 450.00, 0.00, '2023-04-01', 'Vale alimentação', 3),
(5, gen_random_uuid(), '2024-02-05 11:20:00', '2024-02-05 11:20:00', 1, 1, false, NULL, 'CEF', 'FG', '', false, NULL, '1234', '104', 2300.80, 0.00, '2022-12-15', 'Fundo de garantia', 1);

-- ==============================================================================
-- INSERINDO CARTÕES DE CRÉDITO
-- ==============================================================================
INSERT INTO credit_cards_creditcard (id, uuid, created_at, updated_at, created_by_id, updated_by_id, is_deleted, deleted_at, name, on_card_name, flag, validation_date, _security_code, credit_limit, max_limit, associated_account_id, _card_number, is_active, closing_day, due_day, interest_rate, annual_fee, owner_id, notes)
VALUES 
(1, gen_random_uuid(), '2024-01-15 11:00:00', '2024-01-15 11:00:00', 1, 1, false, NULL, 'Nubank Roxinho', 'TARCISIO SILVA', 'MSC', '2028-12-31', 'encrypted_cvv_123', 8000.00, 10000.00, 1, 'encrypted_card_number', true, 15, 25, 13.75, 0.00, 1, 'Cartão principal sem anuidade'),
(2, gen_random_uuid(), '2024-01-20 13:30:00', '2024-01-20 13:30:00', 1, 1, false, NULL, 'Sicoob Visa', 'MARIA SANTOS', 'VSA', '2027-08-31', 'encrypted_cvv_456', 5000.00, 6000.00, 2, 'encrypted_card_number_2', true, 10, 20, 15.90, 120.00, 2, 'Cartão cooperativo'),
(3, gen_random_uuid(), '2024-02-01 10:15:00', '2024-02-01 10:15:00', 1, 1, false, NULL, 'Mercado Pago Gold', 'JOAO OLIVEIRA', 'ELO', '2029-06-30', 'encrypted_cvv_789', 3500.00, 4000.00, 3, 'encrypted_card_number_3', true, 5, 15, 12.99, 0.00, 3, 'Cartão digital');

-- ==============================================================================
-- INSERINDO FATURAS DE CARTÃO
-- ==============================================================================
INSERT INTO credit_cards_creditcardbill (id, uuid, created_at, updated_at, created_by_id, updated_by_id, is_deleted, deleted_at, credit_card_id, year, month, invoice_beginning_date, invoice_ending_date, closed, total_amount, minimum_payment, due_date, paid_amount, payment_date, interest_charged, late_fee, status)
VALUES 
(1, gen_random_uuid(), '2024-08-15 00:00:00', '2024-08-25 18:30:00', 1, 1, false, NULL, 1, '2024', 'Aug', '2024-07-16', '2024-08-15', true, 1250.75, 125.08, '2024-08-25', 1250.75, '2024-08-24', 0.00, 0.00, 'paid'),
(2, gen_random_uuid(), '2024-09-15 00:00:00', '2024-09-15 00:00:00', 1, 1, false, NULL, 1, '2024', 'Sep', '2024-08-16', '2024-09-15', true, 890.45, 89.05, '2024-09-25', 0.00, NULL, 0.00, 0.00, 'closed'),
(3, gen_random_uuid(), '2024-08-10 00:00:00', '2024-08-20 19:15:00', 1, 1, false, NULL, 2, '2024', 'Aug', '2024-07-11', '2024-08-10', true, 567.30, 56.73, '2024-08-20', 567.30, '2024-08-19', 0.00, 0.00, 'paid'),
(4, gen_random_uuid(), '2024-09-10 00:00:00', '2024-09-10 00:00:00', 1, 1, false, NULL, 2, '2024', 'Sep', '2024-08-11', '2024-09-10', false, 432.80, 43.28, '2024-09-20', 0.00, NULL, 0.00, 0.00, 'open');

-- ==============================================================================
-- INSERINDO DESPESAS
-- ==============================================================================
INSERT INTO expenses_expense (id, uuid, created_at, updated_at, created_by_id, updated_by_id, is_deleted, deleted_at, description, value, date, horary, category, account_id, payed, merchant, location, payment_method, receipt, member_id, notes, recurring, frequency)
VALUES 
(1, gen_random_uuid(), '2024-08-25 20:30:00', '2024-08-25 20:30:00', 1, 1, false, NULL, 'Supermercado Pão de Açúcar', 185.67, '2024-08-25', '20:30:00', 'supermarket', 1, true, 'Pão de Açúcar', 'Shopping Eldorado', 'debit_card', '', 1, 'Compras da semana', false, NULL),
(2, gen_random_uuid(), '2024-08-24 12:15:00', '2024-08-24 12:15:00', 2, 2, false, NULL, 'Almoço iFood', 35.90, '2024-08-24', '12:15:00', 'food and drink', 2, true, 'Restaurante Bom Sabor', 'Delivery', 'pix', '', 2, 'Almoço do trabalho', false, NULL),
(3, gen_random_uuid(), '2024-08-23 19:45:00', '2024-08-23 19:45:00', 3, 3, false, NULL, 'Combustível', 120.00, '2024-08-23', '19:45:00', 'transport', 3, true, 'Posto Shell', 'Av. Paulista', 'debit_card', '', 3, 'Abastecimento carro', false, NULL),
(4, gen_random_uuid(), '2024-08-22 10:20:00', '2024-08-22 10:20:00', 1, 1, false, NULL, 'Netflix', 25.90, '2024-08-22', '10:20:00', 'digital signs', 1, true, 'Netflix', 'Online', 'credit_card', '', 1, 'Assinatura mensal', true, 'monthly'),
(5, gen_random_uuid(), '2024-08-21 15:30:00', '2024-08-21 15:30:00', 2, 2, false, NULL, 'Farmácia', 67.45, '2024-08-21', '15:30:00', 'health and care', 2, true, 'Droga Raia', 'Rua Augusta', 'debit_card', '', 2, 'Medicamentos', false, NULL),
(6, gen_random_uuid(), '2024-08-20 18:00:00', '2024-08-20 18:00:00', 1, 1, false, NULL, 'Conta de Luz', 189.34, '2024-08-20', '18:00:00', 'bills and services', 1, true, 'Enel', 'Online', 'pix', '', 1, 'Conta de energia elétrica', true, 'monthly'),
(7, gen_random_uuid(), '2024-08-19 21:15:00', '2024-08-19 21:15:00', 3, 3, false, NULL, 'Cinema', 45.00, '2024-08-19', '21:15:00', 'entertainment', 3, true, 'Cinemark', 'Shopping Center Norte', 'debit_card', '', 3, 'Filme com amigos', false, NULL),
(8, gen_random_uuid(), '2024-08-18 14:25:00', '2024-08-18 14:25:00', 1, 1, false, NULL, 'Uber', 28.50, '2024-08-18', '14:25:00', 'transport', 1, true, 'Uber', 'São Paulo', 'credit_card', '', 1, 'Corrida para o centro', false, NULL),
(9, gen_random_uuid(), '2024-08-17 11:40:00', '2024-08-17 11:40:00', 2, 2, false, NULL, 'Loja de Roupas', 299.90, '2024-08-17', '11:40:00', 'vestuary', 2, false, 'Renner', 'Shopping Ibirapuera', 'credit_card', '', 2, 'Roupas para o trabalho', false, NULL),
(10, gen_random_uuid(), '2024-08-16 16:50:00', '2024-08-16 16:50:00', 3, 3, false, NULL, 'Seguro do Carro', 450.00, '2024-08-16', '16:50:00', 'transport', 3, true, 'Porto Seguro', 'Online', 'pix', '', 3, 'Pagamento mensal do seguro', true, 'monthly');

-- ==============================================================================
-- INSERINDO DESPESAS DE CARTÃO DE CRÉDITO
-- ==============================================================================
INSERT INTO credit_cards_creditcardexpense (id, uuid, created_at, updated_at, created_by_id, updated_by_id, is_deleted, deleted_at, description, value, date, horary, category, card_id, installment, payed, total_installments, merchant, transaction_id, location, bill_id, member_id, notes, receipt)
VALUES 
(1, gen_random_uuid(), '2024-08-15 19:30:00', '2024-08-15 19:30:00', 1, 1, false, NULL, 'Jantar Restaurante', 150.80, '2024-08-15', '19:30:00', 'food and drink', 1, 1, true, 1, 'Outback', 'TXN001', 'Shopping Vila Olimpia', 1, 1, 'Jantar de negócios', ''),
(2, gen_random_uuid(), '2024-08-12 10:15:00', '2024-08-12 10:15:00', 1, 1, false, NULL, 'Compras Amazon', 450.90, '2024-08-12', '10:15:00', 'electronics', 1, 3, false, 12, 'Amazon', 'AMZ002', 'Online', 1, 1, 'Notebook gamer - parcela 3/12', ''),
(3, gen_random_uuid(), '2024-08-10 14:45:00', '2024-08-10 14:45:00', 2, 2, false, NULL, 'Curso Online', 199.99, '2024-08-10', '14:45:00', 'education', 2, 1, true, 1, 'Udemy', 'EDU003', 'Online', 3, 2, 'Curso de Python', ''),
(4, gen_random_uuid(), '2024-08-08 16:20:00', '2024-08-08 16:20:00', 3, 3, false, NULL, 'Pet Shop', 89.50, '2024-08-08', '16:20:00', 'pets', 3, 1, true, 1, 'Cobasi', 'PET004', 'Shopping ABC', NULL, 3, 'Ração e acessórios', ''),
(5, gen_random_uuid(), '2024-08-05 11:10:00', '2024-08-05 11:10:00', 1, 1, false, NULL, 'Spotify Premium', 21.90, '2024-08-05', '11:10:00', 'digital signs', 1, 1, true, 1, 'Spotify', 'SPT005', 'Online', 1, 1, 'Assinatura familiar', '');

-- ==============================================================================
-- INSERINDO RECEITAS
-- ==============================================================================
INSERT INTO revenues_revenue (id, uuid, created_at, updated_at, created_by_id, updated_by_id, is_deleted, deleted_at, description, value, date, horary, category, account_id, received, source, tax_amount, net_amount, member_id, receipt, recurring, frequency, notes)
VALUES 
(1, gen_random_uuid(), '2024-08-01 09:00:00', '2024-08-01 09:00:00', 1, 1, false, NULL, 'Salário Agosto', 8500.00, '2024-08-01', '09:00:00', 'salary', 1, true, 'Empresa XYZ Ltda', 1275.00, 7225.00, 1, '', true, 'monthly', 'Salário mensal'),
(2, gen_random_uuid(), '2024-08-01 10:30:00', '2024-08-01 10:30:00', 2, 2, false, NULL, 'Salário Agosto', 6200.00, '2024-08-01', '10:30:00', 'salary', 2, true, 'Design Studio ABC', 930.00, 5270.00, 2, '', true, 'monthly', 'Salário mensal'),
(3, gen_random_uuid(), '2024-08-01 11:45:00', '2024-08-01 11:45:00', 3, 3, false, NULL, 'Salário Agosto', 7300.00, '2024-08-01', '11:45:00', 'salary', 3, true, 'Tech Solutions Ltda', 1095.00, 6205.00, 3, '', true, 'monthly', 'Salário mensal'),
(4, gen_random_uuid(), '2024-08-15 14:20:00', '2024-08-15 14:20:00', 1, 1, false, NULL, 'Vale Alimentação', 600.00, '2024-08-15', '14:20:00', 'ticket', 4, true, 'Empresa XYZ Ltda', 0.00, 600.00, 1, '', true, 'monthly', 'VA mensal'),
(5, gen_random_uuid(), '2024-08-10 16:30:00', '2024-08-10 16:30:00', 1, 1, false, NULL, 'Freelance Desenvolvimento', 2500.00, '2024-08-10', '16:30:00', 'income', 3, true, 'Cliente Freelance', 187.50, 2312.50, 1, '', false, NULL, 'Projeto website'),
(6, gen_random_uuid(), '2024-08-20 13:15:00', '2024-08-20 13:15:00', 2, 2, false, NULL, 'Cashback Cartão', 45.80, '2024-08-20', '13:15:00', 'cashback', 2, true, 'Banco Sicoob', 0.00, 45.80, 2, '', false, NULL, 'Cashback do mês'),
(7, gen_random_uuid(), '2024-08-25 17:45:00', '2024-08-25 17:45:00', 3, 3, false, NULL, 'Venda Produto Online', 890.00, '2024-08-25', '17:45:00', 'income', 1, true, 'Mercado Livre', 133.50, 756.50, 3, '', false, NULL, 'Venda eletrônicos'),
(8, gen_random_uuid(), '2024-08-12 12:00:00', '2024-08-12 12:00:00', 1, 1, false, NULL, 'Rendimento Poupança', 125.30, '2024-08-12', '12:00:00', 'income', 1, true, 'Nubank', 0.00, 125.30, 1, '', false, NULL, 'Rendimento mensal'),
(9, gen_random_uuid(), '2024-08-18 10:20:00', '2024-08-18 10:20:00', 2, 2, false, NULL, 'Reembolso Médico', 350.00, '2024-08-18', '10:20:00', 'refund', 2, true, 'Plano de Saúde ABC', 0.00, 350.00, 2, '', false, NULL, 'Consulta especialista'),
(10, gen_random_uuid(), '2024-08-22 15:10:00', '2024-08-22 15:10:00', 5, 1, false, NULL, 'Transferência Recebida', 1500.00, '2024-08-22', '15:10:00', 'transfer', 1, true, 'Carlos Ferreira', 0.00, 1500.00, 1, '', false, NULL, 'Empréstimo pessoal');

-- ==============================================================================
-- INSERINDO EMPRÉSTIMOS
-- ==============================================================================
INSERT INTO loans_loan (id, uuid, created_at, updated_at, created_by_id, updated_by_id, is_deleted, deleted_at, description, value, payed_value, date, horary, category, account_id, benefited_id, creditor_id, payed, interest_rate, installments, due_date, contract_document, payment_frequency, late_fee, guarantor_id, notes, status)
VALUES 
(1, gen_random_uuid(), '2024-07-15 10:00:00', '2024-08-15 10:30:00', 1, 1, false, NULL, 'Empréstimo para Carro', 25000.00, 5000.00, '2024-07-15', '10:00:00', 'transport', 1, 1, 5, false, 2.50, 24, '2026-07-15', '', 'monthly', 150.00, NULL, 'Financiamento veículo usado', 'active'),
(2, gen_random_uuid(), '2024-06-01 14:30:00', '2024-08-01 14:30:00', 2, 2, false, NULL, 'Empréstimo Emergência', 3000.00, 1500.00, '2024-06-01', '14:30:00', 'others', 2, 2, 1, false, 1.80, 12, '2025-06-01', '', 'monthly', 80.00, 3, 'Emergência médica família', 'active'),
(3, gen_random_uuid(), '2024-05-10 09:15:00', '2024-08-25 16:20:00', 3, 3, false, NULL, 'Empréstimo Reforma Casa', 15000.00, 15000.00, '2024-05-10', '09:15:00', 'house', 3, 3, 5, true, 3.20, 18, '2025-11-10', '', 'monthly', 200.00, 1, 'Reforma completa cozinha', 'paid'),
(4, gen_random_uuid(), '2024-08-01 11:45:00', '2024-08-01 11:45:00', 1, 1, false, NULL, 'Empréstimo Estudos', 8000.00, 0.00, '2024-08-01', '11:45:00', 'education', 1, 4, 5, false, 1.50, 36, '2027-08-01', '', 'monthly', 100.00, 1, 'Pós-graduação', 'active'),
(5, gen_random_uuid(), '2024-07-20 16:30:00', '2024-08-20 16:30:00', 5, 5, false, NULL, 'Empréstimo Negócio', 50000.00, 10000.00, '2024-07-20', '16:30:00', 'investments', 1, 1, 5, false, 4.00, 48, '2028-07-20', '', 'monthly', 500.00, 2, 'Capital de giro empresa', 'active');

-- ==============================================================================
-- INSERINDO TRANSFERÊNCIAS
-- ==============================================================================
INSERT INTO transfers_transfer (id, uuid, created_at, updated_at, created_by_id, updated_by_id, is_deleted, deleted_at, description, value, date, horary, category, origin_account_id, destiny_account_id, transfered, transaction_id, fee, exchange_rate, processed_at, confirmation_code, notes, receipt, member_id)
VALUES 
(1, gen_random_uuid(), '2024-08-25 14:30:00', '2024-08-25 14:30:00', 1, 1, false, NULL, 'Transferência para Poupança', 1000.00, '2024-08-25', '14:30:00', 'pix', 1, 3, true, 'PIX001', 0.00, NULL, '2024-08-25 14:31:00', 'CONF001', 'Reserva de emergência', '', 1),
(2, gen_random_uuid(), '2024-08-20 10:15:00', '2024-08-20 10:15:00', 2, 2, false, NULL, 'Pagamento Freelance', 500.00, '2024-08-20', '10:15:00', 'ted', 2, 1, true, 'TED002', 15.90, NULL, '2024-08-20 10:45:00', 'CONF002', 'Pagamento serviço design', '', 2),
(3, gen_random_uuid(), '2024-08-18 16:45:00', '2024-08-18 16:45:00', 3, 3, false, NULL, 'Transferência Família', 300.00, '2024-08-18', '16:45:00', 'pix', 3, 2, true, 'PIX003', 0.00, NULL, '2024-08-18 16:46:00', 'CONF003', 'Ajuda com despesas', '', 3),
(4, gen_random_uuid(), '2024-08-15 12:20:00', '2024-08-15 12:20:00', 1, 1, false, NULL, 'Investimento CDB', 2500.00, '2024-08-15', '12:20:00', 'doc', 1, 5, true, 'DOC004', 35.00, NULL, '2024-08-16 09:00:00', 'CONF004', 'Aplicação financeira', '', 1),
(5, gen_random_uuid(), '2024-08-10 09:30:00', '2024-08-10 09:30:00', 1, 1, false, NULL, 'Pagamento Fornecedor', 1250.00, '2024-08-10', '09:30:00', 'ted', 3, 1, true, 'TED005', 25.50, NULL, '2024-08-10 11:15:00', 'CONF005', 'Pagamento serviços', '', 1),
(6, gen_random_uuid(), '2024-08-05 13:40:00', '2024-08-05 13:40:00', 2, 2, false, NULL, 'Divisão Conta Restaurante', 125.50, '2024-08-05', '13:40:00', 'pix', 2, 3, true, 'PIX006', 0.00, NULL, '2024-08-05 13:41:00', 'CONF006', 'Jantar dividido entre amigos', '', 2),
(7, gen_random_uuid(), '2024-08-22 11:00:00', '2024-08-22 11:00:00', 3, 3, false, NULL, 'Empréstimo Devolvido', 800.00, '2024-08-22', '11:00:00', 'pix', 1, 3, true, 'PIX007', 0.00, NULL, '2024-08-22 11:01:00', 'CONF007', 'Devolução empréstimo pessoal', '', 1),
(8, gen_random_uuid(), '2024-08-12 15:25:00', '2024-08-12 15:25:00', 1, 1, false, NULL, 'Pagamento Aluguel', 1800.00, '2024-08-12', '15:25:00', 'pix', 1, 2, true, 'PIX008', 0.00, NULL, '2024-08-12 15:26:00', 'CONF008', 'Aluguel apartamento', '', 1),
(9, gen_random_uuid(), '2024-08-28 17:10:00', '2024-08-28 17:10:00', 2, 2, false, NULL, 'Presente Aniversário', 200.00, '2024-08-28', '17:10:00', 'pix', 2, 1, false, 'PIX009', 0.00, NULL, NULL, 'PEND009', 'Presente para João', '', 2),
(10, gen_random_uuid(), '2024-08-30 19:50:00', '2024-08-30 19:50:00', 3, 3, false, NULL, 'Reserva Viagem', 3500.00, '2024-08-30', '19:50:00', 'ted', 3, 1, true, 'TED010', 45.00, NULL, '2024-08-31 10:30:00', 'CONF010', 'Reserva pacote férias', '', 3);

-- ==============================================================================
-- ATUALIZANDO SEQUENCES (NECESSÁRIO PARA PostgreSQL)
-- ==============================================================================
SELECT setval('auth_user_id_seq', (SELECT MAX(id) FROM auth_user));
SELECT setval('members_member_id_seq', (SELECT MAX(id) FROM members_member));
SELECT setval('accounts_account_id_seq', (SELECT MAX(id) FROM accounts_account));
SELECT setval('credit_cards_creditcard_id_seq', (SELECT MAX(id) FROM credit_cards_creditcard));
SELECT setval('credit_cards_creditcardbill_id_seq', (SELECT MAX(id) FROM credit_cards_creditcardbill));
SELECT setval('expenses_expense_id_seq', (SELECT MAX(id) FROM expenses_expense));
SELECT setval('credit_cards_creditcardexpense_id_seq', (SELECT MAX(id) FROM credit_cards_creditcardexpense));
SELECT setval('revenues_revenue_id_seq', (SELECT MAX(id) FROM revenues_revenue));
SELECT setval('loans_loan_id_seq', (SELECT MAX(id) FROM loans_loan));
SELECT setval('transfers_transfer_id_seq', (SELECT MAX(id) FROM transfers_transfer));

-- ==============================================================================
-- RESUMO DOS DADOS INSERIDOS
-- ==============================================================================
-- Usuários: 3 registros
-- Membros: 5 registros (3 com usuários do sistema, 2 sem)
-- Contas: 5 registros (diferentes tipos: CC, CS, VA, FG)
-- Cartões de Crédito: 3 registros (diferentes bandeiras)
-- Faturas: 4 registros (algumas pagas, outras em aberto)
-- Despesas: 10 registros (variadas categorias e métodos de pagamento)
-- Despesas de Cartão: 5 registros (diferentes parcelas e estabelecimentos)
-- Receitas: 10 registros (salários, freelances, cashbacks, etc.)
-- Empréstimos: 5 registros (diferentes status e finalidades)
-- Transferências: 10 registros (PIX, TED, DOC)
-- ==============================================================================