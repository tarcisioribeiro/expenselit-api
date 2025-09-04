from django.db import models
from django.core.exceptions import ValidationError
from accounts.models import Account
from expenses.models import EXPENSES_CATEGORIES
from app.encryption import FieldEncryption
from app.models import BaseModel, BILL_STATUS_CHOICES


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


class CreditCard(BaseModel):
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
    _card_number = models.TextField(
        verbose_name="Número do Cartão (Criptografado)",
        null=True,
        blank=True,
        help_text="Campo criptografado"
    )
    is_active = models.BooleanField(
        verbose_name="Ativo",
        default=True
    )
    closing_day = models.IntegerField(
        verbose_name="Dia de Fechamento",
        null=True,
        blank=True,
        help_text="Dia do mês em que a fatura fecha"
    )
    due_day = models.IntegerField(
        verbose_name="Dia de Vencimento",
        null=True,
        blank=True,
        help_text="Dia do mês em que a fatura vence"
    )
    interest_rate = models.DecimalField(
        verbose_name="Taxa de Juros (%)",
        max_digits=5,
        decimal_places=2,
        null=True,
        blank=True
    )
    annual_fee = models.DecimalField(
        verbose_name="Anuidade",
        max_digits=10,
        decimal_places=2,
        null=True,
        blank=True
    )
    owner = models.ForeignKey(
        'members.Member',
        on_delete=models.PROTECT,
        verbose_name="Proprietário",
        null=True,
        blank=True
    )
    notes = models.TextField(
        verbose_name="Observações",
        null=True,
        blank=True
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

        Returns
        -------
        str or None
            Código de segurança (CVV) descriptografado ou None em caso de erro.
        """
        try:
            return FieldEncryption.decrypt_data(self._security_code)
        except ValidationError:
            return None

    @security_code.setter
    def security_code(self, value):
        """
        Setter para criptografar o CVV antes de salvá-lo.

        Parameters
        ----------
        value : str or None
            Código de segurança (CVV) de 3 ou 4 dígitos.

        Raises
        ------
        ValidationError
            Se o CVV não for numérico ou não tiver 3 ou 4 dígitos.
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

    @property
    def card_number(self):
        """
        Propriedade para descriptografar o número do cartão.

        Returns
        -------
        str or None
            Número do cartão descriptografado ou None se não existir.
        """
        if self._card_number:
            try:
                return FieldEncryption.decrypt_data(self._card_number)
            except Exception:
                return None
        return None

    @property
    def card_number_masked(self):
        """
        Propriedade para retornar o número do cartão mascarado.

        Returns
        -------
        str or None
            Número do cartão mascarado (****1234) ou None se não existir.
        """
        if self._card_number:
            try:
                full_number = FieldEncryption.decrypt_data(self._card_number)
                if full_number and len(full_number) >= 4:
                    return '*' * (len(full_number) - 4) + full_number[-4:]
                return full_number
            except Exception:
                return None
        return None

    @card_number.setter
    def card_number(self, value):
        """
        Setter para criptografar o número do cartão.

        Parameters
        ----------
        value : str or None
            Número do cartão a ser criptografado.
        """
        if value:
            self._card_number = FieldEncryption.encrypt_data(str(value))
        else:
            self._card_number = None

    def clean(self):
        """
        Validação customizada do modelo.

        Raises
        ------
        ValidationError
            Se a data de validade for anterior ou igual à data atual.
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

        Parameters
        ----------
        *args
            Argumentos posicionais do método save.
        **kwargs
            Argumentos nomeados do método save.
        """
        self.full_clean()
        super().save(*args, **kwargs)


class CreditCardBill(BaseModel):
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
    total_amount = models.DecimalField(
        verbose_name="Valor Total",
        max_digits=10,
        decimal_places=2,
        default=0.00
    )
    minimum_payment = models.DecimalField(
        verbose_name="Pagamento Mínimo",
        max_digits=10,
        decimal_places=2,
        default=0.00
    )
    due_date = models.DateField(
        verbose_name="Data de Vencimento",
        null=True,
        blank=True
    )
    paid_amount = models.DecimalField(
        verbose_name="Valor Pago",
        max_digits=10,
        decimal_places=2,
        default=0.00
    )
    payment_date = models.DateField(
        verbose_name="Data do Pagamento",
        null=True,
        blank=True
    )
    interest_charged = models.DecimalField(
        verbose_name="Juros Cobrados",
        max_digits=10,
        decimal_places=2,
        default=0.00
    )
    late_fee = models.DecimalField(
        verbose_name="Multa por Atraso",
        max_digits=10,
        decimal_places=2,
        default=0.00
    )
    status = models.CharField(
        max_length=20,
        choices=BILL_STATUS_CHOICES,
        verbose_name="Status",
        default='open'
    )

    class Meta:
        verbose_name = "Fatura"
        verbose_name_plural = "Faturas"

    def __str__(self):
        return f"{self.credit_card} - {self.year}/{self.month}"


class CreditCardExpense(BaseModel):
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
    total_installments = models.IntegerField(
        verbose_name="Total de Parcelas",
        default=1
    )
    merchant = models.CharField(
        max_length=200,
        verbose_name="Estabelecimento",
        null=True,
        blank=True
    )
    transaction_id = models.CharField(
        max_length=100,
        verbose_name="ID da Transação",
        null=True,
        blank=True
    )
    location = models.CharField(
        max_length=200,
        verbose_name="Local da Compra",
        null=True,
        blank=True
    )
    bill = models.ForeignKey(
        CreditCardBill,
        on_delete=models.PROTECT,
        verbose_name="Fatura Associada",
        null=True,
        blank=True
    )
    member = models.ForeignKey(
        'members.Member',
        on_delete=models.PROTECT,
        verbose_name="Membro Responsável",
        null=True,
        blank=True
    )
    notes = models.TextField(
        verbose_name="Observações",
        null=True,
        blank=True
    )
    receipt = models.FileField(
        upload_to='credit_cards/receipts/',
        verbose_name="Comprovante",
        null=True,
        blank=True
    )

    class Meta:
        ordering = ['-id']
        verbose_name = "Despesa de Cartão"
        verbose_name_plural = "Despesas de Cartão"

    def __str__(self):
        return f"{self.description},{self.card} - {self.date},{self.horary}"
