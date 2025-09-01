-- ExpenseLit API - Consultas de Exemplo
-- Arquivo com consultas úteis para demonstrar o uso dos dados inseridos

-- ==============================================================================
-- 1. ANÁLISE DE DESPESAS POR CATEGORIA
-- ==============================================================================
SELECT 
    e.category as categoria,
    COUNT(*) as quantidade_transacoes,
    SUM(e.value) as total_gasto,
    AVG(e.value) as media_por_transacao,
    MIN(e.value) as menor_gasto,
    MAX(e.value) as maior_gasto
FROM expenses_expense e
WHERE e.payed = true
GROUP BY e.category
ORDER BY total_gasto DESC;

-- ==============================================================================
-- 2. MEMBROS E SUAS RECEITAS/DESPESAS TOTAIS
-- ==============================================================================
SELECT 
    m.name as membro,
    m.occupation as profissao,
    m.monthly_income as renda_mensal,
    COUNT(DISTINCT r.id) as qtd_receitas,
    COALESCE(SUM(r.net_amount), 0) as total_receitas_liquidas,
    COUNT(DISTINCT e.id) as qtd_despesas,
    COALESCE(SUM(e.value), 0) as total_despesas,
    COALESCE(SUM(r.net_amount), 0) - COALESCE(SUM(e.value), 0) as saldo_periodo
FROM members_member m
LEFT JOIN revenues_revenue r ON m.id = r.member_id
LEFT JOIN expenses_expense e ON m.id = e.member_id
GROUP BY m.id, m.name, m.occupation, m.monthly_income
ORDER BY saldo_periodo DESC;

-- ==============================================================================
-- 3. RESUMO FINANCEIRO POR CONTA
-- ==============================================================================
SELECT 
    a.name as conta,
    a.account_type as tipo,
    a.current_balance as saldo_atual,
    COUNT(DISTINCT e.id) as despesas_realizadas,
    COALESCE(SUM(CASE WHEN e.payed = true THEN e.value ELSE 0 END), 0) as total_despesas_pagas,
    COUNT(DISTINCT r.id) as receitas_recebidas,
    COALESCE(SUM(CASE WHEN r.received = true THEN r.net_amount ELSE 0 END), 0) as total_receitas_liquidas,
    COUNT(DISTINCT t_out.id) as transferencias_enviadas,
    COALESCE(SUM(t_out.value), 0) as valor_transferido_out,
    COUNT(DISTINCT t_in.id) as transferencias_recebidas,
    COALESCE(SUM(t_in.value), 0) as valor_transferido_in
FROM accounts_account a
LEFT JOIN expenses_expense e ON a.id = e.account_id
LEFT JOIN revenues_revenue r ON a.id = r.account_id
LEFT JOIN transfers_transfer t_out ON a.id = t_out.origin_account_id
LEFT JOIN transfers_transfer t_in ON a.id = t_in.destiny_account_id
GROUP BY a.id, a.name, a.account_type, a.current_balance
ORDER BY a.current_balance DESC;

-- ==============================================================================
-- 4. ANÁLISE DE CARTÕES DE CRÉDITO E FATURAS
-- ==============================================================================
SELECT 
    cc.name as cartao,
    cc.flag as bandeira,
    cc.credit_limit as limite_credito,
    cc.max_limit as limite_maximo,
    COUNT(DISTINCT ccb.id) as faturas_geradas,
    COALESCE(SUM(ccb.total_amount), 0) as valor_total_faturas,
    COALESCE(SUM(ccb.paid_amount), 0) as valor_pago,
    COUNT(DISTINCT cce.id) as despesas_cartao,
    COALESCE(SUM(cce.value), 0) as total_gasto_cartao,
    cc.credit_limit - COALESCE(SUM(cce.value), 0) as limite_disponivel
FROM credit_cards_creditcard cc
LEFT JOIN credit_cards_creditcardbill ccb ON cc.id = ccb.credit_card_id
LEFT JOIN credit_cards_creditcardexpense cce ON cc.id = cce.card_id AND cce.payed = false
GROUP BY cc.id, cc.name, cc.flag, cc.credit_limit, cc.max_limit
ORDER BY cc.name;

-- ==============================================================================
-- 5. EMPRÉSTIMOS - STATUS E SITUAÇÃO DE PAGAMENTO
-- ==============================================================================
SELECT 
    l.description as descricao,
    l.category as categoria,
    mb.name as beneficiado,
    mc.name as credor,
    l.value as valor_total,
    l.payed_value as valor_pago,
    l.value - l.payed_value as valor_pendente,
    l.installments as parcelas_total,
    l.interest_rate as taxa_juros,
    l.due_date as vencimento,
    l.status as status_atual,
    CASE 
        WHEN l.payed = true THEN 'Quitado'
        WHEN l.due_date < CURRENT_DATE THEN 'Vencido'
        ELSE 'Em dia'
    END as situacao
