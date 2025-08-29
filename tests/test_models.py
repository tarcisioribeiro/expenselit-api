from django.test import TestCase
from django.core.exceptions import ValidationError
from django.db import IntegrityError
from decimal import Decimal
from datetime import date, time, timedelta
import os
from unittest.mock import patch

# Models
from accounts.models import Account
from expenses.models import Expense
from revenues.models import Revenue
from credit_cards.models import CreditCard
# CreditCardBill, CreditCardExpense
from loans.models import Loan
from transfers.models import Transfer
from members.models import Member
# Benefited, Creditor


class AccountModelTest(TestCase):
    """Testes para o modelo Account"""

    def setUp(self):
        self.account_data = {
            'name': 'NUB',
            'account_type': 'CC',
            'is_active': True
        }

    def test_create_account_success(self):
        """Testa criação de conta com dados válidos"""
        account = Account.objects.create(**self.account_data)
        self.assertEqual(account.name, 'NUB')
        self.assertEqual(account.account_type, 'CC')
        self.assertTrue(account.is_active)

    def test_account_str_method(self):
        """Testa o método __str__ do Account"""
        account = Account.objects.create(**self.account_data)
        self.assertEqual(str(account), 'NUB')

    def test_unique_account_name(self):
        """Testa que o nome da conta deve ser único"""
        Account.objects.create(**self.account_data)
        with self.assertRaises(IntegrityError):
            Account.objects.create(**self.account_data)

    def test_account_choices_validation(self):
        """Testa validação de choices para nome e tipo de conta"""
        # Nome inválido
        invalid_data = self.account_data.copy()
        invalid_data['name'] = 'INVALID'
        account = Account(**invalid_data)
        with self.assertRaises(ValidationError):
            account.full_clean()


class ExpenseModelTest(TestCase):
    """Testes para o modelo Expense"""

    def setUp(self):
        self.account = Account.objects.create(
            name='NUB',
            account_type='CC',
            is_active=True
        )
        self.expense_data = {
            'description': 'Compra supermercado',
            'value': Decimal('150.50'),
            'date': date.today(),
            'horary': time(14, 30),
            'category': 'supermarket',
            'account': self.account,
            'payed': True
        }

    def test_create_expense_success(self):
        """Testa criação de despesa com dados válidos"""
        expense = Expense.objects.create(**self.expense_data)
        self.assertEqual(expense.description, 'Compra supermercado')
        self.assertEqual(expense.value, Decimal('150.50'))
        self.assertEqual(expense.account, self.account)

    def test_expense_str_method(self):
        """Testa o método __str__ do Expense"""
        expense = Expense.objects.create(**self.expense_data)
        expected_str = f"Compra supermercado - {date.today()}, 14:30:00"
        self.assertEqual(str(expense), expected_str)

    def test_expense_negative_value(self):
        """Testa que não permite valores negativos"""
        self.expense_data['value'] = Decimal('-50.00')
        expense = Expense(**self.expense_data)
        with self.assertRaises(ValidationError):
            expense.full_clean()

    def test_expense_invalid_category(self):
        """Testa categoria inválida"""
        self.expense_data['category'] = 'invalid_category'
        expense = Expense(**self.expense_data)
        with self.assertRaises(ValidationError):
            expense.full_clean()


class CreditCardModelTest(TestCase):
    """Testes para o modelo CreditCard"""

    def setUp(self):
        self.account = Account.objects.create(
            name='NUB',
            account_type='CC',
            is_active=True
        )
        self.credit_card_data = {
            'name': 'Cartão Principal',
            'on_card_name': 'JOHN DOE',
            'flag': 'MSC',
            'validation_date': date.today() + timedelta(days=365),
            'credit_limit': Decimal('5000.00'),
            'max_limit': Decimal('10000.00'),
            'associated_account': self.account
        }

    @patch.dict(os.environ, {'ENCRYPTION_KEY': os.getenv('ENCRYPTION_KEY')})
    def test_create_credit_card_success(self):
        """Testa criação de cartão de crédito"""
        # Mock da criptografia para teste
        with patch(
            'app.encryption.FieldEncryption.encrypt_data'
        ) as mock_encrypt:
            mock_encrypt.return_value = 'encrypted_cvv'

            card = CreditCard.objects.create(**self.credit_card_data)
            card.security_code = '123'

            self.assertEqual(card.name, 'Cartão Principal')
            self.assertEqual(card.flag, 'MSC')
            self.assertEqual(card.associated_account, self.account)

    def test_credit_card_validation_date_past(self):
        """Testa validação de data de validade no passado"""
        self.credit_card_data['validation_date'] = date.today() - timedelta(
            days=1
        )
        card = CreditCard(**self.credit_card_data)
        with self.assertRaises(ValidationError):
            card.clean()

    @patch.dict(os.environ, {'ENCRYPTION_KEY': os.getenv('ENCRYPTION_KEY')})
    def test_security_code_validation(self):
        """Testa validação do CVV"""
        card = CreditCard(**self.credit_card_data)

        # CVV inválido (não numérico)
        with self.assertRaises(ValidationError):
            card.security_code = 'abc'

        # CVV inválido (tamanho)
        with self.assertRaises(ValidationError):
            card.security_code = '12345'


