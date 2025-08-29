from django.db import models
from accounts.models import Account


REVENUES_CATEGORIES = (
    ('deposit', 'Depósito'),
    ('award', 'Prêmio'),
    ('salary', 'Salário'),
    ('ticket', 'Vale'),
    ('income', 'Rendimentos'),
    ('refund', 'Reembolso'),
    ('cashback', 'Cashback'),
    ('transfer', 'Transferência Recebida'),
    ('received_loan', 'Empréstimo Recebido'),
    ('loan_devolution', 'Devolução de empréstimo'),
)


class Revenue(models.Model):
    description = models.CharField(
        max_length=200,
        null=False,
        blank=False,
        verbose_name="Descrição"
    )
    value = models.DecimalField(
        verbose_name="Valor",
        null=False,
        blank=False,
        max_digits=10,
        decimal_places=2
    )
    date = models.DateField(
        verbose_name="Data",
        null=False,
        blank=False
    )
    horary = models.TimeField(
        verbose_name="Horário",
        null=False,
        blank=False
    )
    category = models.CharField(
        max_length=200,
        choices=REVENUES_CATEGORIES,
        null=False,
        blank=False,
        verbose_name="Categoria"
    )
    account = models.ForeignKey(
        Account,
        on_delete=models.PROTECT,
        null=False,
        blank=False,
        verbose_name="Conta",
    )
    received = models.BooleanField(verbose_name="Recebido")

    class Meta:
        ordering = ['-date']
        verbose_name = "Receita"
        verbose_name_plural = "Receitas"
        indexes = [
            models.Index(fields=['-date']),
            models.Index(fields=['category', 'date']),
            models.Index(fields=['account', 'date']),
            models.Index(fields=['received', 'date']),
            models.Index(fields=['account', 'category']),
        ]

    def __str__(self):
        return f"{
            self.description
            },{
                self.category
            } - {
                self.date
            },{
                self.horary
            }"
