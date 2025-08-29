from django.db import models
from accounts.models import Account
from expenses.models import EXPENSES_CATEGORIES
from members.models import Member


class Loan(models.Model):
    description = models.CharField(
        max_length=200,
        verbose_name='Descrição',
        null=False,
        blank=False
    )
    value = models.DecimalField(
        verbose_name="Valor",
        null=False,
        blank=False,
        max_digits=10,
        decimal_places=2
    )
    payed_value = models.DecimalField(
        verbose_name="Valor Pago",
        null=False,
        blank=False,
        max_digits=10,
        decimal_places=2
    )
    date = models.DateField(verbose_name="Data", null=False, blank=False)
    horary = models.TimeField(verbose_name="Horário", null=False, blank=False)
    category = models.CharField(
        max_length=200,
        choices=EXPENSES_CATEGORIES,
        null=False,
        blank=False,
        verbose_name="Categoria"
    )
    account = models.ForeignKey(
        Account,
        on_delete=models.PROTECT,
        null=False,
        blank=False,
        verbose_name="Conta"
    )
    benefited = models.ForeignKey(
        Member,
        on_delete=models.PROTECT,
        null=False,
        blank=False,
        verbose_name="Beneficiado",
        related_name="Benefited"
    )
    creditor = models.ForeignKey(
        Member,
        on_delete=models.PROTECT,
        null=False,
        blank=False,
        verbose_name="Credor",
        related_name="Creditor"
    )
    payed = models.BooleanField(verbose_name="Pago")

    class Meta:
        ordering = ['-date']
        verbose_name = "Empréstimo"
        verbose_name_plural = "Empréstimos"

    def __str__(self):
        return f"{
            self.description
        },{self.category} - {self.date},{self.horary}"