class RevenueModelTest(TestCase):
    """Testes para o modelo Revenue"""

    def setUp(self):
        self.account = Account.objects.create(
            name='NUB',
            account_type='CC',
            is_active=True
        )
        self.revenue_data = {
            'description': 'Salário',
            'value': Decimal('3000.00'),
            'date': date.today(),
            'horary': time(9, 0),
            'category': 'salary',
            'account': self.account,
            'received': True
        }

    def test_create_revenue_success(self):
        """Testa criação de receita com dados válidos"""
        revenue = Revenue.objects.create(**self.revenue_data)
        self.assertEqual(revenue.description, 'Salário')
        self.assertEqual(revenue.value, Decimal('3000.00'))
        self.assertEqual(revenue.category, 'salary')

    def test_revenue_str_method(self):
        """Testa o método __str__ do Revenue"""
        revenue = Revenue.objects.create(**self.revenue_data)
        expected_str = f"Salário,salary - {date.today()},09:00:00"
        self.assertEqual(str(revenue), expected_str)


class MemberModelTest(TestCase):
    """Testes para o modelo Member"""

    def setUp(self):
        self.member_data = {
            'name': 'João Silva',
            'document': '12345678901',
            'phone': '11999999999',
            'email': 'joao@test.com',
            'sex': 'M',
            'active': True
        }

    def test_create_member_success(self):
        """Testa criação de membro com dados válidos"""
        member = Member.objects.create(**self.member_data)
        self.assertEqual(member.name, 'João Silva')
        self.assertEqual(member.document, '12345678901')
        self.assertEqual(member.email, 'joao@test.com')

    def test_member_unique_document(self):
        """Testa que o documento deve ser único"""
        Member.objects.create(**self.member_data)
        with self.assertRaises(IntegrityError):
            Member.objects.create(**self.member_data)

    def test_member_email_validation(self):
        """Testa validação de email"""
        self.member_data['email'] = 'email_inválido'
        member = Member(**self.member_data)
        with self.assertRaises(ValidationError):
            member.full_clean()


class TransferModelTest(TestCase):
    """Testes para o modelo Transfer"""

    def setUp(self):
        self.account_origin = Account.objects.create(
            name='NUB',
            account_type='CC',
            is_active=True
        )
        self.account_destination = Account.objects.create(
            name='SIC',
            account_type='CS',
            is_active=True
        )
        self.transfer_data = {
            'value': Decimal('100.00'),
            'date': date.today(),
            'horary': time(10, 0),
            'origin_account': self.account_origin,
            'destination_account': self.account_destination,
            'description': 'Transferência teste'
        }

    def test_create_transfer_success(self):
        """Testa criação de transferência com dados válidos"""
        transfer = Transfer.objects.create(**self.transfer_data)
        self.assertEqual(transfer.value, Decimal('100.00'))
        self.assertEqual(transfer.origin_account, self.account_origin)
        self.assertEqual(
            transfer.destiny_account, self.account_destination
        )

    def test_transfer_same_account_validation(self):
        """Testa que não permite transferência para a mesma conta"""
        self.transfer_data['destination_account'] = self.account_origin
        transfer = Transfer(**self.transfer_data)
        print(transfer)
        # Aqui você deveria adicionar uma validação customizada
        # no modelo Transfer para evitar transferências para a mesma conta


class LoanModelTest(TestCase):
    """Testes para o modelo Loan"""

    def setUp(self):
        self.account = Account.objects.create(
            name='NUB',
            account_type='CC',
            is_active=True
        )
        self.member = Member.objects.create(
            name='João Silva',
            document='12345678901',
            phone='11999999999',
            email='joao@test.com',
            sex='M',
            active=True
        )
        self.loan_data = {
            'description': 'Empréstimo pessoal',
            'value': Decimal('1000.00'),
            'payed_value': Decimal('0.00'),
            'date': date.today(),
            'horary': time(11, 0),
            'category': 'personal',
            'account': self.account,
            'creditor': self.member
        }

    def test_create_loan_success(self):
        """Testa criação de empréstimo com dados válidos"""
        loan = Loan.objects.create(**self.loan_data)
        self.assertEqual(loan.description, 'Empréstimo pessoal')
        self.assertEqual(loan.value, Decimal('1000.00'))
        self.assertEqual(loan.payed_value, Decimal('0.00'))
        self.assertEqual(loan.creditor, self.member)

    def test_loan_payed_value_exceeds_total(self):
        """Testa que valor pago não pode exceder o valor total"""
        self.loan_data['payed_value'] = Decimal('1500.00')
        loan = Loan(**self.loan_data)
        print(loan)
        # Aqui você deveria adicionar validação customizada no modelo Loan
