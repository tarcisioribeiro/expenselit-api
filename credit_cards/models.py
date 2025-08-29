from django.db import models
from django.core.exceptions import ValidationError
from accounts.models import Account
from expenses.models import EXPENSES_CATEGORIES
from app.encryption import FieldEncryption


FLAGS = (
    ('MSC', 'Master Card'),
    ('VSA', 'Visa'),
    ('ELO', 'Elo'),
    ('EXP', 'American Express'),
    ('HCD', 'Hipercard'),
)

YEARS = (
    ('2025', '2025'),
    ('2026', '2026'),
    ('2027', '2027'),
    ('2028', '2028'),
    ('2029', '2029'),
    ('2030', '2030')
)

MONTHS = (
    ('Jan', 'Janeiro'),
    ('Feb', 'Fevereiro'),
    ('Mar', 'Março'),
    ('Apr', 'Abril'),
    ('May', 'Maio'),
    ('Jun', 'Junho'),
    ('Jul', 'Julho'),
    ('Aug', 'Agosto'),
    ('Sep', 'Setembro'),
    ('Oct', 'Outubro'),
    ('Nov', 'Novembro'),
    ('Dec', 'Dezembro')
)


class CreditCard(models.Model):
    name = models.CharField(
        max_length=200,
        null=False,
        blank=False,
        verbose_name="Nome"
    )
    on_card_name = models.CharField(
        max_length=200,
        null=False,
        blank=False,
        verbose_name="Nome no cartão"
    )
    flag = models.CharField(
        max_length=200,
        choices=FLAGS,
        null=False,
        blank=False,
        verbose_name="Bandeira",
    )
    validation_date = models.DateField(
        verbose_name="Data de Validade",
        null=False,
        blank=False
    )
    _security_code = models.TextField(
        verbose_name="Código de Segurança (Criptografado)",
        blank=False,
        null=False,
        default='123',
        help_text="Campo criptografado para armazenar o CVV"
    )
    credit_limit = models.DecimalField(
        verbose_name="Limite de crédito",
        null=False,
        blank=False,
        decimal_places=2,
        max_digits=10
    )
    max_limit = models.DecimalField(
        verbose_name="Limite Máximo",
        null=False,
        blank=False,
        decimal_places=2,
        max_digits=10
    )
    associated_account = models.ForeignKey(
        Account,
        on_delete=models.PROTECT,
        null=False,
        blank=False,
        verbose_name="Conta associada"
    )

    class Meta:
        verbose_name = "Cartão de Crédito"
        verbose_name_plural = "Cartões de Crédito"

    def __str__(self):
        return self.name

    @property
    def security_code(self):
        """
        Propriedade para descriptografar o CVV ao acessá-lo.
        """
        try:
            return FieldEncryption.decrypt_data(self._security_code)
        except ValidationError:
            return None

    @security_code.setter
    def security_code(self, value):
        """
        Setter para criptografar o CVV antes de salvá-lo.
        """
        if value is not None:
            # Validação básica do CVV (3 ou 4 dígitos)
            if not str(value).isdigit() or len(str(value)) not in [3, 4]:
                raise ValidationError(
                    "CVV deve conter 3 ou 4 dígitos numéricos"
                )
            self._security_code = FieldEncryption.encrypt_data(str(value))
        else:
            self._security_code = None

    def clean(self):
        """
        Validação customizada do modelo.
        """
        super().clean()

        # Validação da data de validade
        from datetime import date
        if self.validation_date and self.validation_date <= date.today():
            raise ValidationError(
                "Data de validade não pode ser anterior ou igual à data atual"
            )

    def save(self, *args, **kwargs):
        """
        Override do save para executar validações.
        """
        self.full_clean()
        super().save(*args, **kwargs)


class CreditCardBill(models.Model):
    credit_card = models.ForeignKey(
        CreditCard,
        on_delete=models.PROTECT,
        null=False,
        blank=False,
        verbose_name="Cartão"
    )
    year = models.CharField(
        verbose_name="Ano",
        blank=False,
        null=False,
        choices=YEARS
    )
    month = models.CharField(
        verbose_name="Mês",
        blank=False,
        null=False,
        choices=MONTHS
    )
    invoice_beginning_date = models.DateField(
        verbose_name="Data de começo da fatura",
        null=False,
        blank=False
    )
    invoice_ending_date = models.DateField(
        verbose_name="Data de fim da fatura",
        null=False,
        blank=False
    )
    closed = models.BooleanField(
        verbose_name="Fechada"
    )

    class Meta:
        verbose_name = "Fatura"
        verbose_name_plural = "Faturas"

    def __str__(self):
        return f"{self.credit_card} - {self.year}/{self.month}"


class CreditCardExpense(models.Model):
    description = models.CharField(
        max_length=200,
        null=False,
        blank=False,
        verbose_name="Descrição"
    )
    value = models.DecimalField(
        verbose_name="Valor",
        blank=False,
        null=False,
        decimal_places=2,
        max_digits=10
    )
    date = models.DateField(
        null=False,
        blank=False,
        verbose_name="Data"
    )
    horary = models.TimeField(
        null=False,
        blank=False,
        verbose_name="Horário"
    )
    category = models.CharField(
        max_length=200,
        choices=EXPENSES_CATEGORIES,
        null=False,
        blank=False,
        verbose_name="Categoria"
    )
    card = models.ForeignKey(
        CreditCard,
        on_delete=models.PROTECT,
        null=False,
        blank=False,
        verbose_name="Cartão"
    )
    installment = models.PositiveIntegerField(
        verbose_name="Parcela",
        null=False,
        blank=False
    )
    payed = models.BooleanField(
        verbose_name="Paga",
    )

    class Meta:
        ordering = ['-id']
        verbose_name = "Despesa de Cartão"
        verbose_name_plural = "Despesas de Cartão"

    def __str__(self):
        return f"{self.description},{self.card} - {self.date},{self.horary}"
