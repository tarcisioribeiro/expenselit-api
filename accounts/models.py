from django.db import models
from app.models import BaseModel
from app.encryption import FieldEncryption


ACCOUNT_TYPES = (
    ('CC', 'Conta Corrente'),
    ('CS', 'Conta Salário'),
    ('FG', 'Fundo de Garantia'),
    ('VA', 'Vale Alimentação')
)

ACCOUNT_NAMES = (
    ('NUB', 'Nubank'),
    ('SIC', 'Sicoob'),
    ('MPG', 'Mercado Pago'),
    ('IFB', 'Ifood Benefícios'),
    ('CEF', 'Caixa Econômica Federal')
)


class Account(BaseModel):
    name = models.CharField(
        max_length=200,
        choices=ACCOUNT_NAMES,
        null=False,
        blank=False,
        unique=True,
        verbose_name="Nome"
    )
    account_type = models.CharField(
        max_length=100,
        choices=ACCOUNT_TYPES,
        verbose_name="Tipo de Conta"
    )
    account_image = models.ImageField(
        upload_to='accounts/',
        blank=True,
        null=True,
        verbose_name="Logo da conta"
    )
    is_active = models.BooleanField(
        verbose_name="Ativa",
        default=True
    )
    _account_number = models.TextField(
        verbose_name="Número da Conta (Criptografado)",
        null=True,
        blank=True,
        help_text="Campo criptografado"
    )
    agency = models.CharField(
        max_length=20,
        verbose_name="Agência",
        null=True,
        blank=True
    )
    bank_code = models.CharField(
        max_length=10,
        verbose_name="Código do Banco",
        null=True,
        blank=True
    )
    current_balance = models.DecimalField(
        verbose_name="Saldo Atual",
        max_digits=15,
        decimal_places=2,
        default=0.00
    )
    minimum_balance = models.DecimalField(
        verbose_name="Saldo Mínimo",
        max_digits=15,
        decimal_places=2,
        default=0.00
    )
    opening_date = models.DateField(
        verbose_name="Data de Abertura",
        null=True,
        blank=True
    )
    description = models.TextField(
        verbose_name="Descrição/Observações",
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

    class Meta:
        ordering = ['-name']
        verbose_name = "Conta"
        verbose_name_plural = "Contas"

    @property
    def account_number(self):
        """
        Propriedade para descriptografar o número da conta.
        
        Returns
        -------
        str or None
            Número da conta descriptografado ou None se não existir.
        """
        if self._account_number:
            try:
                return FieldEncryption.decrypt_data(self._account_number)
            except:
                return None
        return None

    @account_number.setter
    def account_number(self, value):
        """
        Setter para criptografar o número da conta.
        
        Parameters
        ----------
        value : str or None
            Número da conta a ser criptografado.
        """
        if value:
            self._account_number = FieldEncryption.encrypt_data(str(value))
        else:
            self._account_number = None

    def __str__(self):
        return self.name