FROM loans_loan l
JOIN members_member mb ON l.benefited_id = mb.id
JOIN members_member mc ON l.creditor_id = mc.id
ORDER BY l.due_date ASC;

-- ==============================================================================
-- 6. TRANSFERÊNCIAS - FLUXO ENTRE CONTAS
-- ==============================================================================
SELECT 
    t.description as descricao,
    t.category as tipo_transferencia,
    ao.name as conta_origem,
    ad.name as conta_destino,
    t.value as valor,
    t.fee as taxa_cobranca,
    t.date as data_transferencia,
    t.transfered as foi_transferido,
    CASE 
        WHEN t.transfered = true THEN 'Concluído'
        ELSE 'Pendente'
    END as status
FROM transfers_transfer t
JOIN accounts_account ao ON t.origin_account_id = ao.id
JOIN accounts_account ad ON t.destiny_account_id = ad.id
ORDER BY t.date DESC;

-- ==============================================================================
-- 7. DESPESAS RECORRENTES - ANÁLISE DE ASSINATURAS
-- ==============================================================================
SELECT 
    e.description as descricao,
    e.category as categoria,
    e.value as valor_mensal,
    e.frequency as frequencia,
    a.name as conta_debito,
    m.name as responsavel,
    e.value * 12 as impacto_anual_estimado
FROM expenses_expense e
JOIN accounts_account a ON e.account_id = a.id
LEFT JOIN members_member m ON e.member_id = m.id
WHERE e.recurring = true
ORDER BY e.value DESC;

-- ==============================================================================
-- 8. ANÁLISE DE CASHFLOW MENSAL (AGOSTO 2024)
-- ==============================================================================
WITH receitas_mes AS (
    SELECT 
        SUM(net_amount) as total_receitas,
        COUNT(*) as qtd_receitas
    FROM revenues_revenue 
    WHERE date >= '2024-08-01' AND date <= '2024-08-31'
    AND received = true
),
despesas_mes AS (
    SELECT 
        SUM(value) as total_despesas,
        COUNT(*) as qtd_despesas
    FROM expenses_expense 
    WHERE date >= '2024-08-01' AND date <= '2024-08-31'
    AND payed = true
),
cartao_mes AS (
    SELECT 
        SUM(value) as total_cartao,
        COUNT(*) as qtd_cartao
    FROM credit_cards_creditcardexpense 
    WHERE date >= '2024-08-01' AND date <= '2024-08-31'
)
SELECT 
    r.total_receitas,
    r.qtd_receitas,
    d.total_despesas,
    d.qtd_despesas,
    c.total_cartao,
    c.qtd_cartao,
    r.total_receitas - (d.total_despesas + c.total_cartao) as saldo_liquido_mes,
    ROUND(((r.total_receitas - (d.total_despesas + c.total_cartao)) / r.total_receitas) * 100, 2) as percentual_economia
FROM receitas_mes r, despesas_mes d, cartao_mes c;

-- ==============================================================================
-- 9. TOP ESTABELECIMENTOS - ONDE MAIS SE GASTA
-- ==============================================================================
SELECT 
    COALESCE(e.merchant, 'Não informado') as estabelecimento,
    COUNT(*) as transacoes,
    SUM(e.value) as total_gasto,
    AVG(e.value) as ticket_medio
FROM expenses_expense e
WHERE e.merchant IS NOT NULL AND e.payed = true
GROUP BY e.merchant
UNION ALL
SELECT 
    COALESCE(cce.merchant, 'Não informado') as estabelecimento,
    COUNT(*) as transacoes,
    SUM(cce.value) as total_gasto,
    AVG(cce.value) as ticket_medio
FROM credit_cards_creditcardexpense cce
WHERE cce.merchant IS NOT NULL
GROUP BY cce.merchant
ORDER BY total_gasto DESC
LIMIT 10;

-- ==============================================================================
-- 10. AUDITORIA - ÚLTIMAS MODIFICAÇÕES
-- ==============================================================================
SELECT 
    'Despesas' as tabela,
    description as descricao,
    value as valor,
    updated_at as ultima_modificacao
FROM expenses_expense
WHERE updated_at >= (CURRENT_DATE - INTERVAL '30 days')
UNION ALL
SELECT 
    'Receitas' as tabela,
    description as descricao,
    value as valor,
    updated_at as ultima_modificacao
FROM revenues_revenue
WHERE updated_at >= (CURRENT_DATE - INTERVAL '30 days')
UNION ALL
SELECT 
    'Transferências' as tabela,
    description as descricao,
    value as valor,
    updated_at as ultima_modificacao
FROM transfers_transfer
WHERE updated_at >= (CURRENT_DATE - INTERVAL '30 days')
ORDER BY ultima_modificacao DESC
LIMIT 20;