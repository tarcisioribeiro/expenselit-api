from django.db import models


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


class Account(models.Model):
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

    class Meta:
        ordering = ['-name']
        verbose_name = "Conta"
        verbose_name_plural = "Contas"

    def __str__(self):
        return self.name
